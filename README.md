# PMSM Motor Monitoring

Sistem za analizu i nadzor rada **permanent magnet synchronous (PMSM)** motora, zasnovan na datasetu prikupljenom od strane LEA odeljenja na Univerzitetu u Paderbornu. Implementiran u C# koristeći WCF servis, manipulaciju fajlovima, delegate i događaje.

---

## O projektu

Aplikacija simulira real-time nadzor PMSM elektromotora. Klijent čita CSV dataset red po red i šalje uzorke WCF servisu koji ih validira, snima na disk i analizira. Kada se detektuje anomalija (nagli skok struje ili temperature rashladne tečnosti), servis podiže odgovarajuće događaje.

Dataset: [Kaggle — Electric Motor Temperature](https://www.kaggle.com/datasets/wkirgsn/electric-motor-temperature)

---

## Arhitektura

```
Klijent  ──►  WCF Servis (netTcpBinding)  ──►  Disk (CSV fajlovi)
               │
               ├── Validacija uzoraka
               ├── Analitika 1: ΔId, ΔIq detekcija
               └── Analitika 2: ΔT detekcija + running mean
```

Komunikacija se odvija preko `net.tcp://localhost:4101/Motor` sa `netTcpBinding` u streaming modu.

---

## Struktura projekta

```
Solution/
├── Common/                  # DataContract modeli, ServiceContract interfejs, Fault tipovi
├── Server/                  # WCF implementacija, analitika, file I/O
│   ├── MotorService.cs      # Glavna servisna klasa
│   └── MotorSessionWriter.cs# Upravljanje CSV tokovima
├── Client/                  # CSV parser, WCF proxy, sekvencijalni sender
│   └── Program.cs
└── app.config               # Pragovi i binding konfiguracija
```

---

## Ključne funkcionalnosti

### WCF servis
- `StartSession` — otvara novu sesiju, kreira CSV fajlove na disku
- `PushSample` — prima i validira jedan uzorak, upisuje ga ili odbacuje
- `EndSession` — zatvara sesiju, oslobađa resurse
- Odgovori: `ACK/NACK` + status `IN_PROGRESS/COMPLETED`
- Fault tipovi: `DataFormatFault`, `ValidationFault`

### File I/O
- `measurements_session.csv` — validni uzorci po sesiji
- `rejects.csv` — odbačena merenja sa razlogom odbijanja
- Klijent loguje nevalidne CSV redove u `rejects_client.csv`

### IDisposable pattern
- `MotorSessionWriter` implementira `IDisposable` sa pravilnim zatvaranjem `FileStream` i `StreamWriter` tokova
- Resursi se oslobađaju i pri normalnom završetku i pri izuzetku (prekid veze)

### Delegati i događaji

| Događaj | Okidač |
|---|---|
| `OnTransferStarted` | Uspešno pokretanje sesije |
| `OnSampleReceived` | Svaki primljeni validan uzorak |
| `OnTransferCompleted` | Završetak sesije |
| `OnWarningRaised` | Opšta upozorenja |
| `OnElectricSpikeQ` | `\|ΔIq\| > Iq_threshold` |
| `OnElectricSpikeD` | `\|ΔId\| > Id_threshold` |
| `OnTemperatureSpike` | `\|ΔT\| > T_threshold` |
| `OnOutOfBandWarning` | Odstupanje coolant-a ±25% od tekućeg proseka |

### Analitika 1 — strujne komponente
Za uzastopne uzorke računa se:

```
ΔIq = Iq[n] − Iq[n−1]
ΔId = Id[n] − Id[n−1]
```

Ako `|ΔIq| > Iq_threshold` → podiže se `OnElectricSpikeQ` sa smerom (`iznad/ispod očekivanog`).  
Ako `|ΔId| > Id_threshold` → podiže se `OnElectricSpikeD` sa smerom.

### Analitika 2 — rashladna tečnost
Za uzastopne uzorke računa se:

```
ΔT = coolant[n] − coolant[n−1]
```

Ako `|ΔT| > T_threshold` → podiže se `OnTemperatureSpike` sa smerom.  
Paralelno se prati tekući prosek `Tmean` (running mean). Ako `coolant < 0.75·Tmean` ili `coolant > 1.25·Tmean` → podiže se `OnOutOfBandWarning`.

---

## Konfiguracija

Pragovi se definišu u `app.config`:

```xml
<appSettings>
  <add key="Iq_threshold" value="1.0" />
  <add key="Id_threshold" value="1.0" />
  <add key="T_threshold" value="5.0" />
  <add key="DeviationPercent" value="25" />
  <add key="motorStoragePath" value="MotorStorage" />
</appSettings>
```

---

## Pokretanje

1. Pokrenuti **Server** projekat — servis sluša na `net.tcp://localhost:4101/Motor`
2. Pokrenuti **Client** projekat — učitava CSV i šalje uzorke sekvencijalno

Simulacija prekida veze:
```
Client.exe simulate
```

---

## Tehnologije

- C# / .NET Framework
- WCF (`netTcpBinding`, streaming mod)
- `FileStream`, `StreamWriter` za file I/O
- Delegate/Event pattern
- Dataset: Kaggle Electric Motor Temperature (LEA, Univerzitet Paderborn)

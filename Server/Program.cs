using System;
using System.ServiceModel;

namespace Server
{
    public class Program
    {
        static void Main(string[] args)
        {
            MotorService service = null;
            ServiceHost motorHost = null;

            try
            {
                service = new MotorService();

                service.OnTransferStarted += (sessionId, startTime) =>
                    Console.WriteLine($"[DOGADJAJ] Sesija zapoceta: {sessionId} u {startTime}");

                service.OnSampleReceived += (count) =>
                    Console.WriteLine($"[DOGADJAJ] Primljen uzorak broj: {count}");

                service.OnTransferCompleted += (sessionId, count) =>
                    Console.WriteLine($"[DOGADJAJ] Sesija zavrsena: {sessionId}. Ukupno uzoraka: {count}");

                service.OnWarningRaised += (message) =>
                    Console.WriteLine($"[UPOZORENJE] {message}");

                service.OnElectricSpikeQ += (direction, delta) =>
                    Console.WriteLine($"[ANALITIKA 1] Upozorenje: Struja Iq je {direction}. Prirastaj: {delta}");

                service.OnElectricSpikeD += (direction, delta) =>
                    Console.WriteLine($"[ANALITIKA 1] Upozorenje: Struja Id je {direction}. Prirastaj: {delta}");

                service.OnTemperatureSpike += (direction, delta) =>
                    Console.WriteLine($"[ANALITIKA 2] Temperatura rashladne tecnosti je {direction}. Prirastaj: {delta}");

                service.OnOutOfBandWarning += (direction, coolant, mean) =>
                    Console.WriteLine($"[ANALITIKA 2] Odstupanje od proseka: {direction}. Trenutna vrednost: {coolant:F2}, Prosek: {mean:F2}");

                motorHost = new ServiceHost(service);
                motorHost.Open();

                Console.WriteLine("Server je pokrenut na net.tcp://localhost:4101/Motor");
                Console.WriteLine("Pritisni Enter za zaustavljanje...");
                Console.ReadLine();
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error starting service: " + ex.Message);
            }
            finally
            {
                try
                {
                    if (motorHost != null)
                    {
                        if (motorHost.State == CommunicationState.Faulted)
                        {
                            motorHost.Abort();
                        }
                        else
                        {
                            motorHost.Close();
                        }
                    }
                }
                catch
                {
                    motorHost?.Abort();
                }

                service?.Dispose();
            }
        }
    }
}

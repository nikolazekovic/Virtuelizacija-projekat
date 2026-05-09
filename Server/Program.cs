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
                
                // Pretplata na događaje
                service.OnTransferStarted += (sessionId, startTime) => 
                    Console.WriteLine($"[DOGAĐAJ] Sesija započeta: {sessionId} u {startTime}");
                
                service.OnSampleReceived += (count) => 
                    Console.WriteLine($"[DOGAĐAJ] Primljen uzorak broj: {count}");
                
                service.OnTransferCompleted += (sessionId, count) => 
                    Console.WriteLine($"[DOGAĐAJ] Sesija završena: {sessionId}. Ukupno uzoraka: {count}");

                service.OnWarningRaised += (message) => 
                    Console.WriteLine($"[UPOZORENJE] {message}");

                service.OnElectricSpikeQ += (direction, delta) => 
                    Console.WriteLine($"[ANALITIKA 1] Upozorenje: Struja Iq je {direction}. Priraštaj: {delta}");
                
                service.OnElectricSpikeD += (direction, delta) => 
                    Console.WriteLine($"[ANALITIKA 1] Upozorenje: Struja Id je {direction}. Priraštaj: {delta}");

                motorHost = new ServiceHost(service);
                motorHost.Open();
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

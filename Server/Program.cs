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
                motorHost = new ServiceHost(service);
                motorHost.Open();

                Console.WriteLine("PMSM Motor Monitoring Server");
                Console.WriteLine("Motor Service Status: RUNNING");
                Console.WriteLine("Endpoint: net.tcp://localhost:4101/Motor");
                Console.WriteLine("Protocol: NetTCP with Streaming");
                Console.WriteLine("Press any key to stop the service");

                Console.ReadKey();
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

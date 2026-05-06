using System;
using System.ServiceModel;

namespace Server
{
    public class Program
    {
        static void Main(string[] args)
        {
            ServiceHost motorHost = null;

            try
            {
                motorHost = new ServiceHost(typeof(MotorService));
                motorHost.Open();

                Console.WriteLine("PMSM Motor Monitoring Server");
                Console.WriteLine("Motor Service Status: RUNNING");
                Console.WriteLine("Endpoint: net.tcp://localhost:4101/Motor");
                Console.WriteLine("Protocol: NetTCP with Streaming");
                Console.WriteLine("Press any key to stop the service");

                Console.ReadKey();
                motorHost.Close();
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error starting service: " + ex.Message);
            }
            finally
            {
                try
                {
                    motorHost?.Close();
                }
                catch
                {
                }
            }
        }
    }
}

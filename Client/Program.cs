using Common;
using System;
using System.ServiceModel;

namespace Client
{
    public class Program
    {
        static void Main(string[] args)
        {
            ChannelFactory<IMotorService> motorFactory = null;
            IMotorService motorProxy = null;

            try
            {
                motorFactory = new ChannelFactory<IMotorService>("Motor");
                motorProxy = motorFactory.CreateChannel();

                var meta = new StartSessionMeta
                {
                    SessionId = Guid.NewGuid().ToString("N"),
                    StartedAt = DateTime.UtcNow,
                    IqThreshold = 1.0,
                    IdThreshold = 1.0,
                    TThreshold = 5.0,
                    DeviationPercent = 25
                };

                var startAck = motorProxy.StartSession(meta);
                Console.WriteLine("StartSession: " + startAck.Status + " - " + startAck.Message);

                var sample = new MotorSample
                {
                    Timestamp = DateTime.UtcNow,
                    Iq = 1.2,
                    Id = 0.8,
                    Coolant = 30.5,
                    ProfileId = 1,
                    Ambient = 24.0,
                    Torque = 12.5
                };

                var pushAck = motorProxy.PushSample(sample);
                Console.WriteLine("PushSample: " + pushAck.Status + " - " + pushAck.Message);

                var endAck = motorProxy.EndSession();
                Console.WriteLine("EndSession: " + endAck.Status + " - " + endAck.Message);
            }
            catch (FaultException<CustomException> ex)
            {
                Console.WriteLine("Service error: " + ex.Detail.Message);
            }
            catch (Exception ex)
            {
                Console.WriteLine("Client error: " + ex.Message);
            }
            finally
            {
                try
                {
                    if (motorProxy is ICommunicationObject communicationObject)
                    {
                        communicationObject.Close();
                    }

                    motorFactory?.Close();
                }
                catch
                {
                }
            }
        }
    }
}

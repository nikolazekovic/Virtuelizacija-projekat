using Common;
using System;
using System.ServiceModel;

namespace Server
{
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.Single, ConcurrencyMode = ConcurrencyMode.Single)]
    public class MotorService : IMotorService
    {
        private bool sessionStarted;
        private int sampleCount;

        public Ack StartSession(StartSessionMeta meta)
        {
            if (meta == null)
            {
                return new Ack { Success = false, Message = "Meta is null", Status = "NACK" };
            }

            sessionStarted = true;
            sampleCount = 0;

            return new Ack
            {
                Success = true,
                Message = "Session started",
                Status = "IN_PROGRESS"
            };
        }

        public Ack PushSample(MotorSample sample)
        {
            if (!sessionStarted)
            {
                return new Ack { Success = false, Message = "Session not started", Status = "NACK" };
            }

            if (sample == null)
            {
                return new Ack { Success = false, Message = "Sample is null", Status = "NACK" };
            }

            sampleCount++;

            return new Ack
            {
                Success = true,
                Message = "Sample received",
                Status = "IN_PROGRESS"
            };
        }

        public Ack EndSession()
        {
            if (!sessionStarted)
            {
                return new Ack { Success = false, Message = "No active session", Status = "NACK" };
            }

            sessionStarted = false;

            return new Ack
            {
                Success = true,
                Message = "Session completed. Samples: " + sampleCount,
                Status = "COMPLETED"
            };
        }
    }
}

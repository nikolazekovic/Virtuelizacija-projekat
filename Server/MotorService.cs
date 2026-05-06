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
        private string currentSessionId;

        public Ack StartSession(StartSessionMeta meta)
        {
            if (sessionStarted)
            {
                return new Ack { Success = false, Message = "Session already started", Status = "NACK" };
            }

            if (!ValidateStartSessionMeta(meta, out string error))
            {
                return new Ack { Success = false, Message = error, Status = "NACK" };
            }

            sessionStarted = true;
            sampleCount = 0;
            currentSessionId = string.IsNullOrWhiteSpace(meta.SessionId) ? Guid.NewGuid().ToString("N") : meta.SessionId;

            return new Ack
            {
                Success = true,
                Message = "Session started: " + currentSessionId,
                Status = "IN_PROGRESS"
            };
        }

        public Ack PushSample(MotorSample sample)
        {
            if (!sessionStarted)
            {
                return new Ack { Success = false, Message = "Session not started", Status = "NACK" };
            }

            if (!ValidateMotorSample(sample, out string error))
            {
                return new Ack { Success = false, Message = error, Status = "IN_PROGRESS" };
            }

            sampleCount++;

            return new Ack
            {
                Success = true,
                Message = "Sample received: " + sampleCount,
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
            string finishedSessionId = currentSessionId;
            currentSessionId = null;

            return new Ack
            {
                Success = true,
                Message = "Session completed. SessionId: " + finishedSessionId + ". Samples: " + sampleCount,
                Status = "COMPLETED"
            };
        }

        private static bool ValidateStartSessionMeta(StartSessionMeta meta, out string error)
        {
            error = string.Empty;

            if (meta == null)
            {
                error = "Meta is null";
                return false;
            }

            if (meta.IqThreshold <= 0)
            {
                error = "IqThreshold must be positive";
                return false;
            }

            if (meta.IdThreshold <= 0)
            {
                error = "IdThreshold must be positive";
                return false;
            }

            if (meta.TThreshold <= 0)
            {
                error = "TThreshold must be positive";
                return false;
            }

            if (meta.DeviationPercent <= 0 || meta.DeviationPercent > 100)
            {
                error = "DeviationPercent must be between 0 and 100";
                return false;
            }

            if (meta.StartedAt == default(DateTime))
            {
                error = "StartedAt is not valid";
                return false;
            }

            return true;
        }

        private static bool ValidateMotorSample(MotorSample sample, out string error)
        {
            error = string.Empty;

            if (sample == null)
            {
                error = "Sample is null";
                return false;
            }

            if (sample.Timestamp == default(DateTime))
            {
                error = "Timestamp is not valid";
                return false;
            }

            if (double.IsNaN(sample.Iq) || double.IsInfinity(sample.Iq))
            {
                error = "Iq is not valid";
                return false;
            }

            if (double.IsNaN(sample.Id) || double.IsInfinity(sample.Id))
            {
                error = "Id is not valid";
                return false;
            }

            if (double.IsNaN(sample.Coolant) || double.IsInfinity(sample.Coolant) || sample.Coolant < -273.15)
            {
                error = "Coolant is not valid";
                return false;
            }

            if (sample.ProfileId < 0)
            {
                error = "ProfileId is not valid";
                return false;
            }

            if (double.IsNaN(sample.Ambient) || double.IsInfinity(sample.Ambient) || sample.Ambient < -273.15)
            {
                error = "Ambient is not valid";
                return false;
            }

            if (double.IsNaN(sample.Torque) || double.IsInfinity(sample.Torque))
            {
                error = "Torque is not valid";
                return false;
            }

            return true;
        }
    }
}

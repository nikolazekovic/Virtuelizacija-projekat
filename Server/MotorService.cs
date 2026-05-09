using Common;
using System;
using System.Configuration;
using System.ServiceModel;

namespace Server
{
    [ServiceBehavior(InstanceContextMode = InstanceContextMode.Single, ConcurrencyMode = ConcurrencyMode.Single)]
    public class MotorService : IMotorService, IDisposable
    {
        private readonly string storageRoot = ConfigurationManager.AppSettings["motorStoragePath"] ?? "MotorStorage";
        private bool sessionStarted;
        private int sampleCount;
        private string currentSessionId;
        private MotorSessionWriter sessionWriter;
        private bool disposed;

        public delegate void TransferStartedHandler(string sessionId, DateTime startTime);
        public event TransferStartedHandler OnTransferStarted;

        public delegate void SampleReceivedHandler(int sampleCount);
        public event SampleReceivedHandler OnSampleReceived;

        public delegate void TransferCompletedHandler(string sessionId, int totalSamples);
        public event TransferCompletedHandler OnTransferCompleted;

        public delegate void WarningRaisedHandler(string message);
        public event WarningRaisedHandler OnWarningRaised;

        public Ack StartSession(StartSessionMeta meta)
        {
            if (sessionStarted)
            {
                OnTransferStarted?.Invoke(currentSessionId, DateTime.UtcNow);
                return new Ack { Success = false, Message = "Session already started", Status = "NACK" };
            }

            if (!ValidateStartSessionMeta(meta, out string error))
            {
                return new Ack { Success = false, Message = error, Status = "NACK" };
            }

            currentSessionId = string.IsNullOrWhiteSpace(meta.SessionId) ? Guid.NewGuid().ToString("N") : meta.SessionId;
            sampleCount = 0;

            try
            {
                sessionWriter = new MotorSessionWriter(storageRoot, currentSessionId);
                sessionStarted = true;
            }
            catch (Exception ex)
            {
                ReleaseSessionResources();
                return new Ack { Success = false, Message = "Unable to open session resources: " + ex.Message, Status = "NACK" };
            }

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

            if (sessionWriter == null)
            {
                return new Ack { Success = false, Message = "Session writer is not available", Status = "NACK" };
            }

            if (!ValidateMotorSample(sample, out string error))
            {
            try
            {
            if (sample != null)
                sessionWriter.WriteReject(sample, error);
                }
                catch (Exception ex)
                {
                    ReleaseSessionResources();
                    return new Ack { Success = false, Message = "Write reject error: " + ex.Message, Status = "NACK" };
                }

                return new Ack { Success = false, Message = error, Status = "IN_PROGRESS" };
            }

            try
            {
                sessionWriter.WriteSample(sample);
                sampleCount++;
                OnSampleReceived?.Invoke(sampleCount);
                Console.WriteLine("Prenos je u toku... (uzorak " + sampleCount + ")");  
            }
            catch (Exception ex)
            {
                ReleaseSessionResources();
                return new Ack { Success = false, Message = "Write error: " + ex.Message, Status = "NACK" };
            }

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

            string finishedSessionId = currentSessionId;
            int finishedSampleCount = sampleCount;
            Console.WriteLine("Prenos je završen.");
            OnTransferCompleted?.Invoke(finishedSessionId, finishedSampleCount);
            ReleaseSessionResources();

            return new Ack
            {
                Success = true,
                Message = "Session completed. SessionId: " + finishedSessionId + ". Samples: " + finishedSampleCount,
                Status = "COMPLETED"
            };
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        protected virtual void Dispose(bool disposing)
        {
            if (disposed)
            {
                return;
            }

            if (disposing)
            {
                ReleaseSessionResources();
            }

            disposed = true;
        }

        private void ReleaseSessionResources()
        {
            if (sessionWriter != null)
            {
                sessionWriter.Dispose();
                sessionWriter = null;
            }

            sessionStarted = false;
            sampleCount = 0;
            currentSessionId = null;
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

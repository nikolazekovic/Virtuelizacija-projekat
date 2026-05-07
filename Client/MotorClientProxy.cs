using Common;
using System;
using System.ServiceModel;

namespace Client
{
    public class MotorClientProxy : IDisposable
    {
        private ChannelFactory<IMotorService> factory;
        private IMotorService proxy;
        private ICommunicationObject communicationObject;
        private bool disposed;

        public MotorClientProxy()
        {
            factory = new ChannelFactory<IMotorService>("Motor");
            proxy = factory.CreateChannel();
            communicationObject = (ICommunicationObject)proxy;
        }

        public Ack StartSession(StartSessionMeta meta)
        {
            return proxy.StartSession(meta);
        }

        public Ack PushSample(MotorSample sample)
        {
            return proxy.PushSample(sample);
        }

        public Ack EndSession()
        {
            return proxy.EndSession();
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
                CloseCommunicationObject(communicationObject);
                communicationObject = null;

                CloseCommunicationObject(factory);
                factory = null;
                proxy = null;
            }

            disposed = true;
        }

        private static void CloseCommunicationObject(ICommunicationObject obj)
        {
            if (obj == null)
            {
                return;
            }

            try
            {
                if (obj.State == CommunicationState.Faulted)
                {
                    obj.Abort();
                }
                else
                {
                    obj.Close();
                }
            }
            catch
            {
                obj.Abort();
            }
        }
    }
}

using Common;
using System;
using System.Globalization;
using System.IO;

namespace Server
{
    public class MotorSessionWriter : IDisposable
    {
        private FileStream fileStream;
        private StreamWriter writer;
        
        // Dodato za rejects.csv
        private FileStream rejectsFileStream;
        private StreamWriter rejectsWriter;
        
        private bool disposed;

        public string SessionDirectory { get; private set; }

        public MotorSessionWriter(string storageRoot, string sessionId)
        {
            SessionDirectory = Path.Combine(storageRoot, sessionId);
            Directory.CreateDirectory(SessionDirectory);

            fileStream = new FileStream(
                Path.Combine(SessionDirectory, "measurements_session.csv"),
                FileMode.Create,
                FileAccess.Write,
                FileShare.Read);

            writer = new StreamWriter(fileStream);
            writer.AutoFlush = true;
            writer.WriteLine("Timestamp,Iq,Id,Coolant,ProfileId,Ambient,Torque");

            // Kreiranje rejects.csv toka
            rejectsFileStream = new FileStream(
                Path.Combine(SessionDirectory, "rejects.csv"),
                FileMode.Create,
                FileAccess.Write,
                FileShare.Read);

            rejectsWriter = new StreamWriter(rejectsFileStream);
            rejectsWriter.AutoFlush = true;
            // Dodata kolona za razlog odbijanja
            rejectsWriter.WriteLine("Timestamp,Iq,Id,Coolant,ProfileId,Ambient,Torque,RejectReason"); 
        }

        public void WriteSample(MotorSample sample)
        {
            if (disposed)
            {
                throw new ObjectDisposedException("MotorSessionWriter");
            }

            if (sample.ProfileId == 9999)
            {
                throw new IOException("Simulated stream interruption during write.");
            }

            writer.WriteLine(string.Join(",",
                sample.Timestamp.ToString("O", CultureInfo.InvariantCulture),
                sample.Iq.ToString(CultureInfo.InvariantCulture),
                sample.Id.ToString(CultureInfo.InvariantCulture),
                sample.Coolant.ToString(CultureInfo.InvariantCulture),
                sample.ProfileId.ToString(CultureInfo.InvariantCulture),
                sample.Ambient.ToString(CultureInfo.InvariantCulture),
                sample.Torque.ToString(CultureInfo.InvariantCulture)));
        }

        // Nova metoda za upis u rejects.csv
        public void WriteReject(MotorSample sample, string reason)
        {
            if (disposed)
            {
                throw new ObjectDisposedException("MotorSessionWriter");
            }

            rejectsWriter.WriteLine(string.Join(",",
                sample.Timestamp.ToString("O", CultureInfo.InvariantCulture),
                sample.Iq.ToString(CultureInfo.InvariantCulture),
                sample.Id.ToString(CultureInfo.InvariantCulture),
                sample.Coolant.ToString(CultureInfo.InvariantCulture),
                sample.ProfileId.ToString(CultureInfo.InvariantCulture),
                sample.Ambient.ToString(CultureInfo.InvariantCulture),
                sample.Torque.ToString(CultureInfo.InvariantCulture),
                reason));
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
                if (writer != null)
                {
                    writer.Dispose();
                    writer = null;
                }

                if (fileStream != null)
                {
                    fileStream.Dispose();
                    fileStream = null;
                }

                // Zatvaranje rejects tokova
                if (rejectsWriter != null)
                {
                    rejectsWriter.Dispose();
                    rejectsWriter = null;
                }

                if (rejectsFileStream != null)
                {
                    rejectsFileStream.Dispose();
                    rejectsFileStream = null;
                }
            }

            disposed = true;
        }
    }
}
using Common;
using System;
using System.Globalization;
using System.IO;

namespace Client
{
    public class MotorSampleReader : IDisposable
    {
        private FileStream fileStream;
        private StreamReader reader;
        private bool disposed;

        public MotorSampleReader(string filePath)
        {
            fileStream = new FileStream(filePath, FileMode.Open, FileAccess.Read, FileShare.Read);
            reader = new StreamReader(fileStream);
        }

        public bool TryReadNext(out MotorSample sample)
        {
            sample = null;

            if (disposed)
            {
                throw new ObjectDisposedException("MotorSampleReader");
            }

            string line = reader.ReadLine();
            if (line == null)
            {
                return false;
            }

            string[] parts = line.Split(',');
            if (parts.Length != 7)
            {
                throw new InvalidOperationException("Invalid sample format in input file.");
            }

            sample = new MotorSample
            {
                Timestamp = DateTime.Parse(parts[0], CultureInfo.InvariantCulture, DateTimeStyles.RoundtripKind),
                Iq = double.Parse(parts[1], CultureInfo.InvariantCulture),
                Id = double.Parse(parts[2], CultureInfo.InvariantCulture),
                Coolant = double.Parse(parts[3], CultureInfo.InvariantCulture),
                ProfileId = int.Parse(parts[4], CultureInfo.InvariantCulture),
                Ambient = double.Parse(parts[5], CultureInfo.InvariantCulture),
                Torque = double.Parse(parts[6], CultureInfo.InvariantCulture)
            };

            return true;
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
                if (reader != null)
                {
                    reader.Dispose();
                    reader = null;
                }

                if (fileStream != null)
                {
                    fileStream.Dispose();
                    fileStream = null;
                }
            }

            disposed = true;
        }
    }
}

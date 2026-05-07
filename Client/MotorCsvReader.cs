using Common;
using System;
using System.IO;

namespace Client
{
    public class MotorCsvReader : IDisposable
    {
        private readonly FileStream fileStream;
        private readonly StreamReader reader;
        private readonly StreamWriter rejectWriter;
        private bool headerChecked;
        private bool disposed;

        public int AcceptedCount { get; private set; }
        public int RejectedCount { get; private set; }

        public MotorCsvReader(string csvPath, string rejectLogPath)
        {
            string rejectDirectory = Path.GetDirectoryName(rejectLogPath);
            if (!string.IsNullOrWhiteSpace(rejectDirectory))
            {
                Directory.CreateDirectory(rejectDirectory);
            }

            fileStream = new FileStream(csvPath, FileMode.Open, FileAccess.Read, FileShare.Read);
            reader = new StreamReader(fileStream);
            rejectWriter = new StreamWriter(new FileStream(rejectLogPath, FileMode.Create, FileAccess.Write, FileShare.ReadWrite));
            rejectWriter.WriteLine("Reason,Line");
            rejectWriter.Flush();
        }

        public bool TryReadNext(out MotorSample sample)
        {
            sample = null;

            if (disposed)
            {
                throw new ObjectDisposedException("MotorCsvReader");
            }

            while (true)
            {
                string line = reader.ReadLine();
                if (line == null)
                {
                    return false;
                }

                if (!headerChecked)
                {
                    headerChecked = true;
                    string low = line.ToLowerInvariant();
                    if (low.Contains("timestamp") || low.Contains("iq") || low.Contains("id") || low.Contains("coolant") || low.Contains("ambient") || low.Contains("torque") || low.Contains("u_q") || low.Contains("stator_winding"))
                    {
                        continue;
                    }
                }

                string error;
                if (MotorSample.TryParseCsv(line, out sample, out error))
                {
                    AcceptedCount++;
                    return true;
                }

                rejectWriter.WriteLine(string.Join(",", error.Replace(',', ';'), line.Replace(',', ';')));
                rejectWriter.Flush();
                RejectedCount++;
            }
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
                try
                {
                    rejectWriter.Dispose();
                }
                catch
                {
                }

                try
                {
                    reader.Dispose();
                }
                catch
                {
                }

                try
                {
                    fileStream.Dispose();
                }
                catch
                {
                }
            }

            disposed = true;
        }
    }
}

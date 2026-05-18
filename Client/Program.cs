using Common;
using System;
using System.Configuration;
using System.Globalization;
using System.IO;
using System.Linq;
using System.ServiceModel;

namespace Client
{
    public class Program
    {
        static void Main(string[] args)
        {
            bool simulateFailure = args != null &&
                args.Length > 0 &&
                string.Equals(args[0], "simulate", StringComparison.OrdinalIgnoreCase);

            try
            {
                string csvPath = ResolveCsvPath();
                string rejectLogPath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Dataset", "rejects_client.csv");

                Console.WriteLine("PMSM Motor Monitoring Client");
                Console.WriteLine("CSV path: " + csvPath);

                if (simulateFailure)
                {
                    Console.WriteLine("Simulation mode: transfer interruption during write.");
                }

                using (var motorClient = new MotorClientProxy())
                using (var reader = new MotorCsvReader(csvPath, rejectLogPath))
                {
                    bool transferFailed = false;
                    int maxSamples = 100;
                    int sent = 0;

                    var meta = new StartSessionMeta
                    {
                        SessionId = Guid.NewGuid().ToString("N"),
                        StartedAt = DateTime.UtcNow,
                        IqThreshold = double.Parse(ConfigurationManager.AppSettings["Iq_threshold"] ?? "1.0", CultureInfo.InvariantCulture),
                        IdThreshold = double.Parse(ConfigurationManager.AppSettings["Id_threshold"] ?? "1.0", CultureInfo.InvariantCulture),
                        TThreshold = double.Parse(ConfigurationManager.AppSettings["T_threshold"] ?? "5.0", CultureInfo.InvariantCulture),
                        DeviationPercent = double.Parse(ConfigurationManager.AppSettings["DeviationPercent"] ?? "25", CultureInfo.InvariantCulture)
                    };

                    var startAck = motorClient.StartSession(meta);
                    Console.WriteLine("StartSession: " + startAck.Status + " - " + startAck.Message);

                    if (!startAck.Success)
                    {
                        return;
                    }

                    while (sent < maxSamples && reader.TryReadNext(out MotorSample sample))
                    {
                        if (simulateFailure && reader.AcceptedCount > 1)
                        {
                            sample.ProfileId = 9999;
                        }

                        Ack pushAck;
                        try
                        {
                            pushAck = motorClient.PushSample(sample);
                        }
                        catch (FaultException<CustomException> ex)
                        {
                            Console.WriteLine("PushSample fault: " + ex.Detail.Message);
                            transferFailed = true;
                            break;
                        }

                        Console.WriteLine("PushSample: " + pushAck.Status + " - " + pushAck.Message);

                        if (!pushAck.Success && pushAck.Status == "NACK")
                        {
                            transferFailed = true;
                            break;
                        }

                        sent++;
                    }

                    Console.WriteLine("Accepted lines: " + reader.AcceptedCount);
                    Console.WriteLine("Rejected lines: " + reader.RejectedCount);
                    Console.WriteLine("Reject log: " + rejectLogPath);

                    if (!transferFailed)
                    {
                        var endAck = motorClient.EndSession();
                        Console.WriteLine("EndSession: " + endAck.Status + " - " + endAck.Message);
                    }
                    else
                    {
                        Console.WriteLine("Transfer interrupted. Disposable resources are released.");
                    }
                }
            }
            catch (FaultException<CustomException> ex)
            {
                Console.WriteLine("Service error: " + ex.Detail.Message);
            }
            catch (Exception ex)
            {
                Console.WriteLine("Client error: " + ex.Message);
                Console.WriteLine("Resources are released through IDisposable and using blocks.");
            }
            finally
            {
                Console.WriteLine("Pritisni Enter za izlaz...");
                Console.ReadLine();
            }
        }

        private static string ResolveCsvPath()
        {
            string baseDirectory = AppDomain.CurrentDomain.BaseDirectory;
            string debugDatasetPath = Path.Combine(baseDirectory, "Dataset", "measures_v2.csv");
            string projectDatasetPath = Path.Combine(baseDirectory, "..", "..", "..", "Client", "Dataset", "measures_v2.csv");

            if (File.Exists(debugDatasetPath))
            {
                return debugDatasetPath;
            }

            if (File.Exists(projectDatasetPath))
            {
                return projectDatasetPath;
            }

            string debugDatasetDirectory = Path.Combine(baseDirectory, "Dataset");
            string projectDatasetDirectory = Path.Combine(baseDirectory, "..", "..", "..", "Client", "Dataset");

            if (Directory.Exists(debugDatasetDirectory))
            {
                string file = Directory.GetFiles(debugDatasetDirectory, "*.csv")
                    .Where(f => !Path.GetFileName(f).StartsWith("rejects_", StringComparison.OrdinalIgnoreCase))
                    .FirstOrDefault();

                if (file != null)
                {
                    return file;
                }
            }

            if (Directory.Exists(projectDatasetDirectory))
            {
                string file = Directory.GetFiles(projectDatasetDirectory, "*.csv")
                    .Where(f => !Path.GetFileName(f).StartsWith("rejects_", StringComparison.OrdinalIgnoreCase))
                    .FirstOrDefault();

                if (file != null)
                {
                    return file;
                }
            }

            return CreateDemoInputFile();
        }

        private static string CreateDemoInputFile()
        {
            string datasetDirectory = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Dataset");
            Directory.CreateDirectory(datasetDirectory);

            string filePath = Path.Combine(datasetDirectory, "sample_input.csv");

            using (var fileStream = new FileStream(filePath, FileMode.Create, FileAccess.Write, FileShare.Read))
            using (var writer = new StreamWriter(fileStream))
            {
                writer.WriteLine("Timestamp,Iq,Id,Coolant,ProfileId,Ambient,Torque");
                writer.WriteLine(CreateSampleLine(DateTime.UtcNow, 1.2, 0.8, 30.5, 1, 24.0, 12.5));
                writer.WriteLine("bad,line,for,reject,log");
                writer.WriteLine(CreateSampleLine(DateTime.UtcNow.AddSeconds(1), 1.4, 0.9, 31.0, 1, 24.1, 12.8));
            }

            return filePath;
        }

        private static string CreateSampleLine(DateTime timestamp, double iq, double id, double coolant, int profileId, double ambient, double torque)
        {
            return string.Join(",",
                timestamp.ToString("O", CultureInfo.InvariantCulture),
                iq.ToString(CultureInfo.InvariantCulture),
                id.ToString(CultureInfo.InvariantCulture),
                coolant.ToString(CultureInfo.InvariantCulture),
                profileId.ToString(CultureInfo.InvariantCulture),
                ambient.ToString(CultureInfo.InvariantCulture),
                torque.ToString(CultureInfo.InvariantCulture));
        }
    }
}

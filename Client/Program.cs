using Common;
using System;
using System.Configuration;
using System.Globalization;
using System.IO;
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
                string inputPath = CreateDemoInputFile(simulateFailure);

                Console.WriteLine("PMSM Motor Monitoring Client");
                Console.WriteLine("Input file: " + inputPath);

                if (simulateFailure)
                {
                    Console.WriteLine("Simulation mode: transfer interruption after first sample.");
                }

                using (var motorClient = new MotorClientProxy())
                using (var reader = new MotorSampleReader(inputPath))
                {
                    bool transferFailed = false;

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

                    while (reader.TryReadNext(out MotorSample sample))
                    {
                        var pushAck = motorClient.PushSample(sample);
                        Console.WriteLine("PushSample: " + pushAck.Status + " - " + pushAck.Message);

                        if (!pushAck.Success)
                        {
                            transferFailed = true;
                            break;
                        }
                    }

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
        }

        private static string CreateDemoInputFile(bool simulateFailure)
        {
            string filePath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "sample_input.csv");

            using (var fileStream = new FileStream(filePath, FileMode.Create, FileAccess.Write, FileShare.Read))
            using (var writer = new StreamWriter(fileStream))
            {
                writer.WriteLine(CreateSampleLine(DateTime.UtcNow, 1.2, 0.8, 30.5, 1, 24.0, 12.5));

                if (simulateFailure)
                {
                    writer.WriteLine(CreateSampleLine(DateTime.UtcNow.AddSeconds(1), 1.4, 0.9, 31.0, 9999, 24.1, 12.8));
                }
                else
                {
                    writer.WriteLine(CreateSampleLine(DateTime.UtcNow.AddSeconds(1), 1.4, 0.9, 31.0, 1, 24.1, 12.8));
                }
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

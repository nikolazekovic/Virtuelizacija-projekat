using System;
using System.Globalization;
using System.Runtime.Serialization;

namespace Common
{
    [DataContract]
    public class MotorSample
    {
        [DataMember]
        public DateTime Timestamp { get; set; }

        [DataMember]
        public double Iq { get; set; }

        [DataMember]
        public double Id { get; set; }

        [DataMember]
        public double Coolant { get; set; }

        [DataMember]
        public int ProfileId { get; set; }

        [DataMember]
        public double Ambient { get; set; }

        [DataMember]
        public double Torque { get; set; }

        public static bool TryParseCsv(string csvLine, out MotorSample sample, out string error)
        {
            sample = null;
            error = string.Empty;

            if (string.IsNullOrWhiteSpace(csvLine))
            {
                error = "Empty line";
                return false;
            }

            string cleaned = csvLine.Replace("\"", string.Empty);
            string[] parts = cleaned.Split(new[] { ',', ';', '\t' }, StringSplitOptions.None);
            CultureInfo culture = CultureInfo.InvariantCulture;

            if (parts.Length >= 13)
            {
                double iq;
                double id;
                double coolant;
                double ambient;
                double torque;
                int profileId;

                if (double.TryParse(parts[7], NumberStyles.Float, culture, out iq) &&
                    double.TryParse(parts[6], NumberStyles.Float, culture, out id) &&
                    double.TryParse(parts[1], NumberStyles.Float, culture, out coolant) &&
                    int.TryParse(parts[12], NumberStyles.Integer, culture, out profileId) &&
                    double.TryParse(parts[10], NumberStyles.Float, culture, out ambient) &&
                    double.TryParse(parts[11], NumberStyles.Float, culture, out torque))
                {
                    sample = new MotorSample
                    {
                        Timestamp = DateTime.UtcNow,
                        Iq = iq,
                        Id = id,
                        Coolant = coolant,
                        ProfileId = profileId,
                        Ambient = ambient,
                        Torque = torque
                    };

                    return true;
                }
            }
            else if (parts.Length >= 7)
            {
                DateTime timestamp;
                double iq;
                double id;
                double coolant;
                double ambient;
                double torque;
                int profileId;

                if (DateTime.TryParse(parts[0], culture, DateTimeStyles.AssumeUniversal | DateTimeStyles.AdjustToUniversal, out timestamp) &&
                    double.TryParse(parts[1], NumberStyles.Float, culture, out iq) &&
                    double.TryParse(parts[2], NumberStyles.Float, culture, out id) &&
                    double.TryParse(parts[3], NumberStyles.Float, culture, out coolant) &&
                    int.TryParse(parts[4], NumberStyles.Integer, culture, out profileId) &&
                    double.TryParse(parts[5], NumberStyles.Float, culture, out ambient) &&
                    double.TryParse(parts[6], NumberStyles.Float, culture, out torque))
                {
                    sample = new MotorSample
                    {
                        Timestamp = timestamp,
                        Iq = iq,
                        Id = id,
                        Coolant = coolant,
                        ProfileId = profileId,
                        Ambient = ambient,
                        Torque = torque
                    };

                    return true;
                }
            }

            error = "Invalid sample format";
            return false;
        }
    }
}

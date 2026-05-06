using System;
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
    }
}

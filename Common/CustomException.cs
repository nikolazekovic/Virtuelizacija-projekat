using System.Runtime.Serialization;

namespace Common
{
    [DataContract]
    public class CustomException
    {
        private string message;

        public CustomException(string message)
        {
            Message = message;
        }

        [DataMember]
        public string Message
        {
            get { return message; }
            set { message = value; }
        }
    }
}

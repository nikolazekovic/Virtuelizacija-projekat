namespace EliminacioniTemplate
{
    public class Item
    {
        public string Code { get; set; }
        public string Name { get; set; }
        public double Value { get; set; }

        public Item(string code, string name, double value)
        {
            Code = code;
            Name = name;
            Value = value;
        }

        public override string ToString()
        {
            return $"Code: {Code}, Name: {Name}, Value: {Value}";
        }
    }
}

using System.Collections.Generic;
using System.Configuration;
using System.IO;

namespace EliminacioniTemplate
{
    public class EventGenerator
    {
        public delegate void ItemHandler(Item item);

        public event ItemHandler InvalidItemEvent;
        public event ItemHandler SpecialItemEvent;

        public List<Item> RegularItems { get; private set; }
        public List<Item> SpecialItems { get; private set; }
        public List<Item> InvalidItems { get; private set; }

        private int fileCounter = 1;
        private readonly double specialThreshold;

        public EventGenerator()
        {
            RegularItems = new List<Item>();
            SpecialItems = new List<Item>();
            InvalidItems = new List<Item>();

            double threshold;
            if (!double.TryParse(ConfigurationManager.AppSettings["SpecialThreshold"], out threshold))
            {
                threshold = 1000;
            }

            specialThreshold = threshold;

            if (!Directory.Exists("Data"))
            {
                Directory.CreateDirectory("Data");
            }
        }

        public void ProcessItem(Item item)
        {
            if (string.IsNullOrWhiteSpace(item.Code) || string.IsNullOrWhiteSpace(item.Name))
            {
                InvalidItems.Add(item);
                InvalidItemEvent?.Invoke(item);
                return;
            }

            string filePath = "Data\\item_" + fileCounter + ".txt";
            using (StreamWriter writer = new StreamWriter(filePath))
            {
                writer.WriteLine(item.ToString());
            }

            fileCounter++;

            if (item.Value > specialThreshold)
            {
                SpecialItems.Add(item);
                SpecialItemEvent?.Invoke(item);
            }
            else
            {
                RegularItems.Add(item);
            }
        }
    }
}

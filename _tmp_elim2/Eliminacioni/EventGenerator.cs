using System;
using System.Collections.Generic;
using System.IO;

namespace Eliminacioni
{
    public class EventGenerator
    {
        public delegate void PackageHandler(Package p);

        public event PackageHandler InvalidPackageEvent;
        public event PackageHandler ExpensivePackageEvent;

        public List<Package> RegularPackages { get; private set; }
        public List<Package> ExpensivePackages { get; private set; }
        public List<Package> InvalidPackages { get; private set; }

        private int fileCounter = 1;

        public EventGenerator()
        {
            RegularPackages = new List<Package>();
            ExpensivePackages = new List<Package>();
            InvalidPackages = new List<Package>();

            if (!Directory.Exists("Data"))
            {
                Directory.CreateDirectory("Data");
            }
        }

        public void ProcessPackage(Package p)
        {
            if (string.IsNullOrWhiteSpace(p.Code) ||
                string.IsNullOrWhiteSpace(p.Name))
            {
                InvalidPackages.Add(p);

                if (InvalidPackageEvent != null)
                {
                    InvalidPackageEvent(p);
                }

                return;
            }

            string filePath = $"Data/package_{fileCounter}.txt";

            using (StreamWriter sw = new StreamWriter(filePath))
            {
                sw.WriteLine(p.ToString());
            }

            fileCounter++;

            if (p.Price > 1000)
            {
                ExpensivePackages.Add(p);

                if (ExpensivePackageEvent != null)
                {
                    ExpensivePackageEvent(p);
                }
            }
            else
            {
                RegularPackages.Add(p);
            }
        }
    }
}
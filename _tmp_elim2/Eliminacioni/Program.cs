using System;

namespace Eliminacioni
{
    class Program
    {
        static void Main(string[] args)
        {
            EventGenerator generator = new EventGenerator();
            Listener listener = new Listener();

            generator.InvalidPackageEvent += listener.OnInvalidPackage;
            generator.ExpensivePackageEvent += listener.OnExpensivePackage;

            while (true)
            {
                Console.WriteLine("Enter package code (or END to finish):");
                string code = Console.ReadLine();

                if (code.ToUpper() == "END")
                {
                    break;
                }

                Console.WriteLine("Enter package name:");
                string name = Console.ReadLine();

                Console.WriteLine("Enter package price:");

                double price;

                while (!double.TryParse(Console.ReadLine(), out price))
                {
                    Console.WriteLine("Invalid number! Enter package price again:");
                }

                Package p = new Package(code, name, price);

                generator.ProcessPackage(p);

                Console.WriteLine("-----------------------------------");
            }

            Console.WriteLine();
            Console.WriteLine("===== REGULAR PACKAGES =====");

            foreach (Package p in generator.RegularPackages)
            {
                Console.WriteLine(p);
            }

            Console.WriteLine();
            Console.WriteLine("===== EXPENSIVE PACKAGES =====");

            foreach (Package p in generator.ExpensivePackages)
            {
                Console.WriteLine(p);
            }

            Console.WriteLine();
            Console.WriteLine("===== INVALID PACKAGES =====");

            foreach (Package p in generator.InvalidPackages)
            {
                Console.WriteLine(p);
            }

            Console.ReadKey();
        }
    }
}
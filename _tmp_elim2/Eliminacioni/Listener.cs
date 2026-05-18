using System;

namespace Eliminacioni
{
    public class Listener
    {
        public void OnInvalidPackage(Package p)
        {
            Console.WriteLine("INVALID PACKAGE EVENT!");
            Console.WriteLine($"Package is invalid: {p}");
            Console.WriteLine();
        }

        public void OnExpensivePackage(Package p)
        {
            Console.WriteLine("EXPENSIVE PACKAGE EVENT!");
            Console.WriteLine($"Expensive package detected: {p}");
            Console.WriteLine();
        }
    }
}
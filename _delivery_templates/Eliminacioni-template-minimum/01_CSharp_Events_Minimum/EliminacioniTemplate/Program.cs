using System;

namespace EliminacioniTemplate
{
    internal class Program
    {
        private static void Main(string[] args)
        {
            EventGenerator generator = new EventGenerator();
            Listener listener = new Listener();

            generator.InvalidItemEvent += listener.OnInvalidItem;
            generator.SpecialItemEvent += listener.OnSpecialItem;

            while (true)
            {
                Console.WriteLine("Unesi sifru (ili END za kraj):");
                string code = Console.ReadLine();

                if (string.Equals(code, "END", StringComparison.OrdinalIgnoreCase))
                {
                    break;
                }

                Console.WriteLine("Unesi naziv:");
                string name = Console.ReadLine();

                Console.WriteLine("Unesi vrednost:");
                double value;

                while (!double.TryParse(Console.ReadLine(), out value))
                {
                    Console.WriteLine("Pogresan unos. Unesi vrednost ponovo:");
                }

                Item item = new Item(code, name, value);
                generator.ProcessItem(item);

                Console.WriteLine("--------------------------------");
            }

            PrintList("REGULARNI", generator.RegularItems);
            PrintList("POSEBNI", generator.SpecialItems);
            PrintList("NEISPRAVNI", generator.InvalidItems);

            Console.WriteLine("Kraj. Pritisni Enter.");
            Console.ReadLine();
        }

        private static void PrintList(string title, System.Collections.Generic.List<Item> items)
        {
            Console.WriteLine();
            Console.WriteLine("===== " + title + " =====");

            foreach (Item item in items)
            {
                Console.WriteLine(item);
            }
        }
    }
}

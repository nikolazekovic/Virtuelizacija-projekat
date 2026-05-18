using System;

namespace EliminacioniTemplate
{
    public class Listener
    {
        public void OnInvalidItem(Item item)
        {
            Console.WriteLine("INVALID ITEM EVENT!");
            Console.WriteLine(item);
            Console.WriteLine();
        }

        public void OnSpecialItem(Item item)
        {
            Console.WriteLine("SPECIAL ITEM EVENT!");
            Console.WriteLine(item);
            Console.WriteLine();
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using c_sharp_one;

namespace c_sharp_two
{
    class Program
    {
        static void Main(string[] args)
        {
            ForTest ft = new ForTest();

            Console.WriteLine(ft.GetSolution());
            Console.ReadKey();
        }
    }
}

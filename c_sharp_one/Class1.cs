using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Reflection;
using System.IO;
using System.Diagnostics;

namespace c_sharp_one
{
    public class ForTest
    {
        public string GetSolution()
        {
            string current_path = Path.GetFileName(Process.GetCurrentProcess().MainModule.FileName);
            return current_path;
        }
    }
}

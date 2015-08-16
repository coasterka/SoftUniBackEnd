using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EF_Mappings
{
    class ListCharacters
    {
        static void Main()
        {
            var context = new DiabloContext();
            var characterNames = context.Characters
                .Select(c => c.Name)
                .ToList();
            foreach (var charName in characterNames)
            {
                Console.WriteLine(charName);
            }
        }
    }
}

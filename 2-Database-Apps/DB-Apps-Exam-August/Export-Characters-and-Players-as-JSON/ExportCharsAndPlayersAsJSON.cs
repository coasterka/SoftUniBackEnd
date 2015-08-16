using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Script.Serialization;
using EF_Mappings;

namespace Export_Characters_and_Players_as_JSON
{
    class ExportCharsAndPlayersAsJSON
    {
        static void Main()
        {
            var context = new DiabloContext();
            var charsPlayers = context.Characters
                .OrderBy(c => c.Name)
                .Select(c => new
                {
                    name = c.Name,
                    playedBy = c.UsersGames
                        .Select(u => u.User.Username)
                })
                .ToList();
            var jsSerializer = new JavaScriptSerializer();
            var charsPlayersJson = jsSerializer.Serialize(charsPlayers);
            File.WriteAllText("characters.json", charsPlayersJson);
            Console.WriteLine("Characted and Players exported to characters.json");
        }
    }
}

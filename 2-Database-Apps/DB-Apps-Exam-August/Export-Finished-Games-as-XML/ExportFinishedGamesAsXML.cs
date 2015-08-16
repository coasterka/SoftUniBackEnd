using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;
using EF_Mappings;

namespace Export_Finished_Games_as_XML
{
    class ExportFinishedGamesAsXML
    {
        static void Main()
        {
            var context = new DiabloContext();
            var finishedGames = context.Games
                .Where(g => g.IsFinished == true)
                .OrderBy(g => g.Name)
                .ThenBy(g => g.Duration)
                .Select(g => new
                {
                    Name = g.Name,
                    Duration = g.Duration,
                    Users = g.UsersGames
                        .Select(u => new
                        {
                            UserName = u.User.Username,
                            IPAddress = u.User.IpAddress
                        })
                        .ToList()
                })
                .ToList();

            var gamesXml = new XElement("games");
            foreach (var finishedGame in finishedGames)
            {
                var gameXml = new XElement("game");
                gameXml.Add(new XAttribute("name", finishedGame.Name));
                if (finishedGame.Duration.HasValue)
                {
                    gameXml.Add(new XAttribute("duration", finishedGame.Duration));
                }
                var usersXml = new XElement("users");
                
                foreach (var user in finishedGame.Users)
                {
                    var userXml = new XElement("user");
                    userXml.Add(new XAttribute("username", user.UserName));
                    userXml.Add(new XAttribute("ip-address", user.IPAddress));
                    usersXml.Add(userXml);
                }
                gameXml.Add(usersXml);
                gamesXml.Add(gameXml);
            }
            var xmlDocument = new XDocument(gamesXml);
            xmlDocument.Save("finished-games.xml");
            Console.WriteLine("Finished Games exported to finished-games.xml.");
        }
    }
}

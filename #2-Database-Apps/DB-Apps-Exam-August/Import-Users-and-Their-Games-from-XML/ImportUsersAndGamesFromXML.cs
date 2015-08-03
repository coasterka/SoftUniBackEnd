using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.XPath;
using System.Xml.Linq;
using EF_Mappings;

namespace Import_Users_and_Their_Games_from_XML
{
    class ImportUsersAndGamesFromXML
    {
        // nope
        static void Main()
        {
            var context = new DiabloContext();
            var xmlDoc = XDocument.Load(@"..\..\users-and-games.xml");
            var userNodes = xmlDoc.XPathSelectElements("/users/user");
            foreach (var userNode in userNodes)
            {
                //CreateUserIfNotExist(context, userNode);
            }
        }
        private static void CreateUserIfNotExist(DiabloContext context, IEnumerable<XElement> xUsers)
        {
            foreach (var xUser in xUsers)
            {
                var userName = xUser.Attribute("username").Value;
                Console.WriteLine(userName);
            }
        }
    }
}

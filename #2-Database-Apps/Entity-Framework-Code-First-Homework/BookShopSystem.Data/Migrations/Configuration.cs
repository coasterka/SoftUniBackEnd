namespace BookShopSystem.Data.Migrations
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Migrations;
    using System.Globalization;
    using System.IO;
    using System.Linq;
    using BookShopSystem.Models;

    internal sealed class Configuration : DbMigrationsConfiguration<BookShopContext>
    {
        public Configuration()
        {
            this.AutomaticMigrationDataLossAllowed = true;
            this.AutomaticMigrationsEnabled = true;
            this.ContextKey = "BookShopSystem.Data.BookShopContext";
        }

        // used to fill the database with sample data
        protected override void Seed(BookShopContext context)
        {
            // add authors to database from the file authors.txt

            //if (context.Authors.Count() > 0)
            //{
            //    return;
            //}
            //else
            //{
            //    using (var reader = new StreamReader(@"D:\docs\SoftUni\#2-Back-End\#3-Database-Applications\#2-Entity-Framework-Code-First\2. Entity-Framework-Code-First-Exercise-Book-Shop\authors.txt"))
            //    {
            //        var line = reader.ReadLine();
            //        line = reader.ReadLine();
            //        while (line != null)
            //        {
            //            var data = line.Split(new[] { ' ' }, 2);
            //            var firstName = data[0];
            //            var lastName = data[1];

            //            context.Authors.Add(new Author()
            //            {
            //                FirstName = firstName,
            //                LastName = lastName
            //            });
            //            line = reader.ReadLine();
            //        }
            //    }
            //}

            // add books to database from the file books.txt

            if (context.Books.Count() > 0)
            {
                return;
            }
            else
            {
                using (var reader = new StreamReader(@"D:\docs\SoftUni\#2-Back-End\#3-Database-Applications\#2-Entity-Framework-Code-First\2. Entity-Framework-Code-First-Exercise-Book-Shop\books.txt"))
                {
                    var authors = context.Authors;
                    var categories = context.Categories;
                    var random = new Random();
                    var line = reader.ReadLine();
                    line = reader.ReadLine();
                    while (line != null)
                    {
                        var data = line.Split(new[] { ' ' }, 6);
                        //var authorIndex = random.Next(0, authors.Count());
                        //var author = authors.Find(authorIndex);
                        var authorId = random.Next(1, authors.Count()+1);
                        //var categoryIndex = random.Next(0, categories.Count());
                        //var category = categories.Find(categoryIndex);
                        var edition = (EditionType)int.Parse(data[0]);
                        var releaseDate = DateTime.ParseExact(data[1], "d/M/yyyy",
                            CultureInfo.InvariantCulture);
                        var copies = int.Parse(data[2]);
                        var price = decimal.Parse(data[3]);
                        var ageRestriction = (AgeRestriction)int.Parse(data[4]);
                        var title = data[5];

                        context.Books.Add(new Book()
                        {
                            AuthorId = authorId,
                            EditionType = edition,
                            ReleaseDate = releaseDate,
                            Copies = copies,
                            Price = price,
                            AgeRestriction = ageRestriction,
                            Title = title
                        });

                        line = reader.ReadLine();
                    }
                }
            }

            //// add categories to database from the file categories.txt

            //if (context.Categories.Count() > 0)
            //{
            //    return;
            //}
            //else
            //{
            //    using (var reader = new StreamReader(@"D:\docs\SoftUni\#2-Back-End\#3-Database-Applications\#2-Entity-Framework-Code-First\2. Entity-Framework-Code-First-Exercise-Book-Shop\categories.txt"))
            //    {
            //        var line = reader.ReadLine();
            //        line = reader.ReadLine();
            //        while (line != null)
            //        {
            //            var name = line;

            //            context.Categories.Add(new Category()
            //            {
            //                Name = name
            //            });
            //            line = reader.ReadLine();
            //        }
            //    }
            //}
        }
    }
}

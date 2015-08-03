using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BookShopSystem.Data;

namespace BookShopSystem.ConsoleClient
{
    using System.Data;
    class Program
    {
        static void Main()
        {
            var context = new BookShopContext();

            //var booksAfter2000 = context.Books
            //    .Where(b => b.ReleaseDate.Value.Year > 2000)
            //    .Select(b => new
            //    {
            //        b.Title,
            //        b.ReleaseDate.Value.Year
            //    });
            //foreach (var book in booksAfter2000)
            //{
            //    Console.WriteLine(book);
            //}

            //var authorsWithOldBooks = context.Authors
            //    .Where(a => a.Books.Any(
            //        b => b.ReleaseDate.Value.Year < 1990))
            //    .Select(a => new
            //    {
            //        a.FirstName,
            //        a.LastName
            //    });
            //foreach (var author in authorsWithOldBooks)
            //{
            //    Console.WriteLine(author);
            //}

            //var authorsOrderedByBooks = context.Authors
            //    .OrderByDescending(a => a.Books.Count())
            //    .Select(a => new
            //    {
            //        a.FirstName,
            //        a.LastName,
            //        BookCount = a.Books.Count()
            //    });
            //foreach (var author in authorsOrderedByBooks)
            //{
            //    Console.WriteLine(author);
            //}

            //var booksForSpecificAuthor = context.Authors
            //    .Where(a => a.FirstName == "George" &&
            //                a.LastName == "Powell")
            //    .OrderByDescending(
            //        a => a.Books.Any(b => b.ReleaseDate.Value.Year > 0))
            //    .ThenBy(a => a.Books.Any(b => b.Title != ""))
            //    .Select(a => a.Books.Any(b => new
            //    {
            //        b.Title,
            //        b.ReleaseDate,
            //        b.Copies
            //    }));
                
        }
    }
}
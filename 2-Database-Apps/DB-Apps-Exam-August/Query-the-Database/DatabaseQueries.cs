using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Script.Serialization;
using Movies_Code_First;
using Movies_Code_First.Models;

namespace Query_the_Database
{
    class DatabaseQueries
    {
        static void Main()
        {
            var context = new MoviesContext();
            var jsSerializer = new JavaScriptSerializer();

            // Adult Movies
            var adultMovies = context.Movies
                .Where(m => m.AgeRestriction == AgeRestriction.Adult)
                .Select(m => new
                {
                    title = m.Title,
                    ratingsGiven = m.Ratings.Count()
                })
                .ToList();
            
            var adultMoviesJson = jsSerializer.Serialize(adultMovies);
            File.WriteAllText("adult-movies.json", adultMoviesJson);
            Console.WriteLine("Adult Movies exported to adult-movies.json.");

            // Rated Movies by User jmeyery
            var ratedMoviesByUser = context.Users
                .Where(u => u.UserName == "jmeyery")
                .Select(u => new
                {
                    username = u.UserName,
                    ratedMovies = u.Ratings
                        .Select(r => new
                        {
                            title = r.Movie.Title,
                            userRaiting = r.Stars,
                            averageRating = r.Movie.Ratings.Average(m => m.Stars)
                        })
                });

            var jsonMovies = jsSerializer.Serialize(ratedMoviesByUser);
            File.WriteAllText("rated-movies-by-jmeyery.json", jsonMovies);
            Console.WriteLine("Rated Movies by User jmeyery exported to rated-movies-by-jmeyery.json.");

            // Top 10 Favourite Movies
            var topFavMovies = context.Movies
                .Where(m => m.AgeRestriction == AgeRestriction.Teen)
                .OrderByDescending(m => m.Users.Count())
                .ThenBy(m => m.Title)
                .Select(m => new
                {
                    isbn = m.Isbn,
                    title = m.Title,
                    favouritedBy = m.Users.Select(u => u.UserName)
                })
                .Take(10)
                .ToList();

            var jsonTopFavMovies = jsSerializer.Serialize(topFavMovies);
            File.WriteAllText("top-10-favourite-movies.json", jsonTopFavMovies);
            Console.WriteLine("Top 10 Favourite Movies exported to top-10-favourite-movies.json.");
        }
    }
}

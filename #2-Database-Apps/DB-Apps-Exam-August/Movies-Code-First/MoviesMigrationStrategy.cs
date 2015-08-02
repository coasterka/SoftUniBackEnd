using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Script.Serialization;
using Movies_Code_First.Models;

namespace Movies_Code_First
{
    public class MoviesMigrationStrategy :
        DropCreateDatabaseIfModelChanges<MoviesContext>
    {
        protected override void Seed(MoviesContext context)
        {
            var jsSerializer = new JavaScriptSerializer();

            // import movies from movies.json
            var jsonMovies = File.ReadAllText(@"..\..\JsonFiles\movies.json");
            var parsedMovies = jsSerializer.Deserialize<IEnumerable<MovieDto>>(jsonMovies);
            foreach (var movie in parsedMovies)
            {
                ImportMovieToDatabase(movie);
            }

            // import countries from countries.json
            var jsonCountries = File.ReadAllText(@"..\..\JsonFiles\countries.json");
            var parsedCountries = jsSerializer.Deserialize<IEnumerable<CountryDto>>(jsonCountries);
            foreach (var country in parsedCountries)
            {
                ImportCountryToDatabase(country);
            }

            // import users from users.json
            var jsonUsers = File.ReadAllText(@"..\..\JsonFiles\users.json");
            var parsedUsers = jsSerializer.Deserialize<IEnumerable<UserDto>>(jsonUsers);
            foreach (var user in parsedUsers)
            {
                ImportUserToDatabase(user);
            }


            // import ratings from movie-ratings.json
            var jsonRatings = File.ReadAllText(@"..\..\JsonFiles\movie-ratings.json");
            var parsedRatings = jsSerializer.Deserialize<IEnumerable<RatingDto>>(jsonRatings);
            foreach (var rating in parsedRatings)
            {
                ImportRatingToDatabase(rating);
            }

            // import users' favorite movies from users-and-favourite-movies.json
            var jsonFavMovies = File.ReadAllText(@"..\..\JsonFiles\users-and-favourite-movies.json");
            var parsedUsersFavMovies = jsSerializer.Deserialize<IEnumerable<UsersFavMoviesDto>>(jsonFavMovies);
            foreach (var user in parsedUsersFavMovies)
            {
                ImportFavMoviesToDatabase(user);
            }
        }

        private void ImportFavMoviesToDatabase(UsersFavMoviesDto user)
        {
            var context = new MoviesContext();
            var currentUser = context.Users
                .SingleOrDefault(u => u.UserName == user.Username);
            foreach (var favMovie in user.FavouriteMovies)
            {
                var currentMovie = context.Movies
                    .Where(m => m.Isbn == favMovie)
                    .FirstOrDefault();
                currentUser.FavoriteMovies.Add(currentMovie);
            }
            context.SaveChanges();
        }
        private static void ImportMovieToDatabase(MovieDto movie)
        {
            var context = new MoviesContext();
            var newMovie = new Movie
            {
                Isbn = movie.Isbn,
                Title = movie.Title,
                AgeRestriction = movie.AgeRestriction
            };
            context.Movies.Add(newMovie);
            context.SaveChanges();
        }
        private static void ImportCountryToDatabase(CountryDto country)
        {
            var context = new MoviesContext();
            var newCountry = new Country
            {
                Name = country.Name
            };
            context.Countries.Add(newCountry);
            context.SaveChanges();
        }        
        private static void ImportUserToDatabase(UserDto user)
        {
            var context = new MoviesContext();
            int? countryId;
            if (user.Country != null)
            {
                countryId = context.Countries
                    .Where(c => c.Name == user.Country)
                    .Select(c => c.CountryId)
                    .FirstOrDefault();
            }
            else
            {
                countryId = null;
            }
            var newUser = new User
            {
                UserName = user.UserName,
                Age = user.Age,
                Email = user.Email,
                CountryId = countryId
            };
            context.Users.Add(newUser);
            context.SaveChanges();
        }
        private static void ImportRatingToDatabase(RatingDto rating)
        {
            var context = new MoviesContext();
            var userId = context.Users
                .Where(u => u.UserName == rating.User)
                .Select(u => u.UserId)
                .FirstOrDefault();
            var movieId = context.Movies
                .Where(m => m.Isbn == rating.Movie)
                .Select(m => m.MovieId)
                .FirstOrDefault();
            var newRating = new Rating
            {
                UserId = userId,
                MovieId = movieId,
                Stars = rating.Rating
            };
            context.Ratings.Add(newRating);
            context.SaveChanges();
        }
    }
}

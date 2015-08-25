using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace BookShop.Models
{
    public class Author
    {
        private ICollection<Book> books;
        public Author()
        {
            this.books = new HashSet<Book>();
        }
        [Key]
        public int AuthorId { get; set; }
        public string FirstName { get; set; }
        [Required]
        public string LastName { get; set; }
        public virtual ICollection<Book> Books
        {
            get { return this.books; }
            set { this.books = value; }
        }
    }
}

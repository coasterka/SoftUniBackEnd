//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace EF_Mappings
{
    using System;
    using System.Collections.Generic;
    
    public partial class Game
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Game()
        {
            this.UsersGames = new HashSet<UsersGame>();
        }
    
        public int Id { get; set; }
        public string Name { get; set; }
        public System.DateTime Start { get; set; }
        public Nullable<int> Duration { get; set; }
        public int GameTypeId { get; set; }
        public bool IsFinished { get; set; }
    
        public virtual GameType GameType { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<UsersGame> UsersGames { get; set; }
    }
}

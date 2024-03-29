namespace VeloMax.Models
{
    public class Client
    {
        public int Id { get; set; }
        public string Type { get; set; }
        public string Street { get; set; }
        public string City { get; set; }
        public string PostalCode { get; set; }
        public string Province { get; set; }
        public string Phone { get; set; }
        public string Mail { get; set; }

        public Client()
        {
            Id = 0;
            Type = Street = City = PostalCode = Province = Phone = Mail = "";
        }
        
        public Client(int id, string street, string city, string postalCode, string province, string phone, string mail)
        {
            // if not null args are null
            if (street is null || city is null || postalCode is null || province is null || phone is null || mail is null)
            {
                System.Environment.Exit(0);
            }
            this.Id = id;
            this.Street = street;
            this.City = city;
            this.Province = province;
            this.PostalCode = postalCode;
            this.Phone = phone;
            this.Mail = mail;
        }

        public virtual string[] Attributs()
        {
            return null;
        }

        public virtual string At(int i)
        {
            return null;
        }
        public virtual string TypeC()
        {
            return "clients";
        }
    }
}
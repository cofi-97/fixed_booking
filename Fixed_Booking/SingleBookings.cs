//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Fixed_Booking
{
    using System;
    using System.Collections.Generic;
    
    public partial class SingleBookings
    {
        public int SingleBookingID { get; set; }
        public int BookingID { get; set; }
        public int Date { get; set; }
    
        public virtual Bookings Bookings { get; set; }
        public virtual ReservedDates ReservedDates { get; set; }
    }
}

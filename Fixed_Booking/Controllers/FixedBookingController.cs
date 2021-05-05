using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Fixed_Booking.Controllers
{
    public class FixedBookingController : Controller
    {
        FixedBookingsEntities db = new FixedBookingsEntities();
        public ActionResult All()
        {
            ViewBag.Title = "List of all bookings";

            return View(db.Bookings.ToList());
        }
        [HttpGet]
        public ActionResult Create()
        {
            ViewBag.Fields = db.Fields.ToList();
            return View();
        }
        [HttpPost]
        public ActionResult Create(FormCollection collection)
        {
            var daysSelected = collection["DayOfWeek"].Split(',').Select(int.Parse).ToList();
            var hoursSelected = collection["HoursInDay"].Split(',').Select(int.Parse).ToList();

            var field = Convert.ToInt32(collection["Fields"]);
            var dateRange = collection["daterange"];
            var dates = dateRange.Split('-');
            DateTime startDate = Convert.ToDateTime(dates[0]);
            DateTime endDate = Convert.ToDateTime(dates[1]);
            DateTime[] selectedDatesList = Enumerable.Range(0, 1 + endDate.Subtract(startDate).Days)
          .Select(offset => startDate.AddDays(offset))
          .ToArray();
            Bookings newBooking = new Bookings()
            {
                CreatedOn = DateTime.Now,
                CustomerName = collection["CustomerName"],
                ContactNumber = collection["ContactNumber"],
                StartDate = startDate,
                EndDate = endDate,
                Field = field,
                Comment = collection["Comment"],
            };
            List<DateTime> datesToCheck = new List<DateTime>();
            foreach (var dateItem in selectedDatesList)
            {
                if (daysSelected.Contains((int)dateItem.DayOfWeek))
                {
                    foreach (var hourItem in hoursSelected)
                    {
                        DateTime dateToAdd = dateItem;
                        dateToAdd = dateToAdd.AddHours(hourItem);
                        datesToCheck.Add(dateToAdd);
                    }

                }
            }
            foreach (var dateToCheck in datesToCheck)
            {
                if (db.ReservedDates.ToList().Where(a => a.Field == field).Any(a => a.Date == dateToCheck.Date && a.Time == dateToCheck.TimeOfDay))
                {
                    TempData["message"] = $"On {db.Fields.First(a => a.FieldID == field).FieldName}\n{dateToCheck} allready booked";
                    ViewBag.Fields = db.Fields.ToList();
                    return View();
                }
            }
            foreach (var dateToCheck in datesToCheck)
            {
                try
                {
                    if (newBooking.BookingID == 0)
                    {
                        var id = db.Bookings.Add(newBooking);
                        db.SaveChanges();
                    }
                    ReservedDates newDate = new ReservedDates()
                    {
                        Field = field,
                        Date = dateToCheck.Date,
                        Time = dateToCheck.TimeOfDay
                    };
                    db.ReservedDates.Add(newDate);
                    db.SaveChanges();
                    SingleBookings newSingleBooking = new SingleBookings()
                    {
                        BookingID = newBooking.BookingID,
                        Date = newDate.DateID
                    };
                    db.SingleBookings.Add(newSingleBooking);
                    db.SaveChanges();
                }
                catch (Exception ex)
                {
                    var message = ex.Message;
                }
            }
            ViewBag.Fields = db.Fields.ToList();
            return View();
        }
        [HttpGet]
        public ActionResult Details(int id)
        {
            return View(db.Bookings.Where(a => a.BookingID == id).First().SingleBookings.ToList());
        }
        [HttpGet]
        public ActionResult Delete(int id, int type)
        {
            if (type == 1)
            {
                SingleBookings bookingToDelete = new SingleBookings();
                try
                {
                    bookingToDelete = db.SingleBookings.First(a => a.SingleBookingID == id);
                    ReservedDates dateToDelete = db.ReservedDates.First(a => a.DateID == bookingToDelete.Date);

                    db.SingleBookings.Remove(bookingToDelete);
                    db.ReservedDates.Remove(dateToDelete);
                    db.SaveChanges();

                    return RedirectToAction("Details", "FixedBooking", new { id = bookingToDelete.BookingID });
                }
                catch (Exception)
                {
                    TempData["message"] = "Error deleting single booking!";
                    return RedirectToAction("Details", "FixedBooking", new { id = bookingToDelete.BookingID });
                }
            }
            else if( type == 2)
            {
                try
                {
                    Bookings bookingToDelete = db.Bookings.First(a => a.BookingID == id);
                    List<SingleBookings> singleBookingsToDelete = db.SingleBookings.Where(a => a.BookingID == id).ToList();
                    List<ReservedDates> datesToDelete = new List<ReservedDates>();
                    foreach (var singleBooking in singleBookingsToDelete)
                    {
                        datesToDelete.Add(db.ReservedDates.First(a => a.DateID == singleBooking.Date));
                    }

                    db.Bookings.Remove(bookingToDelete);
                    db.SingleBookings.RemoveRange(singleBookingsToDelete);
                    db.ReservedDates.RemoveRange(datesToDelete);
                    db.SaveChanges();

                    return RedirectToAction("All", "FixedBooking");
                }
                catch (Exception)
                {
                    TempData["message"] = "Error deleting booking!";
                    return RedirectToAction("All", "FixedBooking");
                }
            }
            TempData["message"] = "Bad parameters passed";
            return RedirectToAction("All", "FixedBooking");
        }
    }
}


CREATE DEFINER=`user`@`%` PROCEDURE `CancelBooking`(IN bid INT)
BEGIN
	DELETE FROM Bookings WHERE BookingID = bid;
    SELECT CONCAT("Booking ", bid, " cancelled") AS Confirmation;
END
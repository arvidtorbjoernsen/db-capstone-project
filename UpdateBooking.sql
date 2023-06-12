CREATE DEFINER=`user`@`%` PROCEDURE `UpdateBooking`(IN bid INT, IN bd DATE)
BEGIN
	UPDATE Bookings
    SET BookingDate = bd
    WHERE BookingID = bid;
    SELECT CONCAT("Booking ", bid, " updated") AS Confirmation;
END
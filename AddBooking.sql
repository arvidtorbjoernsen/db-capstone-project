CREATE DEFINER=`user`@`%` PROCEDURE `AddBooking`(IN bid INT,IN cid INT, IN tn INT, IN bd DATE)
BEGIN
	INSERT INTO Bookings (BookingID, CustomerID, BookingDate, TableNumber)
    VALUE (bid, cid, bd, tn);
    SELECT "New booking added" AS Confirmation;
END
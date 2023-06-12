CREATE DEFINER=`user`@`%` PROCEDURE `CheckBooking`(IN bd DATE, IN tn INT)
BEGIN
DECLARE Confirmation VARCHAR(45);
IF EXISTS(SELECT BookingDate, TableNumber from Bookings WHERE BookingDate = bd AND TableNumber = tn) THEN
SET Confirmation = CONCAT("Table ", tn, " is already booked");
ELSE
SET Confirmation = CONCAT("Table ", tn, " is not booked");
END IF;
SELECT Confirmation;
END
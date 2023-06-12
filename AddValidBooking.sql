CREATE DEFINER=`user`@`%` PROCEDURE `AddValidBooking`(IN bd DATE, IN tn INT, IN ci INT)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
		BEGIN
			ROLLBACK;
        END;
    START TRANSACTION;
		IF (EXISTS(SELECT * FROM Bookings WHERE BookingDate = bd AND TableNumber = tn)) THEN
			SIGNAL SQLSTATE "45000"
            SET MESSAGE_TEXT = "Table is allready booked for this date"; 
        END IF;    
		INSERT INTO Bookings(BookingDate, TableNumber, CustomerID)
			VALUES(bd, tn, ci);
        COMMIT WORK;
        SELECT CONCAT("Table ", tn, " booked for ", bd); 
END
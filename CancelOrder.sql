CREATE DEFINER=`user`@`%` PROCEDURE `CancelOrder`(IN id INT, OUT Confirmation VARCHAR(45))
BEGIN
IF (EXISTS(SELECT OrderID FROM Orders WHERE OrderID = id)) THEN
	SET Confirmation = CONCAT("Order ", id, " is canceled");
    DELETE FROM Orders WHERE Orders.OrderID = id;
ELSE SET Confirmation = "Order doesn't exist";    
END IF;
SELECT Confirmation;    
END
CREATE DEFINER=`user`@`%` PROCEDURE `OrdersAboveGivenValue`(IN Value INT)
BEGIN
SELECT Customers.CustomerID, Customers.Name AS FullName, OrderID, TotalCost AS Cost, Menu.Name AS StarterName, Menu.Name AS CoursName 
FROM Orders
INNER JOIN Customers
ON Orders.CustomerID = Customers.CustomerID
INNER JOIN SelectedMenuItems
ON Orders.SelectedMenuItemsID = SelectedMenuItems.SelectedMenuItemsID 
INNER JOIN Menu
ON SelectedMenuItems.MenuID = Menu.MenuID
WHERE SelectedMenuItems.StarterName = Menu.Name AND TotalCost > Value;
END
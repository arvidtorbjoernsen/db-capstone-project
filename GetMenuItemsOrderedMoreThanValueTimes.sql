CREATE DEFINER=`user`@`%` PROCEDURE `GetMenuItemsOrderedMoreThanValueTimes`(IN Value INT)
BEGIN
SELECT Name FROM Menu
INNER JOIN SelectedMenuItems
ON SelectedMenuItems.MenuID = Menu.MenuID
WHERE SelectedMenuItemsID = ANY (SELECT Orders.SelectedMenuItemsID FROM Orders
WHERE Quantity > Value);
END
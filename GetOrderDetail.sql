PREPARE GetOrderDetail FROM 
'SELECT OrderID, Quantity, TotalCost AS Cost FROM Orders
WHERE OrderID = ?';
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `user`@`%` 
    SQL SECURITY DEFINER
VIEW `OrdersView` AS
    SELECT 
        `Orders`.`OrderID` AS `OrderID`,
        `Orders`.`Quantity` AS `Quantity`,
        `Orders`.`TotalCost` AS `TotalCost`
    FROM
        `Orders`
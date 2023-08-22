show databases;
USE final_db_lemon;

SELECT * FROM customer_details;
SELECT * FROM menus;
SELECT * FROM orders;
SELECT * FROM delivery_status;
SELECT * FROM staff_information;
SELECT * FROM bookings;

# EXAMPLE to check Constraint --
#SELECT Full_Name, Email, Quantity
#FROM customer_details
#LEFT JOIN orders
#ON Customer_Details_Customer_ID=Customer_ID;

# ------------------------------------------------------
# EXERICES - WEEK 2: CREATE A VIRTUAL TABLE TO SUMMARIZE
# ------------------------------------------------------

# Taks 1
CREATE VIEW OrdersView AS SELECT Order_ID, Quantity, Total_Cost FROM orders;
SELECT * FROM OrdersView;

# Task 2
SELECT c.Customer_ID, c.Full_Name, o.Order_ID, o.Total_Cost, m.Cuisine, m.Course_Name, m.Starter_Name, m.Desert_Name
FROM customer_details c
INNER JOIN orders o
ON o.Customer_Details_Customer_ID=c.Customer_ID
INNER JOIN menus m
ON o.Menus_Menu_ID=m.Menu_ID;
#WHERE o.Total_Cost>150;

# Task 3
SELECT Cuisine
FROM Menus 
WHERE Menu_ID=ANY(SELECT Menus_Menu_ID FROM orders WHERE Quantity > 2);

# ------------------------------------------------------
# EXERICES - WEEK 2: CREATE OPTIMIZED QUERIES TO MANAGE AND ANALYZE DATA
# ------------------------------------------------------

# Task 1
DELIMITER //
CREATE PROCEDURE GetMaxQuantity() 
BEGIN
SELECT MAX(Quantity) AS Max_Qauntity_In_Order FROM orders;
END//
DELIMITER ;

CALL GetMaxQuantity();

# Task 2
PREPARE GetOrderDetail FROM 
'SELECT o.Order_ID, o.Quantity, o.Total_Cost 
FROM orders o
INNER JOIN customer_details cd
ON o.Customer_Details_Customer_ID=cd.Customer_ID
WHERE cd.Customer_ID=?';
SET @Customer_ID=1;
EXECUTE GetOrderDetail USING @Customer_ID;

# Task 3
DELIMITER //
CREATE PROCEDURE CancelOrder(IN order_to_cancel INT)
BEGIN
	DELETE FROM orders WHERE Order_ID=order_to_cancel;
END//
DELIMITER ;

CALL CancelOrder(5);

# ------------------------------------------------------
# EXERICES - WEEK 2: CREATE SQL QUERIES TO CHECK AVAILABLE BOOKINGS BASED ON USER INPUT
# ------------------------------------------------------

# Task 1
CREATE TABLE bookings_2 LIKE bookings; 
INSERT INTO bookings_2 SELECT * FROM bookings;
SELECT * FROM bookings_2;

# Task 2
DELIMITER //
CREATE PROCEDURE CheckBooking(IN booking_date DATE, IN table_number INT)
BEGIN
	#SELECT Date, Table_Number FROM bookings WHERE Date = booking_date AND Table_Number = table_number;
    IF EXISTS (SELECT * FROM bookings WHERE Date = booking_date) AND EXISTS (SELECT * FROM bookings WHERE table_number=Table_Number) THEN
		SELECT CONCAT("Table ", Table_Number, " is already booked") AS Message;
    ELSE
		SELECT "Table is available to make reservation" AS Message;
    END IF;
END//
DELIMITER ;

CALL CheckBooking("2023-08-7",7); # table available
CALL CheckBooking("2023-08-11",13); # table already booked

# Task 3

DELIMITER //
CREATE PROCEDURE AddValidBooking(IN booking_date DATE, IN table_number INT)
BEGIN 
DECLARE new_ID INT DEFAULT 0;
START TRANSACTION;
SET @new_ID = (SELECT MAX(Booking_ID) + 1 FROM bookings);
#INSERT INTO bookings(Booking_ID, Date, Table_Number) VALUES(@new_ID, booking_date, table_number);
IF EXISTS (SELECT * FROM bookings WHERE Date = booking_date) AND EXISTS (SELECT * FROM bookings WHERE table_number=Table_Number) THEN
	ROLLBACK;
	SELECT CONCAT("Table ", Table_Number, " is already booked - Booking canceled") AS Booking_Status;
ELSE    
	INSERT INTO bookings(Booking_ID, Date, Table_Number) VALUES(@new_ID, booking_date, table_number);
    COMMIT;
	SELECT CONCAT("Table ", Table_Number, " was booked whithout conflict") AS Booking_Status;
	END IF;
END//
DELIMITER ;

CALL AddValidBooking("2023-08-11",13); # Not Ok
CALL AddValidBooking("2023-08-30",1); # Ok

# ------------------------------------------------------
# EXERICES - WEEK 3: CREATE SQL QUERRIES TO ADD AND UPDATE BOOKINGS
# ------------------------------------------------------

# Task 1
DELIMITER //
CREATE PROCEDURE AddBooking(IN booking_ID INT, IN booking_date DATE, IN table_number INT)
BEGIN
INSERT INTO bookings(Booking_ID, Date, Table_Number) VALUES(booking_ID, booking_date, table_number);
SELECT "New booking added" AS "Confirmation";
END//
DELIMITER ;

CALL AddBooking(6, "2023-08-30", 1);
SELECT * FROM bookings;

# Task 2
DELIMITER //
CREATE PROCEDURE UpdateBooking(IN booking_ID INT, IN booking_date DATE)
BEGIN
UPDATE bookings SET Date=booking_date WHERE Booking_ID=booking_ID;
SELECT CONCAT("Booking ", booking_ID, "was updated") AS "Confirmation";
END//
DELIMITER ;

CALL UpdateBooking(6, "2023-08-25");
SELECT * FROM bookings;

# Task 3
DELIMITER //
# SET FOREIGN_KEY_CHECKS=OFF-dont acivate Script
# or use pattern ALTER TABLE (Child_table_Name) DROP FOREIGN KEY (Foreign_Key_Entry)
CREATE PROCEDURE CancelBooking(IN booking_ID INT) 
BEGIN
DELETE FROM bookings WHERE Booking_ID=booking_ID;
SELECT CONCAT("Booking ", booking_ID, "was deleted") AS "Confirmation";
END//
DELIMITER ;

CALL CancelBooking(6);
SELECT * FROM bookings;


# Verify the join to MySQL connector
SELECT cd.Customer_ID, cd.Full_Name, o.Total_Cost 
FROM customer_details cd
LEFT JOIN orders o
ON o.Customer_Details_Customer_ID=cd.Customer_ID
WHERE o.Total_Cost > 60
ORDER BY o.Total_Cost DESC;
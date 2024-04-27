drop database if exists food_delivery_system;
create database food_delivery_system;
use food_delivery_system;

DROP TABLE IF EXISTS team_details;

CREATE TABLE team_details (
roll_number char(8) NOT NULL UNIQUE,
first_name varchar(25) NOT NULL,
last_name varchar(25),
email_id varchar(50) NOT NULL,
PRIMARY KEY (roll_number)
);
INSERT INTO team_details (roll_number, first_name, last_name, email_id) VALUES
('22110050','Birudugadda','Srivibhav','birudugadda.srivibhav@iitgn.ac.in'),
('22110260', 'Srivathsa', 'Vamsi', 'vamsi.srivathsa@iitgn.ac.in'),
('22110124', 'Sriman', 'Reddy', 'kondam.reddy@iitgn.ac.in'),
('22110162', 'Nikhilesh', 'Myanapuri', 'rajesh.sharma@example.com'),
('20110106', 'Shriyash', 'Mandavekar', 'mandavekar.shriyash@iitgn.ac.in'),
('20110071', 'Haikoo', 'Khandor', 'haikoo.ashok@iitgn.ac.in'),
('20110104', 'Madhav', 'Kanda', 'madhav.kanda@iitgn.ac.in'),
('19110009', 'Deep', 'Thakkar', 'deep.st@iitgn.ac.in');

DROP TABLE IF EXISTS Address;

CREATE TABLE Address (
  address_id int(8) NOT NULL,
  building_name varchar(50) NOT NULL,
  street varchar(50) NOT NULL,
  pin_code varchar(6) NOT NULL,
  city varchar(50) NOT NULL,
  state varchar(30) NOT NULL,
  PRIMARY KEY (address_id)
) ;

INSERT INTO Address (address_id, building_name, street, pin_code, city, state) VALUES
(1, 'Building 1', 'MG Road', '560001', 'Bangalore', 'Karnataka'),
(2, 'Building 2', 'Park Street', '700001', 'Kolkata', 'West Bengal'),
(3, 'Building 3', 'Lalbagh Road', '560004', 'Bangalore', 'Karnataka'),
(4, 'Building 4', 'Bandra Kurla Complex', '400051', 'Mumbai', 'Maharashtra'),
(5, 'Building 5', 'Park Street', '700016', 'Kolkata', 'West Bengal'),
(6, 'Building 6', 'Dhole Patil Road', '411001', 'Pune', 'Maharashtra'),
(7, 'Building 7', 'Anna Salai', '600002', 'Chennai', 'Tamil Nadu'),
(8, 'Building 8', 'Connaught Place', '110001', 'New Delhi', 'Delhi'),
(9, 'Building 9', 'Richmond Road', '560025', 'Bangalore', 'Karnataka'),
(10, 'Building 10', 'Park Street', '700071', 'Kolkata', 'West Bengal'),
(11, 'Building 11', 'Juhu Tara Road', '400049', 'Mumbai', 'Maharashtra'),
(12, 'Building 12', 'Park Street', '700017', 'Kolkata', 'West Bengal'),
(13, 'Building 13', 'MG Road', '560001', 'Bangalore', 'Karnataka'),
(14, 'Building 14', 'Linking Road', '400054', 'Mumbai', 'Maharashtra'),
(15, 'Building 15', 'Park Street', '700019', 'Kolkata', 'West Bengal'),
(16, 'Building 16', 'Residency Road', '560025', 'Bangalore', 'Karnataka'),
(17, 'Building 17', 'Mount Road', '600002', 'Chennai', 'Tamil Nadu'),
(18, 'Building 18', 'Hill Road', '400050', 'Mumbai', 'Maharashtra'),
(19, 'Building 19', 'Gariahat Road', '700029', 'Kolkata', 'West Bengal'),
(20, 'Building 20', 'Magarpatta City', '411028', 'Pune', 'Maharashtra'),
(21, 'Building 21', 'Koramangala', '560034', 'Bangalore', 'Karnataka'),
(22, 'Building 22', 'Salt Lake City', '700091', 'Kolkata', 'West Bengal'),
(23, 'Building 23', 'Nungambakkam High Road', '600034', 'Chennai', 'Tamil Nadu'),
(24, 'Building 24', 'Andheri Kurla Road', '400059', 'Mumbai', 'Maharashtra'),
(25, 'Building 25', 'Dalhousie Square', '700001', 'Kolkata', 'West Bengal'),
(26, 'Building 26', 'Koregaon Park', '411001', 'Pune', 'Maharashtra'),
(27, 'Building 27', 'Indiranagar', '560038', 'Bangalore', 'Karnataka'),
(28, 'Building 28', 'Park Street', '700021', 'Kolkata', 'West Bengal'),
(29, 'Building 29', 'T Nagar', '600017', 'Chennai', 'Tamil Nadu'),
(30, 'Building 30', 'Malabar Hill', '400006', 'Mumbai', 'Maharashtra');

DROP TABLE IF EXISTS Customers;

CREATE TABLE Customers (
  customer_id int(8) NOT NULL,
  first_name varchar(50) NOT NULL,
  middle_name varchar(50) DEFAULT NULL,
  last_name varchar(50) NOT NULL,
  dob date DEFAULT NULL,
  age int(2) DEFAULT NULL,
  contact_details JSON,  -- JSON data type for contact details
  password varchar(50) NOT NULL,
  PRIMARY KEY (customer_id)
) ;

INSERT INTO Customers (customer_id, first_name, middle_name, last_name, dob, age, contact_details, password)
VALUES
(1, 'Rajesh', 'Kumar', 'Sharma', '1980-05-10', 41, '{"email": "rajesh.sharma@example.com", "phone": "9876543210"}', 'password1'),
(2, 'Anjali', NULL, 'Singh', '1995-08-20', 26, '{"email": "anjali.singh@example.com", "phone": "8765432109"}', 'password2'),
(3, 'Amit', 'Kumar', 'Patel', '1988-03-15', 33, '{"email": "amit.patel@example.com", "phone": "7654321098"}', 'password3'),
(4, 'Priya', NULL, 'Gupta', '1992-11-25', 29, '{"email": "priya.gupta@example.com", "phone": "6543210987"}', 'password4'),
(5, 'Manoj', 'Kumar', 'Yadav', '1982-07-08', 39, '{"email": "manoj.yadav@example.com", "phone": "5432109876"}', 'password5'),
(6, 'Deepika', NULL, 'Mishra', '1987-09-18', 34, '{"email": "deepika.mishra@example.com", "phone": "4321098765"}', 'password6'),
(7, 'Rahul', NULL, 'Verma', '1990-02-22', 31, '{"email": "rahul.verma@example.com", "phone": "3210987654"}', 'password7'),
(8, 'Sneha', NULL, 'Rajput', '1984-04-12', 37, '{"email": "sneha.rajput@example.com", "phone": "2109876543"}', 'password8'),
(9, 'Ajay', 'Singh', 'Chauhan', '1998-06-30', 23, '{"email": "ajay.chauhan@example.com", "phone": "1098765432"}', 'password9'),
(10, 'Ananya', NULL, 'Sharma', '1994-10-05', 27, '{"email": "ananya.sharma@example.com", "phone": "0987654321"}', 'password10'),
(11, 'Vikram', 'Singh', 'Rathore', '1986-12-04', 35, '{"email": "vikram.rathore@example.com", "phone": "9876543210"}', 'password11'),
(12, 'Neha', NULL, 'Yadav', '1991-03-28', 30, '{"email": "neha.yadav@example.com", "phone": "8765432109"}', 'password12'),
(13, 'Rakesh', 'Kumar', 'Sharma', '1989-08-15', 32, '{"email": "rakesh.sharma@example.com", "phone": "7654321098"}', 'password13'),
(14, 'Pooja', NULL, 'Gupta', '1993-05-20', 28, '{"email": "pooja.gupta@example.com", "phone": "6543210987"}', 'password14'),
(15, 'Vijay', NULL, 'Yadav', '1983-09-10', 38, '{"email": "vijay.yadav@example.com", "phone": "5432109876"}', 'password15');

DROP TABLE IF EXISTS Customer_Address;

CREATE TABLE Customer_Address (
  customer_id int(8)  NOT NULL,
  address_id int(8) NOT NULL,
  KEY customer_id (customer_id),
  KEY address_id (address_id),
  CONSTRAINT Customer_Address_ibfk_1 FOREIGN KEY (customer_id) REFERENCES Customers (customer_id) ON DELETE CASCADE,
  CONSTRAINT Customer_Address_ibfk_2 FOREIGN KEY (address_id) REFERENCES Address (address_id) ON DELETE CASCADE
) ;

INSERT INTO Customer_Address (customer_id, address_id)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15);

DROP TABLE IF EXISTS Payment;

CREATE TABLE Payment (
  payment_id int(8) NOT NULL,
  payment_method varchar(50) NOT NULL,
  payment_status ENUM('Successful', 'Failed', 'Pending') NOT NULL,
  amount decimal(10,2) NOT NULL,
  time timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (payment_id)
);

INSERT INTO Payment (payment_id, payment_method, payment_status, amount)
VALUES
(1,'Credit Card', 'Successful', 50.00),
(2, 'Debit Card', 'Successful', 30.50),
(3, 'UPI', 'Failed', 25.75),
(4, 'Credit Card', 'Successful', 40.00),
(5, 'Cash', 'Pending', 55.25),
(6, 'PayPal', 'Successful', 70.00),
(7, 'Debit Card', 'Failed', 20.00),
(8, 'Credit Card', 'Successful', 45.50),
(9, 'UPI', 'Successful', 35.75),
(10, 'Cash', 'Pending', 60.25),
(11, 'PayPal', 'Failed', 80.00),
(12, 'Credit Card', 'Successful', 55.50),
(13, 'Debit Card', 'Successful', 15.75),
(14, 'UPI', 'Failed', 30.00),
(15, 'Cash', 'Successful', 65.25);

DROP TABLE IF EXISTS Orders;

CREATE TABLE Orders (
  order_id int(8) NOT NULL,
  customer_id int(8) NOT NULL,
  restaurant_id int(8) NOT NULL,
  Payment_id int(8) NOT NULL,
  order_status ENUM('Delivered', 'Processing', 'Pending') NOT NULL,
  placed_time timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  amount decimal(10,2) NOT NULL,
  PRIMARY KEY (order_id),
  KEY customer_id (customer_id),
  KEY Payment_id (Payment_id),
  CONSTRAINT Orders_ibfk_1 FOREIGN KEY (customer_id) REFERENCES Customers (customer_id) ON DELETE CASCADE,
  CONSTRAINT Orders_ibfk_2 FOREIGN KEY (Payment_id) REFERENCES Payment (Payment_id)
) ;

INSERT INTO Orders (order_id, customer_id,restaurant_id, Payment_id, order_status, amount)
VALUES
(1, 1, 1, 1,'Delivered', 850.00),
(2, 2, 2, 2,'Delivered', 1440.00),
(3, 3, 3, 3,'Delivered', 540.00),
(4, 4, 4, 4,'Delivered', 400.00),
(5, 5, 5, 5,'Delivered', 500.00),
(6, 6, 6, 6,'Delivered', 620.00),
(7, 7, 7, 7,'Delivered', 920.00),
(8, 8, 8, 8,'Delivered', 300.00),
(9, 9, 9, 9,'Delivered', 300.00),
(10, 10, 10,10, 'Delivered', 300.00),
(11, 11, 11,11, 'Delivered', 300.00),
(12, 12, 12,12, 'Delivered', 300.00),
(13, 13, 13,13, 'Delivered', 300.00),
(14, 14, 14,14, 'Delivered', 300.00),
(15, 15, 15,15, 'Processing', 300.00);


DROP TABLE IF EXISTS Delivery_Agent;

CREATE TABLE Delivery_Agent (
  agent_id int(8) NOT NULL,
  vehicle_number varchar(20) NOT NULL,
  agent_name varchar(50) NOT NULL,
  phone_num varchar(20) NOT NULL,
  email varchar(50) NOT NULL,
  location varchar(100) NOT NULL,
  license_id varchar(20) NOT NULL,
  availability tinyint(1) NOT NULL,
  password varchar(50) NOT NULL,
  PRIMARY KEY (agent_id),
  UNIQUE KEY vehicle_number (vehicle_number),
  UNIQUE KEY phone_num (phone_num),
  UNIQUE KEY email (email),
  UNIQUE KEY license_id (license_id)
); 

INSERT INTO Delivery_Agent (agent_id, vehicle_number, agent_name, phone_num, email, location, license_id, availability, password)
VALUES
(1, 'KA01AB1234', 'Rahul Kumar', '+91 9876543210', 'rahul.kumar@example.com', 'Bangalore', 'DL123456', 1, 'password1'),
(2, 'WB02CD5678', 'Priya Sharma', '+91 8765432109', 'priya.sharma@example.com', 'Kolkata', 'DL238567', 1, 'password2'),
(3, 'MH03EF9012', 'Amit Patel', '+91 7654321098', 'amit.patel@example.com', 'Mumbai', 'DL945678', 1, 'password3'),
(4, 'TN04GH3456', 'Sneha Rajput', '+91 6543210987', 'sneha.rajput@example.com', 'Chennai', 'DL456789', 0, 'password4'),
(5, 'DL05IJ7890', 'Rakesh Sharma', '+91 5432109876', 'rakesh.sharma@example.com', 'Delhi', 'DL564890', 1, 'password5'),
(6, 'KA06KL1234', 'Anjali Singh', '+91 4321098765', 'anjali.singh@example.com', 'Bangalore', 'DL678901', 1, 'password6'),
(7, 'WB07MN5678', 'Manoj Yadav', '+91 3210987654', 'manoj.yadav@example.com', 'Kolkata', 'DL789012', 0, 'password7'),
(8, 'MH08OP9012', 'Deepika Mishra', '+91 2109876543', 'deepika.mishra@example.com', 'Mumbai', 'DL890123', 1, 'password8'),
(9, 'TN09QR3456', 'Vikram Rathore', '+91 1098765432', 'vikram.rathore@example.com', 'Chennai', 'DL901234', 1, 'password9'),
(10, 'DL10ST7890', 'Pooja Gupta', '+91 0987654321', 'pooja.gupta@example.com', 'Delhi', 'DL012345', 1, 'password10'),
(11, 'KA11UV1234', 'Ajay Chauhan', '+91 8876543250', 'ajay.chauhan@example.com', 'Bangalore', 'DL123457', 1, 'password11'),
(12, 'WB12WX5678', 'Ananya Sharma', '+91 7765432109', 'ananya.sharma@example.com', 'Kolkata', 'DL234567', 0, 'password12'),
(13, 'MH13YZ9012', 'Neha Yadav', '+91 8654361098', 'neha.yadav@example.com', 'Mumbai', 'DL345678', 1, 'password13'),
(14, 'TN14AB3456', 'Rajesh Verma', '+91 5543210987', 'rajesh.verma@example.com', 'Chennai', 'DL556789', 1, 'password14'),
(15, 'DL15CD7890', 'Suresh Kumar', '+91 4432109876', 'suresh.kumar@example.com', 'Delhi', 'DL567890', 1, 'password15');


DROP TABLE IF EXISTS Delivery;

CREATE TABLE Delivery (
  order_id int(8) NOT NULL,
  agent_id int(8) NOT NULL,
  customer_id int(8) NOT NULL,
  restaurant_id int(8) NOT NUll,
  delivery_review varchar(50) DEFAULT NULL,
  delivery_rating int(8) DEFAULT NULL,
  delivery_charges decimal(10,2) NOT NULL,
  pickup_time datetime NOT NULL,
  delivery_time datetime NOT NULL,
  delivery_status varchar(50) NOT NULL,
  tip decimal(10,2) DEFAULT NULL,
  KEY order_id (order_id),
  KEY agent_id (agent_id),
  CONSTRAINT Delivery_ibfk_1 FOREIGN KEY (order_id) REFERENCES Orders (order_id) ON DELETE CASCADE,
  CONSTRAINT Delivery_ibfk_2 FOREIGN KEY (agent_id) REFERENCES Delivery_Agent (agent_id),
  CONSTRAINT CHK_delivery_rating_range CHECK (delivery_rating >= 0 AND delivery_rating <= 5)
);


INSERT INTO Delivery (order_id, agent_id, customer_id, restaurant_id, delivery_review, delivery_rating, delivery_charges, pickup_time, delivery_time, delivery_status, tip)
VALUES
(1, 1, 1,1,'Good service', 4, 5.00, '2024-02-14 12:00:00', '2024-02-14 12:30:00', 'Delivered', 2.50),
(2, 1, 2,2,'Prompt delivery', 5, 4.50, '2024-02-14 13:15:00', '2024-02-14 13:45:00', 'Delivered', 3.00),
(3, 1, 3,3,'Excellent service', 3, 6.00, '2024-02-14 11:45:00', '2024-02-14 12:15:00', 'Delivered', 4.00),
(4, 1, 4,4,'N/A', 4, 7.00, '2024-02-14 14:30:00', '2024-02-14 15:00:00', 'On the way', 3.50),
(5, 5, 5,5,'Friendly delivery person', 4, 5.50, '2024-02-14 16:00:00', '2024-02-14 16:30:00', 'Delivered', 2.00),
(6, 6, 6,6,'Great experience', 2, 6.50, '2024-02-14 17:15:00', '2024-02-14 17:45:00', 'Delivered', 3.00),
(7, 7, 7,7,'Polite and efficient', 4, 7.50, '2024-02-14 18:30:00', '2024-02-14 19:00:00', 'Delivered', 2.50),
(8, 8, 8,8,'Satisfactory service', 1, 5.50, '2024-02-14 20:00:00', '2024-02-14 20:30:00', 'Delivered', 3.50),
(9,9,9,9,'Satisfactory service', 1, 6.00, '2024-02-14 21:00:00', '2024-02-14 20:30:00', 'Delivered', 3.50),
(10, 10, 10,10,'Satisfactory service', 2, 8.00, '2024-02-14 20:30:00', '2024-02-14 20:30:00', 'Delivered', 3.50),
(11, 11,11,11,'Satisfactory service', 3, 7.50, '2024-02-14 21:30:00', '2024-02-14 20:30:00', 'Delivered', 3.50),
(12, 12, 12,12,'Satisfactory service', 4, 8.50, '2024-02-14 19:30:00', '2024-02-14 20:30:00', 'Delivered', 3.50),
(13,13, 13,13,'Satisfactory service', 5, 9.50, '2024-02-14 21:20:00', '2024-02-14 20:30:00', 'Delivered', 3.50),
(14, 14, 14,14,'Satisfactory service', 3, 8.00, '2024-02-14 20:10:00', '2024-02-14 20:30:00', 'Delivered', 3.50),
(15, 15, 15,15,'Satisfactory service', 4, 7.00, '2024-02-14 23:10:00', '2024-02-14 20:30:00', 'Placed', 3.50);

DROP TABLE IF EXISTS Restaurant;

CREATE TABLE Restaurant (
  password varchar(50) NOT NULL,
  restaurant_id int(8) NOT NULL,
  restaurant_name varchar(100) NOT NULL,
  cuisine_type varchar(50) NOT NULL,
  email varchar(100) NOT NULL,
  phone varchar(30) NOT NULL,
  timings varchar(50) NOT NULL,
  rating decimal(3,2) DEFAULT NULL,
  account_no varchar(30) DEFAULT NULL,
  IFSC_code varchar(25) DEFAULT NULL,
  bank_name varchar(50) DEFAULT NULL,
  balance_earned int(100),
  review varchar(1000),
  PRIMARY KEY (restaurant_id),
  editing_menu int(1) DEFAULT 0
); 

INSERT INTO Restaurant (password, restaurant_id, restaurant_name, cuisine_type, email, phone, timings, rating, account_no, IFSC_code, bank_name, balance_earned, review,editing_menu)
VALUES
('password1', 1, 'Taj Mahal Restaurant', 'Indian', 'tajmahal@example.com', '+91 9876543210', '10:00 AM - 10:00 PM', 4.5, '1234567890123456789', 'INDB0000001', 'Indian Bank', '85', 'Amamzing food!; Loved it; Will visit again',0),
('password2', 2, 'Spice Garden', 'Indian', 'spicegarden@example.com', '+91 8765432109', '11:00 AM - 11:00 PM', 4.2, '9876543210123456789', 'BOIN0000002', 'Bank of India', '144', 'Very hot stuff; Very spicy',0),
('password3', 3, 'Punjabi Dhaba', 'North Indian', 'punjabidhaba@example.com', '+91 7654321098', '12:00 PM - 10:30 PM', 4.0, '0123456789012345678', 'AXIS0000003', 'Axis Bank','54', 'Good spicy food; Very good refreshments',0),
('password4', 4, 'Southern Spice', 'South Indian', 'southernspice@example.com', '+91 6543210987', '11:30 AM - 11:30 PM', 4.4, '5432109876543210123', 'KOTA0000004', 'Kotak Mahindra Bank', '40', 'very good ambience; perfect for first date',0),
('password5', 5, 'The Mughal Feast', 'Mughlai', 'mughalfeast@example.com', '+91 5432109876', '12:00 PM - 10:00 PM', 4.7, '2345678901234567890', 'HDFC0000005', 'HDFC Bank', '50', 'Amamzing music and hygeine; will definetly come again',1),
('password6', 6, 'Coastal Curry House', 'Coastal', 'coastalcurry@example.com', '+91 4321098765', '11:00 AM - 10:30 PM', 4.3, '7890123456789012345', 'YESB0000006', 'Yes Bank', '62', 'karioke; Amazing cook',0),
('password7', 7, 'Rajasthani Delight', 'Rajasthani', 'rajasthanidelight@example.com', '+91 3210987654', '12:30 PM - 11:00 PM', 4.6, '1012345678901234567', 'IDFB0000007', 'IDFC First Bank', '92', '100% would recommend; Will come again',0),
('password8', 8, 'Gujarati Thali', 'Gujarati', 'gujaratithali@example.com', '+91 2109876543', '11:00 AM - 10:00 PM', 4.1, '4567890123456789012', 'RBLB0000008', 'RBL Bank', '30', 'lovely food',0),
('password9', 9, 'Bengali Bhavan', 'Bengali', 'bengalibhavan@example.com', '+91 1098765432', '12:00 PM - 10:30 PM', 4.8, '8901234567890123456', 'INDB0000009', 'IndusInd Bank', '30', 'Very good non-vegetarian option; Nice refreshements',1),
('password10', 10, 'Hyderabadi Biryani House', 'Hyderabadi', 'hyderabadibiryani@example.com"', '+91 0987654321', '11:30 AM - 11:00 PM', 4.5, '3456789012345678901', 'SCBL0000010', 'Standard Chartered Bank', '30', 'Nice Food; Nice Staff',0),
('password11', 11, 'Kerala Cuisine Corner', 'Kerala', 'keralacuisine@example.com', '+91 9876543210', '12:00 PM - 10:00 PM', 4.2, '2345609876543210123', 'HSBC0000011', 'HSBC India', '30', 'Good for family; Good Culture',0),
('password12', 12, 'Maharashtrian Delicacies', 'Maharashtrian', 'maharashtriandelicacies@example.com', '+91 8765432109', '11:00 AM - 10:30 PM', 4.7, '7890101234567890123', 'BARO0000012', 'Bank of Baroda', '30', 'Definetly coming back again; Loved it',0),
('password13', 13, 'Goan Flavors', 'Goan', 'goanflavors@example.com', '+91 7654321098', '12:30 PM - 11:00 PM', 4.4, '1234509876543210123', 'CENB0000013', 'Central Bank of India', '30', 'Nice staff; Good cook',1),
('password14', 14, 'Parsi Paradise', 'Parsi', 'parsiparadise@example.com', '+91 6543210987', '11:00 AM - 10:00 PM', 4.6, '5678901234567890123', 'PUNB0000014', 'Punjab National Bank', '30', 'Tipped extra; Very good service',0),
('password15', 15, 'Assamese Aroma', 'Assamese', 'assamesearoma@example.com', '+91 5432109876', '12:00 PM - 10:30 PM', 4.3, '9012345678901234567', 'MAHB0000015', 'Bank of Maharashtra', '30', 'Kind staff; Good Cook',0);

DROP TABLE IF EXISTS Restaurant_Address;

CREATE TABLE Restaurant_Address (
  restaurant_id int(8) NOT NULL,
  address_id int(8) NOT NULL,
  KEY restaurant_id (restaurant_id),
  KEY address_id (address_id),
  CONSTRAINT Restaurant_Address_ibfk_1 FOREIGN KEY (restaurant_id) REFERENCES Restaurant (restaurant_id) ON DELETE CASCADE,
  CONSTRAINT Restaurant_Address_ibfk_2 FOREIGN KEY (address_id) REFERENCES Address (address_id) ON DELETE CASCADE
) ;

INSERT INTO Restaurant_Address (restaurant_id, address_id)
VALUES
(1, 16),
(2, 17),
(3, 18),
(4, 19),
(5, 20),
(6, 21),
(7, 22),
(8, 23),
(9, 24),
(10, 25),
(11, 26),
(12, 27),
(13, 28),
(14, 29),
(15, 30);

DROP TABLE IF EXISTS Food_Item;

CREATE TABLE Food_Item (
  item_id int(8) NOT NULL,
  restaurant_id int(8) NOT NULL,
  item_name varchar(50) NOT NULL,
  item_type varchar(50) NOT NULL,
  item_price decimal(10,2) NOT NULL,
  item_rating decimal(3,2) DEFAULT NULL,
  vegetarian tinyint(1) NOT NULL,
  photo_url varchar(100) DEFAULT NULL,
  image blob default NULL,
  availability tinyint(1) NOT NULL,
  order_count int(8) NOT NULL DEFAULT 0,
  PRIMARY KEY (item_id),
  KEY restaurant_id (restaurant_id),
  CONSTRAINT Food_Item_ibfk_1 FOREIGN KEY (restaurant_id) REFERENCES Restaurant (restaurant_id) ON DELETE CASCADE
);

INSERT INTO Food_Item (item_id, restaurant_id, item_name, item_type, item_price, item_rating, vegetarian, photo_url,image,availability, order_count)
VALUES
(1, 1, 'Paneer Tikka', 'Starter', 250.00, 4.5, 0, 'https://example.com/paneer_tikka.jpg',NULL, 1, 50),
(2, 2, 'Chicken Biryani', 'Main Course', 300.00, 4.2, 0, 'https://example.com/chicken_biryani.jpg',NULL, 1, 70),
(3, 3, 'Butter Chicken', 'Main Course', 350.00, 4.3, 0, 'https://example.com/butter_chicken.jpg',NULL, 1, 60),
(4, 4, 'Masala Dosa', 'Breakfast', 100.00, 4.6, 1, 'https://example.com/masala_dosa.jpg',NULL, 1, 80),
(5, 5, 'Mutton Rogan Josh', 'Main Course', 400.00, 4.4, 0, 'https://example.com/mutton_rogan_josh.jpg',NULL, 1, 45),
(6, 6, 'Fish Curry', 'Main Course', 320.00, 4.1, 0, 'https://example.com/fish_curry.jpg',NULL, 1, 55),
(7, 7, 'Thali', 'Combo Meal', 200.00, 4.7, 1, 'https://example.com/thali.jpg',NULL, 1, 65),
(8, 8, 'Chole Bhature', 'Breakfast', 120.00, 4.2, 1, 'https://example.com/chole_bhature.jpg',NULL, 1, 40),
(9, 9, 'Rosogolla', 'Dessert', 50.00, 4.8, 1, 'https://example.com/rosogolla.jpg',NULL, 1, 90),
(10, 10, 'Hyderabadi Chicken Dum Biryani', 'Main Course', 380.00, 4.5, 0, 'https://example.com/hyderabadi_chicken_dum_biryani.jpg',NULL, 1, 75),
(11, 11, 'Appam with Stew', 'Breakfast', 150.00, 4.3, 1, 'https://example.com/appam_with_stew.jpg',NULL, 1, 30),
(12, 12, 'Misal Pav', 'Snack', 80.00, 4.7, 1, 'https://example.com/misal_pav.jpg',NULL, 1, 85),
(13, 13, 'Prawn Balchao', 'Main Course', 350.00, 4.4, 0, 'https://example.com/prawn_balchao.jpg',NULL, 1, 65),
(14, 14, 'Dhansak', 'Main Course', 300.00, 4.6, 0, 'https://example.com/dhansak.jpg',NULL, 1, 55),
(15, 15, 'Assamese Thali', 'Combo Meal', 220.00, 4.5, 1, 'https://example.com/assamese_thali.jpg',NULL, 1, 70);

INSERT INTO Food_Item (item_id, restaurant_id, item_name, item_type, item_price, item_rating, vegetarian, photo_url,image,availability, order_count)
VALUES
(16, 1, 'Chicken Tikka', 'Starter', 270.00, 4.4, 0, 'https://example.com/chicken_tikka.jpg',NULL, 1, 40),
(17, 1, 'Vegetable Biryani', 'Main Course', 220.00, 4.2, 1, 'https://example.com/vegetable_biryani.jpg',NULL, 1, 60),
(18, 1, 'Dal Makhani', 'Main Course', 200.00, 4.5, 1, 'https://example.com/dal_makhani.jpg',NULL, 1, 55),
(19, 1, 'Gulab Jamun', 'Dessert', 80.00, 4.6, 1, 'https://example.com/gulab_jamun.jpg',NULL, 1, 70),
(20, 1, 'Aloo Paratha', 'Breakfast', 120.00, 4.3, 1, 'https://example.com/aloo_paratha.jpg',NULL, 1, 45);

INSERT INTO Food_Item (item_id, restaurant_id, item_name, item_type, item_price, item_rating, vegetarian, photo_url,image,availability, order_count)
VALUES
(21, 2, 'Veg Pulao', 'Main Course', 180.00, 4.1, 1, 'https://example.com/veg_pulao.jpg',NULL, 1, 50),
(22, 2, 'Egg Curry', 'Main Course', 250.00, 4.3, 0, 'https://example.com/egg_curry.jpg',NULL, 1, 65),
(23, 2, 'Fish Fry', 'Starter', 280.00, 4.2, 0, 'https://example.com/fish_fry.jpg',NULL, 1, 55),
(24, 2, 'Prawn Pulao', 'Main Course', 320.00, 4.4, 0, 'https://example.com/prawn_pulao.jpg',NULL, 1, 75),
(25, 2, 'Raita', 'Side Dish', 60.00, 4.5, 1, 'https://example.com/raita.jpg',NULL, 1, 35);

INSERT INTO Food_Item (item_id, restaurant_id, item_name, item_type, item_price, item_rating, vegetarian, photo_url,image,availability, order_count)
VALUES
(26, 3, 'Palak Paneer', 'Main Course', 230.00, 4.4, 1, 'https://example.com/palak_paneer.jpg',NULL, 1, 60),
(27, 3, 'Veg Manchurian', 'Starter', 200.00, 4.2, 1, 'https://example.com/veg_manchurian.jpg',NULL, 1, 45),
(28, 3, 'Pav Bhaji', 'Snack', 150.00, 4.5, 1, 'https://example.com/pav_bhaji.jpg',NULL, 1, 70),
(29, 3, 'Rasgulla', 'Dessert', 70.00, 4.3, 1, 'https://example.com/rasgulla.jpg',NULL, 1, 40),
(30, 3, 'Vegetable Soup', 'Starter', 100.00, 4.6, 1, 'https://example.com/vegetable_soup.jpg',NULL, 1, 55);

-- Restaurant 4
INSERT INTO Food_Item (item_id, restaurant_id, item_name, item_type, item_price, item_rating, vegetarian, photo_url,image,availability, order_count)
VALUES
(31, 4, 'Idli', 'Breakfast', 60.00, 4.2, 1, 'https://example.com/idli.jpg',NULL, 1, 30),
(32, 4, 'Vada', 'Breakfast', 50.00, 4.0, 1, 'https://example.com/vada.jpg',NULL, 1, 25),
(33, 4, 'Plain Dosa', 'Breakfast', 70.00, 4.4, 1, 'https://example.com/plain_dosa.jpg',NULL, 1, 35),
(34, 4, 'Medu Vada', 'Breakfast', 60.00, 4.3, 1, 'https://example.com/medu_vada.jpg',NULL, 1, 40),
(35, 4, 'Filter Coffee', 'Beverage', 40.00, 4.5, 1, 'https://example.com/filter_coffee.jpg',NULL, 1, 20);

-- Restaurant 5
INSERT INTO Food_Item (item_id, restaurant_id, item_name, item_type, item_price, item_rating, vegetarian, photo_url,image,availability, order_count)
VALUES
(36, 5, 'Chicken Curry', 'Main Course', 280.00, 4.1, 0, 'https://example.com/chicken_curry.jpg',NULL, 1, 50),
(37, 5, 'Chapati', 'Main Course', 20.00, 4.0, 1, 'https://example.com/chapati.jpg',NULL, 1, 60),
(38, 5, 'Fish Fry', 'Starter', 250.00, 4.3, 0, 'https://example.com/fish_fry_2.jpg',NULL, 1, 70),
(39, 5, 'Prawn Curry', 'Main Course', 300.00, 4.2, 0, 'https://example.com/prawn_curry.jpg',NULL, 1, 45),
(40, 5, 'Kheer', 'Dessert', 100.00, 4.5, 1, 'https://example.com/kheer.jpg',NULL, 1, 55);

-- Restaurant 6
INSERT INTO Food_Item (item_id, restaurant_id, item_name, item_type, item_price, item_rating, vegetarian, photo_url,image,availability, order_count)
VALUES
(41, 6, 'Paneer Butter Masala', 'Main Course', 220.00, 4.4, 1, 'https://example.com/paneer_butter_masala.jpg',NULL, 1, 60),
(42, 6, 'Jeera Rice', 'Main Course', 120.00, 4.2, 1, 'https://example.com/jeera_rice.jpg',NULL, 1, 70),
(43, 6, 'Chicken 65', 'Starter', 250.00, 4.5, 0, 'https://example.com/chicken_65.jpg',NULL, 1, 45),
(44, 6, 'Gajar Halwa', 'Dessert', 150.00, 4.3, 1, 'https://example.com/gajar_halwa.jpg',NULL, 1, 55),
(45, 6, 'Masala Papad', 'Starter', 80.00, 4.1, 1, 'https://example.com/masala_papad.jpg',NULL, 1, 35);

-- Restaurant 7
INSERT INTO Food_Item (item_id, restaurant_id, item_name, item_type, item_price, item_rating, vegetarian, photo_url,image,availability, order_count)
VALUES
(46, 7, 'Rajma Chawal', 'Main Course', 180.00, 4.2, 1, 'https://example.com/rajma_chawal.jpg',NULL, 1, 50),
(47, 7, 'Chole Kulche', 'Breakfast', 100.00, 4.1, 1, 'https://example.com/chole_kulche.jpg',NULL, 1, 60),
(48, 7, 'Aloo Tikki', 'Snack', 70.00, 4.3, 1, 'https://example.com/aloo_tikki.jpg',NULL, 1, 70),
(49, 7, 'Gulab Jamun', 'Dessert', 80.00, 4.5, 1, 'https://example.com/gulab_jamun_2.jpg',NULL, 1, 45),
(50, 7, 'Lassi', 'Beverage', 50.00, 4.4, 1, 'https://example.com/lassi.jpg',NULL, 1, 55);

-- Restaurant 8
INSERT INTO Food_Item (item_id, restaurant_id, item_name, item_type, item_price, item_rating, vegetarian, photo_url,image,availability, order_count)
VALUES
(51, 8, 'Rasam', 'Soup', 90.00, 4.1, 1, 'https://example.com/rasam.jpg',NULL, 1, 60),
(52, 8, 'Paneer Paratha', 'Breakfast', 100.00, 4.2, 1, 'https://example.com/paneer_paratha.jpg',NULL, 1, 70),
(53, 8, 'Papad', 'Side Dish', 30.00, 4.0, 1, 'https://example.com/papad.jpg',NULL, 1, 50),
(54, 8, 'Thums Up', 'Beverage', 40.00, 4.3, 1, 'https://example.com/thums_up.jpg',NULL, 1, 45),
(55, 8, 'Gajar Matar', 'Main Course', 150.00, 4.4, 1, 'https://example.com/gajar_matar.jpg',NULL, 1, 55);

-- Restaurant 9
INSERT INTO Food_Item (item_id, restaurant_id, item_name, item_type, item_price, item_rating, vegetarian, photo_url,image,availability, order_count)
VALUES
(56, 9, 'Puliyodharai', 'Main Course', 200.00, 4.3, 1, 'https://example.com/puliyodharai.jpg',NULL, 1, 40),
(57, 9, 'Sambar', 'Soup', 100.00, 4.4, 1, 'https://example.com/sambar.jpg',NULL, 1, 45),
(58, 9, 'Paniyaram', 'Snack', 120.00, 4.5, 1, 'https://example.com/paniyaram.jpg',NULL, 1, 50),
(59, 9, 'Masala Chai', 'Beverage', 60.00, 4.2, 1, 'https://example.com/masala_chai.jpg',NULL, 1, 60),
(60, 9, 'Kaju Katli', 'Dessert', 180.00, 4.6, 1, 'https://example.com/kaju_katli.jpg',NULL, 1, 55);

-- Restaurant 10
INSERT INTO Food_Item (item_id, restaurant_id, item_name, item_type, item_price, item_rating, vegetarian, photo_url,image,availability, order_count)
VALUES
(61, 10, 'Maggi', 'Snack', 50.00, 4.0, 1, 'https://example.com/maggi.jpg',NULL, 1, 50),
(62, 10, 'Veg Roll', 'Snack', 60.00, 4.2, 1, 'https://example.com/veg_roll.jpg',NULL, 1, 40),
(63, 10, 'Egg Fried Rice', 'Main Course', 120.00, 4.3, 0, 'https://example.com/egg_fried_rice.jpg',NULL, 1, 60),
(64, 10, 'Chicken Noodles', 'Main Course', 140.00, 4.1, 0, 'https://example.com/chicken_noodles.jpg',NULL, 1, 45),
(65, 10, 'Cold Coffee', 'Beverage', 80.00, 4.5, 1, 'https://example.com/cold_coffee.jpg',NULL, 1, 55);

-- Restaurant 11
INSERT INTO Food_Item (item_id, restaurant_id, item_name, item_type, item_price, item_rating, vegetarian, photo_url,image,availability, order_count)
VALUES
(66, 11, 'Chicken Lollipop', 'Starter', 200.00, 4.4, 0, 'https://example.com/chicken_lollipop.jpg',NULL, 1, 40),
(67, 11, 'Egg Bhurji', 'Breakfast', 100.00, 4.2, 0, 'https://example.com/egg_bhurji.jpg',NULL, 1, 60),
(68, 11, 'Pav Vada', 'Snack', 120.00, 4.5, 1, 'https://example.com/pav_vada.jpg',NULL, 1, 70),
(69, 11, 'Rumali Roti', 'Bread', 50.00, 4.3, 1, 'https://example.com/rumali_roti.jpg',NULL, 1, 45),
(70, 11, 'Tandoori Chicken', 'Starter', 250.00, 4.6, 0, 'https://example.com/tandoori_chicken.jpg',NULL, 1, 55);

-- Restaurant 12
INSERT INTO Food_Item (item_id, restaurant_id, item_name, item_type, item_price, item_rating, vegetarian, photo_url,image,availability, order_count)
VALUES
(71, 12, 'Dhokla', 'Snack', 60.00, 4.2, 1, 'https://example.com/dhokla.jpg',NULL, 1, 30),
(72, 12, 'Samosa', 'Snack', 40.00, 4.1, 1, 'https://example.com/samosa.jpg',NULL, 1, 25),
(73, 12, 'Pakora', 'Snack', 50.00, 4.3, 1, 'https://example.com/pakora.jpg',NULL, 1, 35),
(74, 12, 'Aloo Tikki Chaat', 'Snack', 70.00, 4.4, 1, 'https://example.com/aloo_tikki_chaat.jpg',NULL, 1, 40),
(75, 12, 'Kachori', 'Snack', 60.00, 4.0, 1, 'https://example.com/kachori.jpg',NULL, 1, 20);

-- Restaurant 13
INSERT INTO Food_Item (item_id, restaurant_id, item_name, item_type, item_price, item_rating, vegetarian, photo_url,image,availability, order_count)
VALUES
(76, 13, 'Momo', 'Snack', 80.00, 4.3, 1, 'https://example.com/momo.jpg',NULL, 1, 50),
(77, 13, 'Thukpa', 'Main Course', 120.00, 4.2, 1, 'https://example.com/thukpa.jpg',NULL, 1, 60),
(78, 13, 'Pork Curry', 'Main Course', 200.00, 4.4, 0, 'https://example.com/pork_curry.jpg',NULL, 1, 70),
(79, 13, 'Sel Roti', 'Snack', 50.00, 4.5, 1, 'https://example.com/sel_roti.jpg',NULL, 1, 45),
(80, 13, 'Gundruk', 'Side Dish', 80.00, 4.1, 1, 'https://example.com/gundruk.jpg',NULL, 1, 35);

-- Restaurant 14
INSERT INTO Food_Item (item_id, restaurant_id, item_name, item_type, item_price, item_rating, vegetarian, photo_url,image,availability, order_count)
VALUES
(81, 14, 'Momo', 'Snack', 100.00, 4.3, 1, 'https://example.com/momo_2.jpg',NULL, 1, 40),
(82, 14, 'Thukpa', 'Main Course', 150.00, 4.2, 1, 'https://example.com/thukpa_2.jpg',NULL, 1, 45),
(83, 14, 'Pork Curry', 'Main Course', 250.00, 4.4, 0, 'https://example.com/pork_curry_2.jpg',NULL, 1, 55),
(84, 14, 'Sel Roti', 'Snack', 60.00, 4.5, 1, 'https://example.com/sel_roti_2.jpg',NULL, 1, 50),
(85, 14, 'Gundruk', 'Side Dish', 90.00, 4.1, 1, 'https://example.com/gundruk_2.jpg',NULL, 1, 60);

-- Restaurant 15
INSERT INTO Food_Item (item_id, restaurant_id, item_name, item_type, item_price, item_rating, vegetarian, photo_url,image,availability, order_count)
VALUES
(86, 15, 'Pakhala Bhata', 'Main Course', 100.00, 4.2, 1, 'https://example.com/pakhala_bhata.jpg',NULL, 1, 50),
(87, 15, 'Dahi Baingan', 'Main Course', 120.00, 4.0, 1, 'https://example.com/dahi_baingan.jpg',NULL, 1, 55),
(88, 15, 'Chenna Poda', 'Dessert', 80.00, 4.4, 1, 'https://example.com/chenna_poda.jpg',NULL, 1, 60),
(89, 15, 'Pani Pitha', 'Snack', 70.00, 4.3, 1, 'https://example.com/pani_pitha.jpg',NULL, 1, 65),
(90, 15, 'Khaja', 'Dessert', 90.00, 4.5, 1, 'https://example.com/khaja.jpg',NULL, 1, 70);

DROP TABLE IF EXISTS Ordered_items;

CREATE TABLE Ordered_items (
  order_id int(8) NOT NULL,
  item_id int(8) NOT NULL,
  item_quantity int(8) NOT NULL,
  item_rating decimal(3,2) DEFAULT NULL,
  item_review varchar(50) DEFAULT NULL,
  notes varchar(100) DEFAULT NULL,
  KEY order_id (order_id),
  KEY item_id (item_id),
  CONSTRAINT Ordered_items_ibfk_1 FOREIGN KEY (order_id) REFERENCES Orders (order_id) ON DELETE CASCADE,
  CONSTRAINT Ordered_items_ibfk_2 FOREIGN KEY (item_id) REFERENCES Food_Item (item_id) ON DELETE CASCADE,
  CONSTRAINT CHK_item_rating_range CHECK (item_rating >= 0 AND item_rating <= 5)
);

INSERT INTO Ordered_items (order_id, item_id, item_quantity, item_rating, item_review, notes)
VALUES
(1, 1, 2, 4.5, 'Excellent dish', 'Extra spicy please'),
(1, 3, 1, 4.2, 'Good', NULL),
(2, 5, 3, 4.8, 'Absolutely delicious!', 'No onions please'),
(2, 8, 2, NULL, NULL, NULL),
(3, 10, 1, 4.5, 'Loved it!', NULL),
(3, 12, 2, 4.6, 'Great taste', 'Extra sauce on the side'),
(4, 4, 2, NULL, NULL, 'Extra crispy dosa'),
(4, 7, 1, 4.7, 'Wonderful Thali', NULL),
(5, 9, 1, 4.9, 'Best dessert ever!', NULL),
(5, 11, 3, 4.3, 'Nice combination', NULL),
(6, 2, 1, 4.4, 'Tasty biryani', NULL),
(6, 6, 1, 4.1, 'Good curry', NULL),
(7, 13, 2, 4.5, 'Spicy and flavorful', NULL),
(7, 15, 1, 4.6, 'Delicious', NULL),
(8, 14, 1, 4.7, 'Authentic taste', NULL);
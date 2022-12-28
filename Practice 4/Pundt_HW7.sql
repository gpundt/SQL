/*NAME: Griffin Pundt
CLASS: ISTE230
ASSIGNMENT: HW7*/

/*Create Database named Pundt_ACMEOnline*/
DROP DATABASE IF EXISTS Pundt_ACMEOnline;
CREATE DATABASE Pundt_ACMEOnline;
USE Pundt_ACMEOnline;


/*Create CATEGORY table*/
CREATE TABLE CATEGORY(
	categoryName VARCHAR(35),
	shippingPerPound DECIMAL(4, 2),
	offersAllowed CHAR CHECK (offersAllowed="y" OR offersAllowed="n"),
	CONSTRAINT company_pk PRIMARY KEY (categoryName)
	)ENGINE=InnoDB DEFAULT CHARSET=utf8;
	
	DESCRIBE CATEGORY;

/*Create OFFER table*/
CREATE TABLE OFFER(
	offerCode VARCHAR(15),
	discountAmt VARCHAR(35) NOT NULL DEFAULT 0,
	minAmount DECIMAL(4, 2) NOT NULL DEFAULT 0,
	expirationDate DATE NOT NULL DEFAULT "1999-01-01",
	CONSTRAINT offer_pk PRIMARY KEY(offerCode)
	)ENGINE=InnoDB DEFAULT CHARSET=utf8;
	
	DESCRIBE OFFER;

/*Create CUSTOMER table*/
CREATE TABLE CUSTOMER(
	customerID INTEGER UNSIGNED AUTO_INCREMENT,
	customerName VARCHAR(50) NOT NULL,
	address VARCHAR(150) NOT NULL,
	email VARCHAR(80),
	businessCustomer CHAR NOT NULL CHECK(businessCustomer="y" OR businessCustomer="n") DEFAULT "n",
	homeCustomer CHAR NOT NULL CHECK(homeCustomer="y" OR homeCustomer="n") DEFAULT "n",
	CONSTRAINT customer_pk PRIMARY KEY(customerID)
	)ENGINE=InnoDB DEFAULT CHARSET=utf8;
	
	DESCRIBE CUSTOMER;
	
/*Create BUSINESS table; subtype of CUSTOMER*/
CREATE TABLE BUSINESS(
	customerID INTEGER UNSIGNED AUTO_INCREMENT,
	paymentTerms VARCHAR(50) NOT NULL,
	CONSTRAINT business_pk PRIMARY KEY(customerID),
	CONSTRAINT business_customerID_fk FOREIGN KEY(customerID) REFERENCES CUSTOMER(customerID)
		ON UPDATE CASCADE
	)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DESCRIBE BUSINESS;

/*Create HOME table; subtype of CUSTOMER*/
CREATE TABLE HOME(
	customerID INTEGER UNSIGNED AUTO_INCREMENT,
	creditCardNum CHAR(16) NOT NULL,
	cardExpiration CHAR(6) NOT NULL,
	CONSTRAINT home_pk PRIMARY KEY(customerID),
	CONSTRAINT home_customerID_fk FOREIGN KEY(customerID) REFERENCES CUSTOMER(customerID)
		ON UPDATE CASCADE
	)ENGINE=InnoDB DEFAULT CHARSET=utf8;
	
DESCRIBE HOME;

/*Create PURCHASE_CONTACT table*/
CREATE TABLE PURCHASE_CONTACT(
	contactName VARCHAR(50),
	customerID INTEGER UNSIGNED AUTO_INCREMENT,
	contactPhone CHAR(12) NOT NULL,
	CONSTRAINT pcontact_pk PRIMARY KEY(contactName, customerID),
	CONSTRAINT pcontact_customerID_fk FOREIGN KEY(customerID) REFERENCES BUSINESS(customerID)
		ON DELETE CASCADE
		ON UPDATE CASCADE
	)ENGINE=InnoDB DEFAULT CHARSET=utf8;
	
DESCRIBE PURCHASE_CONTACT;


/*Create ITEM table*/
CREATE TABLE ITEM(
	itemNumber INTEGER UNSIGNED AUTO_INCREMENT,
	itemName VARCHAR(35) NOT NULL,
	description VARCHAR(255),
	modelNum VARCHAR(50) NOT NULL,
	price DECIMAL(8, 2) NOT NULL,
	categoryName VARCHAR(35),
	CONSTRAINT item_pk PRIMARY KEY(itemNumber),
	CONSTRAINT item_categoryName_fk FOREIGN KEY(categoryName) REFERENCES CATEGORY(categoryName)
		ON UPDATE CASCADE
	)ENGINE=InnoDB DEFAULT CHARSET=utf8;
	
DESCRIBE ITEM;

/*Create ORDERED table*/
CREATE TABLE ORDERED(
	orderID INTEGER UNSIGNED AUTO_INCREMENT,
	totalCost DECIMAL(10, 2),
	customerID INTEGER UNSIGNED,
	offerCode VARCHAR(15),
	CONSTRAINT ordered_pk PRIMARY KEY(orderID),
	CONSTRAINT ordered_customerID_fk FOREIGN KEY(customerID) REFERENCES CUSTOMER(customerID)
		ON UPDATE CASCADE,
	CONSTRAINT ordered_offerCode_fk FOREIGN KEY(offerCode) REFERENCES OFFER(offerCode)
		ON UPDATE CASCADE
	)ENGINE=InnoDB DEFAULT CHARSET=utf8;
	
DESCRIBE ORDERED;

/*Create LINE_ITEM table*/
CREATE TABLE LINE_ITEM(
	itemNumber INTEGER UNSIGNED,
	orderID INTEGER UNSIGNED,
	quantity TINYINT,
	shippingAmount DECIMAL(6, 2),
	CONSTRAINT line_item_pk PRIMARY KEY(itemNumber, orderID),
	CONSTRAINT line_item_itemNumber_fk FOREIGN KEY(itemNumber) REFERENCES ITEM(itemNumber)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT line_item_orderID_fk FOREIGN KEY(orderID) REFERENCES ORDERED(orderID)
		ON UPDATE CASCADE
	)ENGINE=InnoDB DEFAULT CHARSET=utf8;
	
DESCRIBE LINE_ITEM;


/*Create GUARANTEE table*/
CREATE TABLE GUARANTEE(
	orderID INTEGER UNSIGNED,
	customerID INTEGER UNSIGNED,
	url VARCHAR(50),
	refundAmount DECIMAL(12, 2),
	CONSTRAINT guarantee_pk PRIMARY KEY(orderID, customerID),
	CONSTRAINT guarantee_orderID_fk FOREIGN KEY(orderID) REFERENCES ORDERED(orderID)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	CONSTRAINT guarantee_customerID_fk FOREIGN KEY(customerID) REFERENCES HOME(customerID)
		ON UPDATE CASCADE
	)ENGINE=InnoDB DEFAULT CHARSET=utf8;
	
DESCRIBE GUARANTEE;


/*----------------------------------------------------------*/
/*Inserting Data*/
/*----------------------------------------------------------*/

/*Populate CATEGORY table*/
INSERT INTO CATEGORY 
VALUES
	("Books", 0.99, "y"),
	("Home", 1.99, "y"),
	("Jewelry", 0.99, "n"),
	("Toys", 0.99, "y");
	
SELECT *
FROM CATEGORY;


/*Populate ITEM Table*/
INSERT INTO ITEM (itemName, description, modelNum, price, categoryName)
VALUES
	("Cabbage Patch Doll", "Baby boy doll", "Boy", 39.95, "Toys"),
	("The Last Lecture", "Written by Randy Pausch", "Hardcover", 9.95, "Books"),
	("Keurig Beverage Maker", "Keurig Platinum Edition Beverage Maker in Red", "Platinum Edition", 299.95, "Home"),
	("1ct Diamond Ring in White Gold", "Diamond is certified vvs, D, round", "64gt32", 4000.00, "Jewelry");
	
SELECT *
FROM ITEM;


/*Populate OFFER table*/
INSERT INTO OFFER
VALUES
	("345743213", "20% off", 20.00, '2013-12-31'),
	("4567890123", "30% off", 30.00, '2013-12-31');
	
SELECT *
FROM OFFER;


/*----------------------------------------------------------*/
/*Executing Transactions*/
/*----------------------------------------------------------*/
/*Jaine Jeffers*/
START TRANSACTION;
		INSERT INTO CUSTOMER (customerName, address, email)
		VALUES
			("Jaine Jeffers", "152 Lomb Memorial Dr., Rochester, NY, 14623", "jxj1234@rit.edu");
		
		INSERT INTO HOME (customerID, creditCardNum, cardExpiration)
			SELECT customerID, "1234567890123456", "012014" 
			FROM CUSTOMER
			WHERE customerName = "Jaine Jeffers";
			
		UPDATE CUSTOMER
		SET homeCustomer="y"
		WHERE customerName = "Jaine Jeffers";
		
		INSERT INTO ORDERED (totalCost, customerID, offerCode)
		VALUES
			(4919.75, (SELECT customerID FROM CUSTOMER WHERE customerName = "Jaine Jeffers"), "4567890123");
	
		INSERT INTO LINE_ITEM(itemNumber, orderID, quantity, shippingAmount)
		VALUES
			(4, (SELECT orderID FROM ORDERED WHERE customerID = 1), "1", 0.99),
			(2, (SELECT orderID FROM ORDERED WHERE customerID = 1), "2", 3.99);
		INSERT INTO LINE_ITEM (itemNumber, orderID, quantity)
		VALUES
			(3, 1, "3");
		
COMMIT;

SELECT *
FROM CUSTOMER;

SELECT *
FROM HOME;

SELECT *
FROM ORDERED;

SELECT *
FROM LINE_ITEM;


/*----------------------------------------------------------*/
/*Joey John Barber Shop*/
START TRANSACTION;
		INSERT INTO CUSTOMER (customerName, address, email)
		VALUES
			("Joey John Barber Shop", "15 John St., Rochester, NY, 14623", "jj1978@hotmail.com");
	
		INSERT INTO BUSINESS(paymentTerms, customerID)
		VALUES
			("30/90 Days", 2);
	
		UPDATE CUSTOMER
		SET businessCustomer="y"
		WHERE customerName = "Joey John Barber Shop";	
		
		INSERT INTO ORDERED (totalCost, customerID, offerCode)
		VALUES
			(299.95, (SELECT  customerID FROM CUSTOMER WHERE customerName = "Joey John Barber Shop"), "345743213");
		
		INSERT INTO LINE_ITEM (orderID, itemNumber, quantity)
		VALUES
			(2, 3, "1");
		
		INSERT INTO PURCHASE_CONTACT(contactName, customerID, contactPhone)
		VALUES
			('Joey James', (SELECT customerID FROM CUSTOMER WHERE customerName="Joey John Barber Shop"), "585-475-1234");
		
COMMIT;

SELECT *
FROM CUSTOMER;

SELECT *
FROM BUSINESS;

SELECT *
FROM ORDERED;

SELECT *
FROM LINE_ITEM;

SELECT *
FROM PURCHASE_CONTACT;
		
COMMIT;




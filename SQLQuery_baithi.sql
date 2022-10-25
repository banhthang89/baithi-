USE MASTER 
GO 
IF EXISTS (SELECT * FROM sys.databases WHERE Name = 'AZBank')
DROP DATABASE AZBank 
GO 
CREATE DATABASE AZBank 
GO 
USE AZBank 
GO 
CREATE TABLE Customer (
    C_ID int PRIMARY KEY,
    C_Name nvarchar(50),
    C_City nvarchar(50),
    C_Country nvarchar(50),
    C_Phone nvarchar(15),
    C_Email nvarchar(50)
)
CREATE TABLE CustomerAccount (
    AccountNumber char(9) PRIMARY KEY,
    C_ID int,
    Balance money,
    MinAccount money
)
CREATE TABLE CustomerTransaction (
    TransactionID int PRIMARY KEY,
    AccountNumber char(9),
    TranscationDate smalldatetime,
    Amount money,
    DepositorWithdraw bit
)

--Insert into each table at least 3 records.
INSERT INTO Customer VALUES (7,'Thang','Ha Tinh','Viet Nam','0987654321','thang12@gmail.com')
INSERT INTO Customer VALUES (8,'Huong','Hue','Viet Nam','0987654123','huong23@gmail.com')
INSERT INTO Customer VALUES (9,'Anh','Ha Noi','Viet Nam','0987654456','anh123@gmail.com')
SELECT * FROM Customer 

INSERT INTO CustomerAccount VALUES ('123','7','120000','120')
INSERT INTO CustomerAccount VALUES ('234','7','123456','121') 
INSERT INTO CustomerAccount VALUES ('456','9','123567','123')
SELECT * FROM CustomerAccount 

INSERT INTO CustomerTransaction VALUES ('7','123','2022-01-01','122','1')
INSERT INTO CustomerTransaction VALUES ('8','234','2021-07-02','222','2')
INSERT INTO CustomerTransaction VALUES ('9','456','2020-08-04','111','3')
SELECT * FROM CustomerTransaction 

--4. Write a query to get all customers from Customer table who live in ‘Hanoi’.
SELECT * FROM Customer WHERE City = 'HN'

--5. Write a query to get account information of the customers (Name, Phone, Email,
--AccountNumber, Balance).
SELECT [Name],Phone,Email,AccountNumber,Balance FROM Customer
join CustomerAccount ON
Customer.CustomerId = CustomerAccount.CustomerId

--6. A-Z bank has a business rule that each transaction (withdrawal or deposit) won’t be
--over $1000000 (One million USDs). Create a CHECK constraint on Amount column
--of CustomerTransaction table to check that each transaction amount is greater than
--0 and less than or equal $1000000.
ALTER TABLE CustomerTransaction
ADD CONSTRAINT CK_Checkwithdrawal CHECK (DepositorWithdraw > 0 and DepositorWithdraw <= 1000000)

--7. Create a view named vCustomerTransactions that display Name,
--AccountNumber, TransactionDate, Amount, and DepositorWithdraw from Customer,
--CustomerAccount and CustomerTransaction tables.

CREATE VIEW vCustomerTransactions
AS
SELECT [Name],CustomerAccount.AccountNumber,TransactionDate,Amount,DepositorWithdraw FROM Customer
join CustomerAccount ON
Customer.CustomerId = CustomerAccount.CustomerId
Join CustomerTransaction ON
CustomerTransaction.AccountNumber = CustomerAccount.AccountNumber

SELECT * FROM vCustomerTransactions
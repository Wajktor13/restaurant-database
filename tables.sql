-- Tables
CREATE TABLE Companies
(
    CompanyID   int    NOT NULL,
    CustomerID  int    NOT NULL,
    CompanyName varchar(64) NOT NULL,
    NIP         char(10)    NOT NULL,
    CONSTRAINT Companies_pk PRIMARY KEY (CompanyID)
);

CREATE TABLE CompanyEmployees
(
    CompanyEmployeeID int NOT NULL,
    PersonID          int NOT NULL,
    CompanyID         int NOT NULL,
    CONSTRAINT CompanyEmployees_pk PRIMARY KEY (CompanyEmployeeID)
);

CREATE TABLE CompanyReservationParticipants
(
    ReservationID     int NOT NULL,
    CompanyEmployeeID int NOT NULL,
);

CREATE TABLE CustomersPersonalData
(
    PersonID  int    NOT NULL,
    FirstName varchar(64) NOT NULL,
    LastName  varchar(64) NOT NULL,
    CONSTRAINT FirstName_CustomersPersonalData_c CHECK (FirstName LIKE '[A-Z]%'),
    CONSTRAINT LastName_CustomersPersonalData_c CHECK (LastName LIKE '[A-Z]%'),
    CONSTRAINT CustomersPersonalData_pk PRIMARY KEY (PersonID)
);

CREATE TABLE Customers
(
    CustomerID int    NOT NULL,
    Street     varchar(64) NOT NULL,
    Country    varchar(64) NOT NULL,
    City       varchar(64) NOT NULL,
    PostCode   varchar(16) NOT NULL,
    Phone      varchar(16) NOT NULL,
    Email      varchar(64) NOT NULL,
    CONSTRAINT Country_Customers_c CHECK (Country LIKE '[A-Z]%'),
    CONSTRAINT City_Customers_c CHECK (City LIKE '[A-Z]%'),
    CONSTRAINT Street_Customers_c CHECK (Street LIKE '[A-Z]%'),
    CONSTRAINT Customers_pk PRIMARY KEY (CustomerID)
);

CREATE TABLE IndividualCustomers
(
    CustomerID int NOT NULL,
    PersonID   int NOT NULL,
    CONSTRAINT IndividualCustomers_pk PRIMARY KEY (CustomerID)
);

CREATE TABLE DiningTables
(
    DiningTableID int NOT NULL,
    NumberOfSeats int      NOT NULL,
    CONSTRAINT NumberOfSeats_DiningTables_c CHECK (NumberOfSeats > 0),
    CONSTRAINT DiningTables_pk PRIMARY KEY (DiningTableID)
);

CREATE TABLE Invoices
(
    InvoiceID int NOT NULL,
    OrderID   int NOT NULL,
    CONSTRAINT Invoices_pk PRIMARY KEY (InvoiceID)
);

CREATE TABLE Menu
(
    MenuID   int    NOT NULL,
    MenuName varchar(64) NOT NULL,
    FromTime datetime    NOT NULL,
    ToTime   datetime    NULL DEFAULT NULL,
    CONSTRAINT Proper_Dates_Menu_c CHECK (FromTime <= ToTime OR ToTime IS NULL),
    CONSTRAINT Menu_pk PRIMARY KEY (MenuID)
);

CREATE TABLE MenuDetails
(
    MenuID    int NOT NULL,
    ProductID int NOT NULL,
);

CREATE TABLE OrderDetails
(
    OrderID   int NOT NULL,
    ProductID int NOT NULL,
    Quantity  int      NOT NULL,
    CONSTRAINT Quantity_OrderDetails_c CHECK (Quantity >= 0),
);

CREATE TABLE Orders
(
    OrderID              int    NOT NULL,
    CustomerID           int    NOT NULL,
    OrderDate            datetime    NOT NULL,
    CollectDate          datetime   NULL,
    PaymentDate          datetime    NULL DEFAULT NULL,
    PayVia               int    NULL,
    OrderStatus          varchar(64) NOT NULL,
    RestaurantEmployeeID int    NOT NULL,
    DiscountPercent      int    NOT NULL DEFAULT 0,
    CONSTRAINT Orders_pk PRIMARY KEY (OrderID)
);

CREATE TABLE PaymentMethod
(
    PaymentID   int    NOT NULL,
    PaymentName varchar(64) NOT NULL,
    CONSTRAINT PaymentMethod_pk PRIMARY KEY (PaymentID)
)

CREATE TABLE ProductIngredients
(
    ProductID    int NOT NULL,
    IngredientID int NOT NULL,
);

CREATE TABLE IngredientsWarehouse
(
    IngredientID   int    NOT NULL,
    IngredientName varchar(64) NOT NULL,
    QuantityLeft   int         NOT NULL,
    CONSTRAINT QuantityLeft_IngredientsWarehouse_c CHECK (QuantityLeft >= 0),
    CONSTRAINT IngredientsWarehouse_pk PRIMARY KEY (IngredientID)
);


CREATE TABLE Products
(
    ProductID   int    NOT NULL,
    ProductName varchar(64) NOT NULL,
    CategoryID  int    NOT NULL,
    CONSTRAINT Products_pk PRIMARY KEY (ProductID)
);

CREATE TABLE ProductPrices
(
    ProductID int NOT NULL,
    FromTime  datetime NOT NULL,
    ToTime    datetime NULL DEFAULT NULL,
    UnitPrice int      NOT NULL,
    CONSTRAINT Proper_Dates_ProductPrices_c CHECK (FromTime <= ToTime OR ToTime IS NULL),
    CONSTRAINT UnitPrice_ProductPrices_c CHECK (UnitPrice >= 0),
);

CREATE TABLE Categories
(
    CategoryID   int    NOT NULL,
    CategoryName varchar(64) NOT NULL,
    CONSTRAINT Categories_pk PRIMARY KEY (CategoryID)
);

CREATE TABLE Reservation
(
    ReservationID int NOT NULL,
    FromTime      datetime NOT NULL,
    ToTime        datetime NOT NULL,
    Seats         int      NOT NULL,
    DiningTableID int NOT NULL,
    OrderID       int NOT NULL,
    CONSTRAINT Seats_Reservation_c CHECK (Seats <= 40 AND Seats > 0),
    CONSTRAINT Proper_Dates_Reservation_c CHECK (FromTime < ToTime),
    CONSTRAINT Reservation_pk PRIMARY KEY (ReservationID)
);

CREATE TABLE RestaurantEmployees
(
    RestaurantEmployeeID int    NOT NULL,
    FirstName            varchar(64) NOT NULL,
    LastName             varchar(64) NOT NULL,
    Occupation           varchar(64) NOT NULL,
    Street               varchar(64) NOT NULL,
    Country              varchar(64) NOT NULL,
    City                 varchar(64) NOT NULL,
    PostCode             varchar(16) NOT NULL,
    Phone                char(9)     NOT NULL,
    Email                varchar(64) NOT NULL,
    CONSTRAINT City_RestaurantEmployees_c CHECK ((City LIKE '[A-Z]%')),
    CONSTRAINT Country_RestaurantEmployees_c CHECK ((Country LIKE '[A-Z]%')),
    CONSTRAINT Street_RestaurantEmployees_c CHECK ((Street LIKE '[A-Z]%')),
    CONSTRAINT Name_Validation_RestaurantEmployees_c CHECK ((FirstName LIKE '[A-Z]%') AND (LastName LIKE '[A-Z]%')),
    CONSTRAINT RestaurantEmployees_pk PRIMARY KEY (RestaurantEmployeeID)
);

CREATE TABLE EmployeesSalary
(
    RestaurantEmployeeID int NOT NULL,
    FromTime             datetime NOT NULL,
    ToTime               datetime NULL DEFAULT NULL,
    Salary               int      NOT NULL,
    CONSTRAINT Salary_EmployeesSalary_c CHECK (Salary >= 0),
    CONSTRAINT Proper_Dates_EmployeesSalary_c CHECK (FromTime <= ToTime OR ToTime IS NULL),
);

CREATE TABLE Takeaway
(
    OrderID    int NOT NULL,
    PickupDate datetime NULL DEFAULT NULL,
    CONSTRAINT Takeaway_pk PRIMARY KEY (OrderID)
);

CREATE TABLE VariablesData
(
    FromTime      datetime   NOT NULL,
    ToTime        datetime   NULL DEFAULT NULL,
    VariableType  varchar(3) NOT NULL,
    VariableValue int        NOT NULL,
    CONSTRAINT Proper_Dates_VariablesData_c CHECK (FromTime <= ToTime OR ToTime IS NULL),
    CONSTRAINT VariableValue_VariablesData_c CHECK (VariablesData.VariableValue >= 0)
);

CREATE TABLE TempDiscount
(
    CustomerID       int        NOT NULL,
    FromTime         datetime   NOT NULL,
    ToTime           datetime   NULL DEFAULT NULL,
    DiscountPercent  int        NOT NULL DEFAULT 0,
    CONSTRAINT Proper_Dates_TempDiscount_c CHECK (FromTime <= ToTime OR ToTime IS NULL),
    CONSTRAINT TempDiscount_DiscountPercent_c CHECK (TempDiscount.DiscountPercent >= 0)
);

-- Foreign Keys
ALTER TABLE Products
    ADD CONSTRAINT Categories_Products
        FOREIGN KEY (CategoryID)
            REFERENCES Categories (CategoryID);

ALTER TABLE Companies
    ADD CONSTRAINT Companies_Customers
        FOREIGN KEY (CustomerID)
            REFERENCES Customers (CustomerID);

ALTER TABLE CompanyEmployees
    ADD CONSTRAINT CompanyEmployees_Companies
        FOREIGN KEY (CompanyID)
            REFERENCES Companies (CompanyID);

ALTER TABLE EmployeesSalary
    ADD CONSTRAINT EmployeesSalary_RestaurantEmployee
        FOREIGN KEY (RestaurantEmployeeID)
            REFERENCES RestaurantEmployees (RestaurantEmployeeID);

ALTER TABLE CompanyReservationParticipants
    ADD CONSTRAINT CompanyEmployees_CompanyReservationParticipants
        FOREIGN KEY (CompanyEmployeeID)
            REFERENCES CompanyEmployees (CompanyEmployeeID);

ALTER TABLE CompanyReservationParticipants
    ADD CONSTRAINT CompanyReservationParticipants_Reservation
        FOREIGN KEY (ReservationID)
            REFERENCES Reservation (ReservationID);

ALTER TABLE CompanyEmployees
    ADD CONSTRAINT CustomerPersonalData_CompanyEmployees
        FOREIGN KEY (PersonID)
            REFERENCES CustomersPersonalData (PersonID);

ALTER TABLE IndividualCustomers
    ADD CONSTRAINT CustomerPersonalData_IndividualCustomers
        FOREIGN KEY (PersonID)
            REFERENCES CustomersPersonalData (PersonID);

ALTER TABLE Orders
    ADD CONSTRAINT Customers_Orders
        FOREIGN KEY (CustomerID)
            REFERENCES Customers (CustomerID);

ALTER TABLE IndividualCustomers
    ADD CONSTRAINT IndividualCustomers_Customers
        FOREIGN KEY (CustomerID)
            REFERENCES Customers (CustomerID);

ALTER TABLE ProductIngredients
    ADD CONSTRAINT IngredientsWarehouse_ProductIngredients
        FOREIGN KEY (IngredientID)
            REFERENCES IngredientsWarehouse (IngredientID);

ALTER TABLE MenuDetails
    ADD CONSTRAINT MenuDetails_Products
        FOREIGN KEY (ProductID)
            REFERENCES Products (ProductID);

ALTER TABLE MenuDetails
    ADD CONSTRAINT Menu_MenuDetails
        FOREIGN KEY (MenuID)
            REFERENCES Menu (MenuID);

ALTER TABLE Invoices
    ADD CONSTRAINT Orders_Invoices
        FOREIGN KEY (OrderID)
            REFERENCES Orders (OrderID);

ALTER TABLE OrderDetails
    ADD CONSTRAINT Orders_OrderDetails
        FOREIGN KEY (OrderID)
            REFERENCES Orders (OrderID);

ALTER TABLE Reservation
    ADD CONSTRAINT Orders_Reservation
        FOREIGN KEY (OrderID)
            REFERENCES Orders (OrderID);

ALTER TABLE Orders
    ADD CONSTRAINT Orders_RestaurantEmployees
        FOREIGN KEY (RestaurantEmployeeID)
            REFERENCES RestaurantEmployees (RestaurantEmployeeID);

ALTER TABLE Takeaway
    ADD CONSTRAINT Orders_Takeaway
        FOREIGN KEY (OrderID)
            REFERENCES Orders (OrderID);

ALTER TABLE OrderDetails
    ADD CONSTRAINT Products_OrderDetails
        FOREIGN KEY (ProductID)
            REFERENCES Products (ProductID);

ALTER TABLE ProductIngredients
    ADD CONSTRAINT Products_ProductIngredients
        FOREIGN KEY (ProductID)
            REFERENCES Products (ProductID);

ALTER TABLE Reservation
    ADD CONSTRAINT Reservation_DiningTables
        FOREIGN KEY (DiningTableID)
            REFERENCES DiningTables (DiningTableID);

ALTER TABLE ProductPrices
    ADD CONSTRAINT ProductPrices_Products
        FOREIGN KEY (ProductID)
            REFERENCES Products (ProductID);

ALTER TABLE Orders
    ADD CONSTRAINT Orders_PaymentMethod
        FOREIGN KEY (PayVia)
            REFERENCES PaymentMethod (PaymentID);
            
 ALTER TABLE TempDiscount
    ADD CONSTRAINT TempDiscount_Customers
        FOREIGN KEY (CustomerID)
            REFERENCES Customers (CustomerID);

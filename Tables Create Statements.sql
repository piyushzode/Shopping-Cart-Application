create table Customers (
   username   varchar(10) primary key,
   password   varchar(32),
   address    varchar(100),
   phone	  varchar(20),
   email      varchar(45)
);

create table ShoppingBasket (
   basketId   varchar(13) primary key,
   username	  varchar(10) references Customers (username)
);


CREATE TABLE AUTHOR ( 
    SSN VARCHAR(50) NOT NULL ,
    NAME VARCHAR(100) NOT NULL ,
    ADDRESS VARCHAR(200) NOT NULL ,
    PHONE VARCHAR(50) NOT NULL ,
    CONSTRAINT pk_author_ssn PRIMARY KEY (SSN)
);


CREATE TABLE BOOK ( 
    ISBN VARCHAR(60) NOT NULL ,
    TITLE VARCHAR(100) NOT NULL ,
    YEAR VARCHAR(20) NOT NULL ,
    PRICE VARCHAR(50) NOT NULL ,
    PUBLISHER VARCHAR(50) NOT NULL ,
    CONSTRAINT pk_book_isbn PRIMARY KEY (ISBN)
);

done
CREATE TABLE WRITTENBY ( 
    SSN VARCHAR(50),
    ISBN VARCHAR(60),
    CONSTRAINT fk_writtenby_ssn FOREIGN KEY (SSN) REFERENCES AUTHOR(SSN),
    CONSTRAINT fk_writtenby_isbn FOREIGN KEY (ISBN) REFERENCES BOOK(ISBN)
);


CREATE TABLE WAREHOUSE ( 
    WAREHOUSECODE VARCHAR(50),
    NAME VARCHAR(60),
    ADDRESS VARCHAR(100),
    PHONE VARCHAR(60),
    CONSTRAINT pk_warehouse_warehousecode PRIMARY KEY (WAREHOUSECODE)
);

 
done
CREATE TABLE STOCKS ( 
    ISBN VARCHAR(60),
    WAREHOUSECODE VARCHAR(50),
    WAREHOUSE_NUMBER VARCHAR(60),
    CONSTRAINT fk_stocks_isbn FOREIGN KEY (ISBN) REFERENCES BOOK(ISBN),
    CONSTRAINT fk_stocks_warehousecode FOREIGN KEY (WAREHOUSECODE) REFERENCES WAREHOUSE(WAREHOUSECODE)
);


CREATE TABLE CUSTOMER ( 
    USERNAME VARCHAR(50),
    ADDRESS VARCHAR(100),
    EMAIL VARCHAR(60),
    PHONE VARCHAR(60),
    PASS VARCHAR(60),
    FULLNAME VARCHAR(60),
    CONSTRAINT pk_customer_username PRIMARY KEY (USERNAME)
)


done
CREATE TABLE SHOPPINGBASKET ( 
    BASKETID VARCHAR(50),
    USERNAME VARCHAR(100),
    CONSTRAINT pk_shoppingbasket_basketid PRIMARY KEY (BASKETID),
    CONSTRAINT fk_shippingbasket_username FOREIGN KEY (USERNAME) REFERENCES CUSTOMER(USERNAME)
);

done
CREATE TABLE CONTAINS ( 
    ISBN VARCHAR(60),
    BASKETID VARCHAR(50),
    CONTAINS_NUMBER VARCHAR(60),
    CONSTRAINT fk_contains_basketid FOREIGN KEY (BASKETID) REFERENCES SHOPPINGBASKET(BASKETID),
    CONSTRAINT fk_contains_isbn FOREIGN KEY (ISBN) REFERENCES BOOK(ISBN)
);

done
CREATE TABLE SHIPPINGORDER ( 
    ISBN VARCHAR(60),
    WAREHOUSECODE VARCHAR(50),
    USERNAME VARCHAR(50),
    SHIPPINGORDER_NUMBER VARCHAR(60),
    CONSTRAINT fk_shippingorder_isbn FOREIGN KEY (ISBN) REFERENCES BOOK(ISBN),
    CONSTRAINT fk_shippingorder_warehousecode FOREIGN KEY (WAREHOUSECODE) REFERENCES WAREHOUSE(WAREHOUSECODE),
    CONSTRAINT fk_shippingorder_username FOREIGN KEY (USERNAME) REFERENCES CUSTOMER(USERNAME)
);
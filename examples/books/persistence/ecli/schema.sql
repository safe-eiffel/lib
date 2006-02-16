create table COPY (
 isbn VARCHAR(14),
 serial_number INTEGER,
 purchased DATE,
 price FLOAT,
 loc_store INTEGER,
 loc_shelf INTEGER,
 loc_row INTEGER,
 borrower INTEGER,
 borrow_time TIMESTAMP
);

create table BORROWER (
 id INTEGER,
 name VARCHAR (30),
 address VARCHAR (50)
);

create table BOOK (
 isbn VARCHAR(14),
 title VARCHAR(100),
 author VARCHAR(30)
);


create table COPY (
 isbn varchar(14),
 serial_number integer,
 loc_store integer,
 loc_shelf integer,
 loc_row integer,
 borrower integer
);

create table BORROWER (
 id integer,
 name varchar (30),
 address varchar (50)
);

create table BOOK (
 isbn varchar(14),
 title varchar(100),
 author varchar(30)
);


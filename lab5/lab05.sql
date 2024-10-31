DROP DATABASE IF EXISTS shop;

CREATE DATABASE shop;

USE shop;

/* Create a tables */
CREATE TABLE customers (
    customer_id             INT AUTO_INCREMENT primary key,
    customer_first_name     VARCHAR(50),
    customer_last_name      VARCHAR(50),
    address_id              INT,
    customer_phone          VARCHAR(20),
    FOREIGN KEY (address_id) references address_data(address_id)
);
CREATE TABLE address_data(
    address_id  INT AUTO_INCREMENT primary key,
    address_line1 VARCHAR(50),
    address_line2 VARCHAR(50),
    state_abbreviation VARCHAR(2)
);

Create table inventory(
    inventory_id INT AUTO_INCREMENT primary key,
    purchase_price decimal(10,2),
    date_aquired date,
    markup int,
    country_id int,
    year_made year,
    style_id int,
    primary_material_id int,
    product_length int,
    product_width int,
    FOREIGN KEY (country_id) references country(country_id),
    FOREIGN KEY (style_id) references style(style_id),
    FOREIGN KEY (primary_material_id) primary_material(primary_material_id)
);

CREATE TABLE country(
    country_id int AUTO_INCREMENT primary key,
    country_name VARCHAR(50)
);
Create table style(
    style_id int AUTO_INCREMENT primary key,
    style_name VARCHAR(50)
);
CREATE table primary_material(
    primary_material_id int AUTO_INCREMENT primary key,
    material_name VARCHAR(50)
);
Create table sales(
    sale_id int AUTO_INCREMENT primary key,
    customer_id int,
    inventory_id int,
    sale_price decimal(10,2),
    net_on_sale decimal(10,2),
    sale_date date,
    FOREIGN KEY (customer_id) references customers(customer_id),
    FOREIGN KEY (inventory_id) references inventory(inventory_id)
);
Create table trial(
    trial_id int AUTO_INCREMENT primary key,
    customer_id int,
    inventory_id int,
    start_date date,
    estimated_return_date date,
    FOREIGN KEY (customer_id) references customers(customer_id),
    FOREIGN KEY (inventory_id) references inventory(inventory_id)
);

/* fills data in the table */
INSERT INTO country(country_name)
VALUES("Turkey"),("Iran"),("India"),("Afghanistan");

INSERT INTO style(style_name)
VALUES ("Ushak"),("Tabriz"),("Agra");

INSERT INTO primary_material(material_name)
VALUES ("Wool"),("Cotton"), ("Silk");


INSERT INTO inventory(purchase_price,date_aquired,markup,country_id,year_made,style_id
primary_material_id,product_length,product_width)
VALUES(1000.00,'2000-11-22',50,1,1999,2,2,5,6),
    (1020.00,'2020-11-22',100,2,1990,3,1,10,20);

/* prints the table*/
SELECT * FROM inventory;
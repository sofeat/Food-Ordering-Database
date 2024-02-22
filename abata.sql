create database abata;

-- user account info
create table user_info (
user_id int PRIMARY KEY,
username varchar (30),
phone_num float,
address varchar (50)
)

-- food table: menu
create table food (
food_id varchar(6) PRIMARY KEY,
name varchar (30),
price DECIMAL(4,2),
description varchar (50)
)
-- adding food into the menu
insert into food (food_id, name, price, description) values ('B1', 'Cheeseburger', 6.80, 'Beef patty accompanied with soft breads and salads');
insert into food (food_id, name, price, description) values ('P1', 'Bolognese Spaghetti', 14.50, 'Beef meatballs with tomato sauce and spaghetti');
insert into food (food_id, name, price, description) values ('F1', 'Fish and chips', 16.90, 'Fish fillet with tartar sauce, chips and coleslaw');

-- cart table: user's cart
create table cart (
cart_id int identity(1,1) PRIMARY KEY,
user_id int,
create_date DATETIME DEFAULT GETDATE(),
ordered BIT NOT NULL DEFAULT 0,
FOREIGN KEY (user_id) REFERENCES user_info(user_id)
)

-- cart item table: food in the user's cart
create table cart_item (
cart_item_id int identity(1,1),
cart_id int,
food_id varchar(6),
quantity int NOT NULL DEFAULT 1,
FOREIGN KEY (cart_id) REFERENCES cart(cart_id),
FOREIGN KEY (food_id) REFERENCES food(food_id)
)

-- order table: food orders
create table orders (
order_id int identity(1,1) PRIMARY KEY,
user_id int,
create_date DATETIME DEFAULT GETDATE(),
delivered BIT NOT NULL DEFAULT 0,
FOREIGN KEY (user_id) REFERENCES user_info(user_id)
)

-- order item table: food ordered by users
create table order_item (
order_item_id int identity(1,1),
order_id int,
food_id varchar(6),
quantity int NOT NULL DEFAULT 1,
FOREIGN KEY (order_id) REFERENCES orders(order_id),
FOREIGN KEY (food_id) REFERENCES food(food_id)
)

-- Insert user info
insert into user_info (user_id,username,phone_num,address) values (001, 'Sofea', 0199850558, 'Desasiswa Restu, USM');
insert into user_info (user_id,username,phone_num,address) values (002, 'Shafwan', 0139953884, 'Desasiswa Aman, USM');
insert into user_info (user_id,username,phone_num,address) values (003, 'Adlin', 0187756558, 'Desasiswa Fajar, USM');
-- View table
Select * from user_info;

-- Insert cart info
insert into cart (user_id) values (001);
insert into cart (user_id) values (002);
insert into cart (user_id) values (003);
-- View table
Select * from cart;

-- User ordering food: Insert cart item
insert into cart_item (cart_id, food_id, quantity) values (2, 'P1', 4);
-- View table
Select * from cart_item;

-- User finished ordering food: Update ordered (in cart) column + Insert into order & order item table

UPDATE cart SET ordered = 1 WHERE user_id  = 2;
Select * from cart;

insert into orders (user_id) values (002);
Select * from orders;

insert into order_item (order_id, food_id, quantity) values (1, 'P1', 4);
Select * from order_item;

-- User received food: Update delivered column (in orders)
UPDATE orders SET delivered = 1 WHERE order_id = 1;
Select * from orders;

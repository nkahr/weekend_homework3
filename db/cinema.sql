DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS films;

CREATE TABLE customers (
  id SERIAL4 primary key, 
  name VARCHAR(255),
  funds INT4
);

CREATE TABLE films (
  id SERIAL4 primary key, 
  title VARCHAR(255),
  price INT4
);

CREATE TABLE tickets (
  id SERIAL4 primary key, 
  film_id INT4 references films(id),
  customer_id INT4 references customers(id)
);
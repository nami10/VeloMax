
-- VeloMax Database

DROP DATABASE IF EXISTS velomax;
CREATE DATABASE IF NOT EXISTS velomax;
USE velomax;

-- Fidelity programs
DROP TABLE IF EXISTS fidelity_programs;
CREATE TABLE IF NOT EXISTS fidelity_programs(
	id INT NOT NULL AUTO_INCREMENT,
	label VARCHAR(255) NOT NULL,
	cost INT NOT NULL,
	duration INT NOT NULL,
	discount INT NOT NULL CHECK(discount < 100), -- percentage
	PRIMARY KEY(id)
);

-- Clients
DROP TABLE IF EXISTS clients;
CREATE TABLE IF NOT EXISTS clients(
	id INT NOT NULL AUTO_INCREMENT,
	street VARCHAR(255) NOT NULL,
	city VARCHAR(255) NOT NULL,
	postal_code VARCHAR(255) NOT NULL,
	province VARCHAR(255) NOT NULL,
	phone VARCHAR(255) NOT NULL,
	mail VARCHAR(255) NOT NULL,
	PRIMARY KEY(id)
);

DROP TABLE IF EXISTS individuals;
CREATE TABLE IF NOT EXISTS individuals(
	id INT NOT NULL REFERENCES clients,
	first_name VARCHAR(255) NOT NULL,
	last_name VARCHAR(255) NOT NULL,
	id_fidelity INT NOT NULL DEFAULT 0,
    	expiration_date DATE NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(id_fidelity)
		REFERENCES fidelity_programs(id)
                ON DELETE CASCADE
);

DROP TABLE IF EXISTS professionals;
CREATE TABLE IF NOT EXISTS professionals(
	id INT NOT NULL REFERENCES clients,
	company_name VARCHAR(255) NOT NULL,
	contact_name VARCHAR(255) NOT NULL,
	order_count INT NOT NULL DEFAULT 0,
	FOREIGN KEY(id)
		REFERENCES clients(id)
                ON DELETE CASCADE
);


-- Orders
DROP TABLE IF EXISTS orders;
CREATE TABLE IF NOT EXISTS orders(
	id INT NOT NULL AUTO_INCREMENT,
	order_date DATE NOT NULL,
	shipping_address VARCHAR(255) NOT NULL,
	shipping_date DATE NOT NULL,
	quantity INT NOT NULL,
    	id_client INT NOT NULL,
	PRIMARY KEY(id),
    	FOREIGN KEY(id_client)
		references clients(id)
                ON DELETE CASCADE
);

-- Bikes
DROP TABLE IF EXISTS bikes;
CREATE TABLE IF NOT EXISTS bikes(
	id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(255) NOT NULL,
	target VARCHAR(255) NOT NULL,
	unit_price FLOAT NOT NULL,
	type VARCHAR(255) NOT NULL,
	introduction_date DATE NOT NULL,
	discontinuation_date DATE NOT NULL,
	PRIMARY KEY(id)
);

-- Parts
DROP TABLE IF EXISTS parts;
CREATE TABLE IF NOT EXISTS parts(
	id INT NOT NULL AUTO_INCREMENT,
	description VARCHAR(255) NOT NULL,
	unit_price FLOAT NULL,
	introduction_date DATE NOT NULL,
	discontinuation_date DATE NOT NULL,
	procurement_delay INT DEFAULT 0,
	quantity INT NOT NULL DEFAULT 1,
	type VARCHAR(255) NOT NULL,
	PRIMARY KEY(id)
);

-- Suppliers
DROP TABLE IF EXISTS suppliers;
CREATE TABLE IF NOT EXISTS suppliers(
	id INT NOT NULL AUTO_INCREMENT,
	siret VARCHAR(255) NOT NULL,
	name VARCHAR(255) NOT NULL,
	contact VARCHAR(255) NOT NULL,
	location VARCHAR(255) NOT NULL,
	label ENUM('1','2','3','4'), -- 1 very good, 2 good, 3 average, 4 bad
	PRIMARY KEY(id)
);

-- Ordered bikes
DROP TABLE IF EXISTS ordered_bikes;
CREATE TABLE IF NOT EXISTS ordered_bikes(
	id INT NOT NULL AUTO_INCREMENT,
	orders_id INT NOT NULL,
	bikes_id INT NOT NULL,
	quantity INT NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(orders_id) REFERENCES orders(id) 
            ON DELETE CASCADE,
	FOREIGN KEY(bikes_id) REFERENCES bikes(id)
            ON DELETE CASCADE
);

-- Ordered parts
DROP TABLE IF EXISTS ordered_parts;
CREATE TABLE IF NOT EXISTS ordered_parts(
	id INT NOT NULL AUTO_INCREMENT,
	orders_id INT NOT NULL,
	parts_id INT NOT NULL,
	quantity INT NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(orders_id) REFERENCES orders(id),
	FOREIGN KEY(parts_id) REFERENCES parts(id)
);

-- Bike parts
DROP TABLE IF EXISTS bike_parts;
CREATE TABLE IF NOT EXISTS bike_parts(
	id INT NOT NULL AUTO_INCREMENT,
	parts_id INT NOT NULL,
	bikes_id INT NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(parts_id) REFERENCES parts(id)
            ON DELETE CASCADE,
	FOREIGN KEY(bikes_id) REFERENCES bikes(id)
            ON DELETE CASCADE
);

-- Procurement
DROP TABLE IF EXISTS procurement;
CREATE TABLE IF NOT EXISTS procurement(
	id INT NOT NULL AUTO_INCREMENT,
	parts_id INT NOT NULL,
	suppliers_id INT NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(parts_id) REFERENCES parts(id)
            ON DELETE CASCADE,
	FOREIGN KEY(suppliers_id) REFERENCES suppliers(id)
            ON DELETE CASCADE
);

-- EOF

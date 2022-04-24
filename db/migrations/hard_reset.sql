-- psql -a -f db/migrations/hard_reset.sql

DROP DATABASE IF EXISTS bdc;
CREATE DATABASE bdc;
\c bdc;

CREATE TABLE users(
    id SERIAL,

    account INT NOT NULL UNIQUE,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    rut VARCHAR(12) NOT NULL UNIQUE,
    address VARCHAR(100) NOT NULL,
    password VARCHAR(20) NOT NULL,
    balance FLOAT NOT NULL CHECK (balance >= 0),

    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    active BOOLEAN DEFAULT TRUE,

    PRIMARY KEY (id)
);

CREATE TABLE wire_transfers(
    id SERIAL,

    date TIMESTAMP NOT NULL,
    id_from INT NOT NULL,
    id_to INT NOT NULL,
    comment VARCHAR(50) NOT NULL,
    amount FLOAT NOT NULL,

    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    active BOOLEAN DEFAULT TRUE,
    
    PRIMARY KEY (id),
    FOREIGN KEY (id_from) REFERENCES users(id),
	FOREIGN KEY (id_to) REFERENCES users(id)
);

INSERT INTO users(account, first_name, last_name, email, rut, address, password, balance) 
    VALUES(1234561, 'Cristóbal', 'Domínguez', 'cristobald@example.com', '1932323-4', 'Avda del Mar 1234', 'ClaveSecreta123', 100000),
          (1234562, 'Pedro', 'Pérez', 'pperez@example.com', '1932324-2', 'Tobalaba 9382', 'Password', 100000),
          (1234563, 'Juan', 'Pérez', 'jperez@example.com', '1932325-0', 'Tobalaba 9382', 'Passw0rd', 100000),
          (1234564, 'Diego', 'Pérez', 'dperez@example.com', '1932326-9', 'Tobalaba 9382', 'P4ssword', 100000);
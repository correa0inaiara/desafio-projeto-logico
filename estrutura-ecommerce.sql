-- criação do banco de dados para o cenário de E-commerce

CREATE DATABASE ecommerce;
USE ecommerce;

-- criar tabela cliente
CREATE TABLE clients(
	idClient INT AUTO_INCREMENT PRIMARY KEY,
    Fname VARCHAR(10),
    Minit CHAR(3),
    Lname VARCHAR(20),
    CPF CHAR(11) NOT NULL,
    Address VARCHAR(30),
    CONSTRAINT unique_cpf_client UNIQUE(CPF)
);

ALTER TABLE clients AUTO_INCREMENT=1;

-- criar tabela produto
-- size = dimension of the product
CREATE TABLE product(
	idProduct INT AUTO_INCREMENT PRIMARY KEY,
    Pname VARCHAR(10),
    Classification_kids BOOL DEFAULT FALSE,
    Category ENUM('ELECTRONICS', 'VESTUARY', 'TOYS', 'FOOD', 'FURNITURE') NOT NULL,
    Evaluation FLOAT DEFAULT 0,
    Size VARCHAR(10)
);


CREATE TABLE payment(
	idClient INT PRIMARY KEY,
    idPayment INT,
    TypePayment ENUM('Ticket', 'Card', 'Two Cards'),
    LimitAvailable FLOAT,
    PRIMARY KEY(idClient, idPayment)
);

CREATE TABLE productStorage(
	idProductStorage INT AUTO_INCREMENT PRIMARY KEY,
    StorageLocation VARCHAR(255),
    Quantity INT DEFAULT 0
);

-- criar tabela pedido
CREATE TABLE orders(
	idOrder INT AUTO_INCREMENT PRIMARY KEY,
    idOrderClient INT,
    OrderStatus ENUM('Cancelled', 'Confirmed', 'In processing') NOT NULL DEFAULT 'In processing',
    OrderDescription VARCHAR(255),
    SendShipping FLOAT DEFAULT 10,
    PaymentCash BOOL DEFAULT FALSE,
    CONSTRAINT fk_orders_client FOREIGN KEY (idOrderClient) REFERENCES clients(idClient)
		ON UPDATE CASCADE
);

-- criar tabela fornecedor
CREATE TABLE supplier(
	idSupplier INT AUTO_INCREMENT PRIMARY KEY,
    SocialName VARCHAR(255) NOT NULL,
    CNPJ CHAR(14) NOT NULL,
    CONTACT CHAR(11) NOT NULL,
    CONSTRAINT unique_supplier UNIQUE(CNPJ)
);

CREATE TABLE productOrder(
	idPOproduct INT,
    idPOorder INT,
    poQuantity INT DEFAULT 1,
    poStatus ENUM('Disponível', 'Sem estoque') DEFAULT 'Disponível',
    PRIMARY KEY (idPOproduct, idPOorder),
    CONSTRAINT fk_productOrder_seller FOREIGN KEY (idPOproduct) REFERENCES product(idProduct),
    CONSTRAINT fk_productOrder_product FOREIGN KEY (idPOorder) REFERENCES orders(idOrders)
);

CREATE TABLE storageLocation(
	idLproduct INT,
    idLstorage INT,
    location VARCHAR(255) NOT NULL,
    PRIMARY KEY (idLproduct, idLstorage),
    CONSTRAINT fk_storageLocation_seller FOREIGN KEY (idLproduct) REFERENCES product(idProduct),
    CONSTRAINT fk_storageLocation_product FOREIGN KEY (idLstorage) REFERENCES productStorage(productSeller)
);

-- criar tabela vendedor
CREATE TABLE seller(
	idSeller INT AUTO_INCREMENT PRIMARY KEY,
    SocialName VARCHAR(255) NOT NULL,
    AbstractName VARCHAR(255) NOT NULL,
    CNPJ CHAR(14),
    CPF CHAR(11),
    CONTACT CHAR(11) NOT NULL,
    Location VARCHAR(255),
    CONSTRAINT unique_seller_cnpj UNIQUE(CNPJ),
    CONSTRAINT unique_seller_cpf UNIQUE(CPF)
);

CREATE TABLE productSeller(
	idSeller INT,
    idProduct INT,
    Quantity INT DEFAULT 1,
    PRIMARY KEY (idSeller, idProduct),
    CONSTRAINT fk_product_seller FOREIGN KEY (idSeller) REFERENCES seller(idSeller),
    CONSTRAINT fk_product_product FOREIGN KEY (idProduct) REFERENCES product(idProduct)
);
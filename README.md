# GARDEN DATA BASE 

#### Diagrama Entidad Relación

![DIAGRAMA](https://raw.githubusercontent.com/David-Albarracin/GARDEN_DB/main/garden.png)



#### Comandos DDL y DML

```sql
-- CREAR BASE DE DATOS
CREATE DATABASE garden;
```

```sql
-- CREAR TABLAS
USE `garden` ;

-- -----------------------------------------------------
-- Table `garden`.`gama_product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `garden`.`gama_product` (
  `gama_product_id` VARCHAR(50) NOT NULL,
  `description` TEXT NULL,
  `description_html` TEXT NULL,
  `image` VARCHAR(256) NULL,
  PRIMARY KEY (`gama_product_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `garden`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `garden`.`product` (
  `product_code` VARCHAR(15) NOT NULL,
  `product_name` VARCHAR(70) NULL,
  `description` TEXT NULL,
  `stock_amount` SMALLINT(6) NULL,
  `price_sell` DECIMAL(15) NULL,
  `gama` VARCHAR(50) NOT NULL,
  `height` SMALLINT(6) NULL,
  `width` SMALLINT(6) NULL,
  `length` SMALLINT(6) NULL,
  `weight` SMALLINT(6) NULL,
  PRIMARY KEY (`product_code`),
  INDEX `fk_product_gama_product_idx` (`gama` ASC) VISIBLE,
  UNIQUE INDEX `product_code_UNIQUE` (`product_code` ASC) VISIBLE,
  CONSTRAINT `fk_product_gama_product`
    FOREIGN KEY (`gama`)
    REFERENCES `garden`.`gama_product` (`gama_product_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `garden`.`provider`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `garden`.`provider` (
  `provider_id` INT NOT NULL,
  `provider_name` VARCHAR(50) NULL,
  `provider_surname` VARCHAR(50) NULL,
  PRIMARY KEY (`provider_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `garden`.`provider_product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `garden`.`provider_product` (
  `provider_id` INT NOT NULL,
  `new_price` DECIMAL(15) NULL,
  `old_price` DECIMAL(15) NULL,
  `product_code` VARCHAR(15) NOT NULL,
  INDEX `fk_provider_product_provider1_idx` (`provider_id` ASC) VISIBLE,
  INDEX `fk_provider_product_product1_idx` (`product_code` ASC) VISIBLE,
  CONSTRAINT `pk_provider_product` PRIMARY KEY (`provider_id`, `product_code`),
  CONSTRAINT `fk_provider_product_provider1`
    FOREIGN KEY (`provider_id`)
    REFERENCES `garden`.`provider` (`provider_id`),
  CONSTRAINT `fk_provider_product_product1`
    FOREIGN KEY (`product_code`)
    REFERENCES `garden`.`product` (`product_code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `garden`.`rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `garden`.`rol` (
  `rol_id` INT(11) NOT NULL AUTO_INCREMENT,
  `rol_name` VARCHAR(50) NOT NULL,
  `showProducts` TINYINT NULL DEFAULT 1,
  `actived` TINYINT NULL DEFAULT 1,
  `created_at` DATETIME NULL DEFAULT NOW(),
  `updated_at` DATETIME NULL DEFAULT NOW(),
  PRIMARY KEY (`rol_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `garden`.`country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `garden`.`country` (
  `country_id` INT(10) NOT NULL AUTO_INCREMENT,
  `country_name` VARCHAR(45) NULL,
  PRIMARY KEY (`country_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `garden`.`region`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `garden`.`region` (
  `region_id` INT(10) NOT NULL AUTO_INCREMENT,
  `region_name` VARCHAR(45) NULL,
  `country_id` INT(10) NOT NULL,
  PRIMARY KEY (`region_id`),
  INDEX `fk_region_country1_idx` (`country_id` ASC) VISIBLE,
  CONSTRAINT `fk_region_country1`
    FOREIGN KEY (`country_id`)
    REFERENCES `garden`.`country` (`country_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `garden`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `garden`.`city` (
  `city_id` INT(10) NOT NULL AUTO_INCREMENT,
  `city_name` VARCHAR(45) NULL,
  `postal_code` VARCHAR(45) NULL,
  `region_id` INT(10) NOT NULL,
  PRIMARY KEY (`city_id`),
  INDEX `fk_city_region1_idx` (`region_id` ASC) VISIBLE,
  CONSTRAINT `fk_city_region1`
    FOREIGN KEY (`region_id`)
    REFERENCES `garden`.`region` (`region_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `garden`.`office`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `garden`.`office` (
  `office_id` VARCHAR(10) NOT NULL,
  `office_phone_number` VARCHAR(45) NULL,
  `address_line_1` VARCHAR(50) NULL,
  `address_line_2` VARCHAR(50) NULL,
  `city_id` INT(10) NOT NULL,
  `main_office_id` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`office_id`),
  INDEX `fk_office_city1_idx` (`city_id` ASC) VISIBLE,
  INDEX `fk_office_office1_idx` (`main_office_id` ASC) VISIBLE,
  CONSTRAINT `fk_office_city1`
    FOREIGN KEY (`city_id`)
    REFERENCES `garden`.`city` (`city_id`),
  CONSTRAINT `fk_office_office1`
    FOREIGN KEY (`main_office_id`)
    REFERENCES `garden`.`office` (`office_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `garden`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `garden`.`employee` (
  `employee_id` INT(11) NOT NULL,
  `employee_first_name` VARCHAR(50) NULL,
  `employee_last_name` VARCHAR(50) NULL DEFAULT NULL,
  `employee_first_surname` VARCHAR(50) NULL,
  `employee_last_surname` VARCHAR(50) NULL,
  `employee_extension` VARCHAR(45) NULL,
  `employee_email` VARCHAR(100) NULL,
  `boss_id` INT(11) NULL,
  `rol_id` INT(11) NOT NULL,
  `actived` TINYINT NULL DEFAULT 1,
  `created_at` DATETIME NULL DEFAULT NOW(),
  `updated_at` DATETIME NULL DEFAULT NOW(),
  `office_id` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`employee_id`),
  INDEX `fk_employee_employee1_idx` (`boss_id` ASC) VISIBLE,
  INDEX `fk_employee_rol1_idx` (`rol_id` ASC) VISIBLE,
  INDEX `fk_employee_office1_idx` (`office_id` ASC) VISIBLE,
  CONSTRAINT `fk_employee_employee1`
    FOREIGN KEY (`boss_id`)
    REFERENCES `garden`.`employee` (`employee_id`),
  CONSTRAINT `fk_employee_rol1`
    FOREIGN KEY (`rol_id`)
    REFERENCES `garden`.`rol` (`rol_id`),
  CONSTRAINT `fk_employee_office1`
    FOREIGN KEY (`office_id`)
    REFERENCES `garden`.`office` (`office_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `garden`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `garden`.`customer` (
  `customer_id` INT NOT NULL,
  `customer_name` VARCHAR(50) NULL,
  `customer_surname` VARCHAR(50) NULL,
  `credit_limit` DECIMAL(15) NULL,
  `employee_id` INT(11) NULL DEFAULT NULL,
  `customer_email` VARCHAR(45) NULL,
  PRIMARY KEY (`customer_id`),
  INDEX `fk_customer_employee1_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_customer_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `garden`.`employee` (`employee_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `garden`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `garden`.`address` (
  `address_id` INT NOT NULL AUTO_INCREMENT,
  `address_line_1` VARCHAR(250) NULL,
  `address_line_2` VARCHAR(250) NULL,
  `address_type` VARCHAR(45) NULL,
  `city_id` INT(10) NOT NULL,
  `provider_id` INT NULL DEFAULT NULL,
  `customer_id` INT NULL DEFAULT NULL,
  `employee_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`address_id`),
  INDEX `fk_address_city1_idx` (`city_id` ASC) VISIBLE,
  INDEX `fk_address_provider1_idx` (`provider_id` ASC) VISIBLE,
  INDEX `fk_address_customer1_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_address_employee1_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_address_city1`
    FOREIGN KEY (`city_id`)
    REFERENCES `garden`.`city` (`city_id`),
  CONSTRAINT `fk_address_provider1`
    FOREIGN KEY (`provider_id`)
    REFERENCES `garden`.`provider` (`provider_id`),
  CONSTRAINT `fk_address_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `garden`.`customer` (`customer_id`),
  CONSTRAINT `fk_address_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `garden`.`employee` (`employee_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `garden`.`customer_contact`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `garden`.`customer_contact` (
  `customer_contact_id` INT NOT NULL AUTO_INCREMENT,
  `cc_first_name` VARCHAR(45) NULL,
  `cc_last_name` VARCHAR(45) NULL DEFAULT NULL,
  `cc_first_surname` VARCHAR(45) NULL,
  `cc_last_surname` VARCHAR(45) NULL DEFAULT NULL,
  `customer_contact_type` VARCHAR(45) NULL,
  `customer_id` INT NOT NULL,
  PRIMARY KEY (`customer_contact_id`),
  INDEX `fk_customer_contact_customer1_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_customer_contact_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `garden`.`customer` (`customer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `garden`.`phone_number`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `garden`.`phone_number` (
  `phone_number_id` INT NOT NULL AUTO_INCREMENT,
  `phone_number` VARCHAR(45) NULL,
  `fax` VARCHAR(15) NULL,
  `phone_number_prefix` VARCHAR(45) NULL DEFAULT NULL,
  `phone_number_type` VARCHAR(45) NULL DEFAULT NULL,
  `created_at` DATETIME NULL DEFAULT NOW(),
  `updated_at` DATETIME NULL DEFAULT NOW(),
  `who_is` VARCHAR(45) NULL,
  `office_id` VARCHAR(10) NULL DEFAULT NULL,
  `employee_id` INT(11) NULL DEFAULT NULL,
  `provider_id` INT NULL DEFAULT NULL,
  `customer_contact_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`phone_number_id`),
  INDEX `fk_phone_number_office1_idx` (`office_id` ASC) VISIBLE,
  INDEX `fk_phone_number_employee1_idx` (`employee_id` ASC) VISIBLE,
  INDEX `fk_phone_number_provider1_idx` (`provider_id` ASC) VISIBLE,
  INDEX `fk_phone_number_customer_contact1_idx` (`customer_contact_id` ASC) VISIBLE,
  CONSTRAINT `fk_phone_number_office1`
    FOREIGN KEY (`office_id`)
    REFERENCES `garden`.`office` (`office_id`),
  CONSTRAINT `fk_phone_number_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `garden`.`employee` (`employee_id`),
  CONSTRAINT `fk_phone_number_provider1`
    FOREIGN KEY (`provider_id`)
    REFERENCES `garden`.`provider` (`provider_id`),
  CONSTRAINT `fk_phone_number_customer_contact1`
    FOREIGN KEY (`customer_contact_id`)
    REFERENCES `garden`.`customer_contact` (`customer_contact_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `garden`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `garden`.`order` (
  `order_code` INT NOT NULL,
  `date_order` DATE NULL,
  `date_waiting` DATE NULL,
  `date_deliver` DATE NULL,
  `comments` TEXT NULL,
  `status` VARCHAR(15) NULL,
  `customer_id` INT NOT NULL,
  PRIMARY KEY (`order_code`),
  INDEX `fk_order_customer1_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `garden`.`customer` (`customer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `garden`.`order_detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `garden`.`order_detail` (
  `amount` INT(11) NULL,
  `price_unit` DECIMAL(15) NULL,
  `line_numer` SMALLINT(6) NULL,
  `order_code` INT NOT NULL,
  `product_code` VARCHAR(15) NOT NULL,
  INDEX `fk_order_detail_order1_idx` (`order_code` ASC) VISIBLE,
  INDEX `fk_order_detail_product1_idx` (`product_code` ASC) VISIBLE,
  CONSTRAINT `pk_order_detail` PRIMARY KEY (`product_code`, `order_code`),
  CONSTRAINT `fk_order_detail_order1`
    FOREIGN KEY (`order_code`)
    REFERENCES `garden`.`order` (`order_code`),
  CONSTRAINT `fk_order_detail_product1`
    FOREIGN KEY (`product_code`)
    REFERENCES `garden`.`product` (`product_code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `garden`.`pay`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `garden`.`pay` (
  `id_transaction` VARCHAR(50) NOT NULL,
  `date_pay` DATE NULL,
  `total` DECIMAL(15) NULL,
  `method_pay` VARCHAR(45) NULL,
  `customer_id` INT NOT NULL,
  PRIMARY KEY (`id_transaction`),
  INDEX `fk_pay_customer1_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_pay_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `garden`.`customer` (`customer_id`))
ENGINE = InnoDB;




```

## INSERTAR DATOS DE PRUEBA



Datos Extraídos de [DATOS GARDEN DATA BASE](https://gist.github.com/josejuansanchez/c408725e848afd64dd9a20ab37fba8c9);

Datos Formateados [CALL PROCEDURES](https://github.com/David-Albarracin/GARDEN_DB/blob/main/calls_procedures.sql)

#### FUNCIONES Y PROCEDIMIENTOS

````sql
-- FUNCION PARA CREAR CIUDADES APARTIR DE LOS DATOS QUE TENGAN ESTOS
USE garden;

DROP FUNCTION IF EXISTS def_get_city_id;

DELIMITER $$

CREATE FUNCTION def_get_city_id(
	city_name VARCHAR(50),
	country_name VARCHAR(50),
	region_name VARCHAR(50),
	postal_code VARCHAR(50)
)
RETURNS INT
	DETERMINISTIC
BEGIN
	DECLARE get_city_id INT;
	DECLARE get_region_id INT;
	DECLARE get_country_id INT;
	
	SELECT city_id INTO get_city_id FROM city AS c WHERE c.city_name = city_name;

	IF get_city_id IS NULL THEN

        SELECT country_id INTO get_country_id FROM country AS co WHERE co.country_name = country_name;
       
        IF get_country_id IS NULL THEN
            INSERT INTO country (country_name) VALUES (country_name);
            SET get_country_id = LAST_INSERT_ID();
        END IF;

        -- Insertar la región si no existe
        SELECT region_id INTO get_region_id FROM region WHERE region.region_name = region_name;
       
        IF get_region_id IS NULL THEN
            INSERT INTO region (region_name, country_id) VALUES (region_name, get_country_id);
            SET get_region_id = LAST_INSERT_ID();
        END IF;

        -- Insertar la ciudad
        INSERT INTO city (city_name, postal_code, region_id) VALUES (city_name, postal_code, get_region_id);
        SET get_city_id = LAST_INSERT_ID();
    END IF;
   	RETURN get_city_id;
   
END $$

DELIMITER ;

-- PROCEDIMIENTO PARA AGREGAR OFICINAS

USE garden;

DROP PROCEDURE IF EXISTS add_oficina;

DELIMITER $$

CREATE PROCEDURE add_oficina(
	IN codigo_oficina VARCHAR(10),
    IN ciudad VARCHAR(30),
    IN pais VARCHAR(50),
    IN region_nombre VARCHAR(50),
    IN codigo_postal VARCHAR(10),
    IN telefono VARCHAR(20),
    IN linea_direccion1 VARCHAR(50),
    IN linea_direccion2 VARCHAR(50)
)
BEGIN
	DECLARE get_city_id INT;
	
	SET get_city_id = (SELECT def_get_city_id(ciudad, pais, region_nombre, codigo_postal));
	
    INSERT INTO office(
   		office_id,
   		office_phone_number,
   		address_line_1,
   		address_line_2,
   		city_id
   	) VALUES (
   		codigo_oficina,
   		telefono,
   		linea_direccion1,
   		linea_direccion2,
   		get_city_id
   	);

END $$

DELIMITER ;

-- PROCEDIMIENTO PARA AGREGAR EMPLEADOS

USE garden;

DROP PROCEDURE IF EXISTS add_empleado;

DELIMITER $$

CREATE PROCEDURE add_empleado(
	IN codigo_empleado INT,
  	IN nombre VARCHAR(50),
  	IN apellido1 VARCHAR(50),
  	IN apellido2 VARCHAR(50),
  	IN extension VARCHAR(10) ,
  	IN email VARCHAR(100),
  	IN codigo_oficina VARCHAR(10),
  	IN codigo_jefe INT,
  	IN puesto VARCHAR(50)
)
BEGIN
	DECLARE get_rol_id INT;
	
	SELECT rol_id INTO get_rol_id FROM rol AS r WHERE r.rol_name = puesto;
	
	IF get_rol_id IS NULL THEN
		INSERT INTO rol(
			rol_name
		) VALUES (
			puesto
		);
		SET get_rol_id = LAST_INSERT_ID(); 
	END IF;
	
    INSERT INTO employee (
   		employee_id,
	  	employee_first_name,
	  	employee_last_name,
	  	employee_first_surname,
	  	employee_last_surname,
	  	employee_extension,
	  	employee_email,
	  	boss_id,
	  	rol_id,
	  	office_id
   	) VALUES (
   		codigo_empleado,
   		nombre,
   		null,
   		apellido1,
   		apellido2,
   		extension,
   		email,
   		codigo_jefe,
   		get_rol_id,
   		codigo_oficina
   		
   	);

END $$

DELIMITER ;

-- PROCEDIMIENTO PARA AGREGAR LA GAMA DE LOS PRODUCTOS

USE garden;

DROP PROCEDURE IF EXISTS add_gama_producto;

DELIMITER $$

CREATE PROCEDURE add_gama_producto(
	IN gama VARCHAR(50),
  	IN descripcion_texto TEXT,
  	IN descripcion_html TEXT,
  	IN imagen VARCHAR(256)
)
BEGIN
	
    INSERT INTO gama_product(
   		gama_product_id,
   		description,
   		description_html,
   		image
   	) VALUES (
   		gama,
   		descripcion_texto,
   		descripcion_html,
   		imagen
   	);

END $$

DELIMITER ;

-- PROCEDIMIENTO PARA AGREGAR CLIENTES 

USE garden;

DROP PROCEDURE IF EXISTS add_cliente;

DELIMITER $$

CREATE PROCEDURE add_cliente(
	IN codigo_cliente INT,
  	IN nombre_cliente VARCHAR(50),
  	IN nombre_contacto VARCHAR(30),
  	IN apellido_contacto VARCHAR(30),
  	IN telefono VARCHAR(15),
  	IN faxu VARCHAR(15),
  	IN linea_direccion1 VARCHAR(50),
  	IN linea_direccion2 VARCHAR(50),
  	IN ciudad VARCHAR(50),
  	IN region VARCHAR(50),
  	IN pais VARCHAR(50),
  	IN codigo_postal VARCHAR(10),
  	IN codigo_empleado_rep_ventas INT ,
  	IN limite_credito DECIMAL(15,2)
)
BEGIN
	
	DECLARE get_city_id INT;
	declare get_customer_contant_id INT;

	SET get_city_id = (SELECT def_get_city_id(ciudad, pais, region, codigo_postal));
	
  	INSERT INTO customer(
   		customer_id,
   		customer_name,
   		credit_limit,
   		employee_id
   	) VALUES (
   		codigo_cliente,
   		nombre_cliente,
   		limite_credito,
   		codigo_empleado_rep_ventas
   	);

	INSERT INTO address (
		address_line_1,
		address_line_2,
		city_id,
		customer_id
	) VALUES (
		linea_direccion1,
		linea_direccion2,
		get_city_id,
		codigo_cliente
	);
	
	INSERT INTO customer_contact  (
		cc_first_name,
		cc_first_surname,
		customer_id
	) VALUES (
		nombre_contacto ,
		apellido_contacto,
		codigo_cliente
	);

	SET get_customer_contant_id = LAST_INSERT_ID();

	INSERT INTO phone_number  (
		phone_number,
		fax,
		customer_contact_id
	) VALUES (
		telefono,
		faxu,
		get_customer_contant_id
	);
	
  

END $$

DELIMITER ;

-- PROCEDIMIENTO PARA AGREGAR PEDIDOS

USE garden;

DROP PROCEDURE IF EXISTS add_pedido;

DELIMITER $$

CREATE PROCEDURE add_pedido(
	IN codigo_pedido INT,
  	IN fecha_pedido DATE,
  	IN fecha_esperada DATE,
  	IN fecha_entrega  DATE,
  	IN estado VARCHAR(15),
  	IN comentarios TEXT,
  	IN codigo_cliente INT
)
BEGIN
	
    INSERT INTO `order` (
   		order_code,
   		date_order,
   		date_waiting,
   		date_deliver,
   		comments,
   		status,
   		customer_id
   	) VALUES (
   		codigo_pedido,
   		fecha_pedido,
   		fecha_esperada,
   		fecha_entrega,
   		comentarios,
   		estado,
   		codigo_cliente
   	);

END $$

DELIMITER ;

-- PROCEDIMIENTO PARA AGREGAR PRODUCTOS

USE garden;

DROP PROCEDURE IF EXISTS add_producto;

DELIMITER $$

CREATE PROCEDURE add_producto(
    IN codigo_producto VARCHAR(15),
    IN nombre VARCHAR(70),
    IN gama VARCHAR(50),
    IN dimensiones VARCHAR(25),
    IN proveedor VARCHAR(50),
    IN descripcion TEXT,
    IN cantidad_en_stock SMALLINT,
    IN precio_venta DECIMAL(15,2),
    IN precio_proveedor DECIMAL(15,2)
)
BEGIN
	DECLARE get_provider_id INT;
	
	SELECT provider_id INTO get_provider_id FROM provider AS p WHERE p.provider_id = 1;
	
	IF get_provider_id IS NULL THEN
		INSERT INTO provider(
			provider_id,
			provider_name,
			provider_surname
		) VALUES (
			1, 
			'GARDEN LA PERLA',
			NULL
		);
		SET get_provider_id = 1;
	END IF;
	
	
    INSERT INTO `product` (
   		product_code,
   		product_name,
   		description,
   		stock_amount,
   		price_sell,
   		gama
   	) VALUES (
   		codigo_producto,
   		nombre,
   		descripcion,
   		cantidad_en_stock,
   		precio_venta,
   		gama
   	);
   
   	INSERT INTO provider_product(
			provider_id,
			new_price,
			old_price,
			product_code
		) VALUES (
			get_provider_id, 
			precio_proveedor,
			NULL,
			codigo_producto
	);

END $$

DELIMITER ;

-- PROCEDIMIENTO PARA AGREGAR DETALLES DEL PEDIDO

USE garden;

DROP PROCEDURE IF EXISTS add_detalle_pedido;

DELIMITER $$

CREATE PROCEDURE add_detalle_pedido(
    IN codigo_pedido INT,
    IN codigo_producto VARCHAR(15),
    IN cantidad INT,
    IN precio_unidad DECIMAL(15),
    IN numero_linea SMALLINT 
)
BEGIN
   
   	INSERT INTO order_detail (
			amount,
			price_unit,
			line_numer,
			order_code,
			product_code
		) VALUES (
			cantidad, 
			precio_unidad,
			numero_linea,
			codigo_pedido,
			codigo_producto
	);

END $$

DELIMITER ;

-- PROCEDIMIENTO PARA AGREGAR MEDIOS DE PAGO

USE garden;

DROP PROCEDURE IF EXISTS add_pago;

DELIMITER $$

CREATE PROCEDURE add_pago(
    IN codigo_cliente  INT,
    IN forma_pago VARCHAR(40),
    IN id_transaccion VARCHAR(50),
    IN fecha_pago DATE,
    IN total DECIMAL(15) 
)
BEGIN
   
   	INSERT INTO pay  (
			id_transaction,
			date_pay,
			total,
			method_pay,
			customer_id
		) VALUES (
			id_transaccion, 
			fecha_pago,
			total,
			forma_pago,
			codigo_cliente
	);

END $$

DELIMITER ;


````

###### DESPUES DE CREAR LOS PROCEDIMIENTOS EJECUTAMOS EL ARCHIVO CALL_PROCEDURES PARA PODER AGREGAR DATOS DE PRUEBA [DATOS]([GARDEN_DB/calls_procedures.sql at main · David-Albarracin/GARDEN_DB (github.com)])

#### VISTAS PARA FACILITAR BÚSQUEDAS 

```sql
-- VISTA PARA FACILITAR LAS BUSQUEDAS DE LOS CLIENTES
USE garden;

DROP VIEW IF EXISTS customer_meta;

CREATE VIEW customer_meta AS
SELECT 
	cu.customer_id AS 'cliente_id',
	cu.customer_name AS 'cliente_nombre',
	c.city_name AS 'ciudad',
	pn.phone_number AS 'telefono',
	a.address_line_1 AS 'direccion',
	e.employee_first_name AS 'empleado_nombre'
FROM 
	customer AS cu
INNER JOIN
	address AS a ON a.customer_id = cu.customer_id
INNER JOIN
	city AS c ON c.city_id = a.city_id
INNER JOIN
	customer_contact AS cc ON cc.customer_id = cu.customer_id
INNER JOIN
	phone_number AS pn ON pn.customer_contact_id = cc.customer_contact_id
INNER JOIN
	employee AS e ON e.employee_id = cu.employee_id;
	
-- VISTA PARA FACILITAR LAS BUSQUEDAS DE LOS EMPLEADOS CON CLIENTES
USE garden;

DROP VIEW IF EXISTS employee_data;

CREATE VIEW employee_data AS
SELECT 
	e.employee_first_name,
	e.office_id,
	c.customer_name
FROM 
	employee AS e
LEFT JOIN
	customer AS c ON c.employee_id = e.employee_id
WHERE 
	c.employee_id IS NULL 
	OR 
	c.employee_id IS NOT NULL
	;
	
-- VISTA PARA PRODUCTOS NO COMPRADOS 
USE garden;

DROP VIEW IF EXISTS products_data;

CREATE VIEW products_data AS
SELECT DISTINCT 
	p.product_name,
	'Descripcion',
	od.amount
FROM 
	product AS p
LEFT JOIN
	order_detail AS od ON od.product_code = p.product_code
WHERE 
	od.product_code IS NULL 
	OR 
	od.product_code IS NOT NULL
	;

-- EMPLEADOS POR PAIS 

USE garden;

DROP VIEW IF EXISTS employee_country;

CREATE VIEW employee_country AS
SELECT
	co.country_name,
	COUNT(c.customer_id) AS 'Total Clientes'
FROM 
	address AS a
INNER JOIN
	customer AS c ON c.customer_id = a.customer_id
INNER JOIN 
	city AS cy ON cy.city_id = a.city_id
INNER JOIN 
	region AS r ON r.region_id = cy.region_id
INNER JOIN 
	country AS co ON co.country_id = r.country_id 
GROUP BY 
	co.country_name;

-- VISTA PARA CONTAR CLIENTES POR EMPLEADO
USE garden;

DROP VIEW IF EXISTS employee_customer_count;

CREATE VIEW employee_customer_count AS
SELECT
	e.employee_first_name AS 'Empleado',
	COUNT(c.customer_id) AS '#Clientes'
FROM 
	employee AS e
INNER JOIN
	customer AS c ON c.employee_id = e.employee_id
GROUP BY 
	e.employee_first_name;
	
-- VISTA PARA EMPLEADO CLIENTE N PEDIDOS Y OFFICINA 

USE garden;

DROP VIEW IF EXISTS product_info_sell;

CREATE VIEW product_info_sell AS
SELECT
	e.employee_first_name,
	e.employee_first_surname,
	r.rol_name,
	c.customer_name,
	COUNT(p.id_transaction) AS 'N_Pagos',
	o.office_id,
	cy.city_name,
	o.office_phone_number
FROM 
	employee AS e
LEFT JOIN
	customer AS c ON c.employee_id = e.employee_id
LEFT JOIN 
	pay AS p ON p.customer_id = c.customer_id 
INNER JOIN 
	office AS o ON o.office_id = e.office_id
INNER JOIN 
	city AS cy ON cy.city_id = o.city_id
INNER JOIN 
	rol AS r ON r.rol_id = e.rol_id
WHERE 
	(p.customer_id AND c.employee_id) IS NULL 
	OR 
	(p.customer_id AND c.employee_id )IS NOT NULL
GROUP BY 
	e.employee_first_name,
	e.employee_first_surname,
	r.rol_name,
	c.customer_name,
	o.office_id,
	cy.city_name,
	o.office_phone_number;
	
-- VISTA PARA VER STOCK CANTIDAD VENDIDAS DE PRODUCTOS
USE garden;

DROP VIEW IF EXISTS product_info_sell;

CREATE VIEW product_info_sell AS
SELECT
	p.product_name,
	p.price_sell,
	COUNT(od.product_code) AS 'UV',
	p.stock_amount
FROM 
	product AS p
INNER JOIN
	order_detail AS od ON od.product_code = p.product_code 
	
GROUP BY
	p.product_name,
	p.price_sell,
	p.stock_amount;

-- Vista Sin Clientes
USE garden;

DROP VIEW IF EXISTS employee_not_customers;

CREATE VIEW employee_not_customers AS
SELECT
	CONCAT(e.employee_first_name, ' ',
	e.employee_first_surname) AS Empleado,
	r.rol_name AS rol
FROM 
	employee AS e
INNER JOIN
	rol AS r ON r.rol_id = e.rol_id 
WHERE 
	e.employee_id NOT IN(
		SELECT 
			c.employee_id
		FROM 
			customer AS c 
	);
	
	
-- Vista comprados
USE garden;

DROP VIEW IF EXISTS show_products_nots;

CREATE VIEW show_products_nots AS
SELECT DISTINCT
    p.product_code,
    p.product_name
FROM
    product AS p
INNER JOIN
    order_detail AS dp ON p.product_code = dp.product_code;
    
-- Vista No comprados
USE garden;

DROP VIEW IF EXISTS show_products_yes;

CREATE VIEW show_products_yes AS
SELECT DISTINCT
    p.product_code,
    p.product_name
FROM
    product AS p
WHERE 
	NOT EXISTS(
		SELECT 1
		FROM order_detail AS od
		WHERE 
			od.product_code = p.product_code
	);

```



## Consultas sobre una tabla

1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.

   ```sql
   SELECT 
   	o.office_id,
   	c.city_name 
   FROM 
   	office AS o, 
   	city AS c
   WHERE 
   	c.city_id = o.city_id;
   	
   +-----------+----------------------+
   | office_id | city_name            |
   +-----------+----------------------+
   | BCN-ES    | Barcelona            |
   | BOS-USA   | Boston               |
   | LON-UK    | Londres              |
   | MAD-ES    | Madrid               |
   | PAR-FR    | Paris                |
   | SFC-USA   | San Francisco        |
   | SYD-AU    | Sydney               |
   | TAL-ES    | Talavera de la Reina |
   | TOK-JP    | Tokyo                |
   +-----------+----------------------+
   9 rows in set (0,00 sec)
   
   ```

2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.

   ```sql
   SELECT 
   	o.office_id,
   	c.city_name,
   	o.office_phone_number
   FROM 
   	office AS o
   INNER JOIN
   	city AS c ON c.city_id = o.city_id
   INNER JOIN
   	region AS r ON c.region_id = r.region_id
   INNER JOIN
   	country AS co ON co.country_id = r.country_id
   WHERE 
   	co.country_name = 'España';
   	
   +-----------+----------------------+---------------------+
   | office_id | city_name            | office_phone_number |
   +-----------+----------------------+---------------------+
   | BCN-ES    | Barcelona            | +34 93 3561182      |
   | MAD-ES    | Madrid               | +34 91 7514487      |
   | TAL-ES    | Talavera de la Reina | +34 925 867231      |
   +-----------+----------------------+---------------------+
   
   ```

3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo
   jefe tiene un código de jefe igual a 7.

   ```sql
   
   SELECT 
   	e.employee_first_name,
   	e.employee_first_surname,
   	e.employee_last_surname 
   FROM
   	employee AS e 
   WHERE
   	e.boss_id = 7;
   	
   +---------------------+------------------------+-----------------------+
   | employee_first_name | employee_first_surname | employee_last_surname |
   +---------------------+------------------------+-----------------------+
   | Mariano             | López                  | Murcia                |
   | Lucio               | Campoamor              | Martín                |
   | Hilario             | Rodriguez              | Huertas               |
   +---------------------+------------------------+-----------------------+
   
   ```
   
4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la
   empresa.

   ```sql
   SELECT 
   	e.employee_first_name AS 'Nombre',
   	e.employee_first_surname AS 'Apellido',
   	e.employee_email AS 'Email'
   FROM
   	employee AS e 
   INNER JOIN
   	rol AS r ON r.rol_id = e.rol_id
   WHERE 
   	r.rol_name = 'Director General';
   	
   +--------+----------+----------------------+
   | Nombre | Apellido | Email                |
   +--------+----------+----------------------+
   | Marcos | Magaña   | marcos@jardineria.es |
   +--------+----------+----------------------+
   
   ```
   
5. Devuelve un listado con el nombre, apellidos y puesto de aquellos
   empleados que no sean representantes de ventas.

   ```sql
   SELECT 
   	e.employee_first_name AS 'Nombre',
   	e.employee_first_surname AS 'Apellido',
   	r.rol_name AS 'Rol'
   FROM
   	employee AS e 
   INNER JOIN
   	rol AS r ON r.rol_id = e.rol_id
   WHERE 
   	r.rol_name != 'Representante Ventas'
   ORDER BY 
   	r.rol_name ASC;
   	
   +----------+------------+-----------------------+
   | Nombre   | Apellido   | Rol                   |
   +----------+------------+-----------------------+
   | Marcos   | Magaña     | Director General      |
   | Carlos   | Soria      | Director Oficina      |
   | Emmanuel | Magaña     | Director Oficina      |
   | Francois | Fignon     | Director Oficina      |
   | Michael  | Bolton     | Director Oficina      |
   | Hilary   | Washington | Director Oficina      |
   | Nei      | Nishikori  | Director Oficina      |
   | Amy      | Johnson    | Director Oficina      |
   | Kevin    | Fallmer    | Director Oficina      |
   | Maria    | Solís      | Secretaria            |
   | Ruben    | López      | Subdirector Marketing |
   | Alberto  | Soria      | Subdirector Ventas    |
   +----------+------------+-----------------------+
   
   ```
   
6. Devuelve un listado con el nombre de los todos los clientes españoles.

   ```sql
   SELECT 
   	cu.customer_name,
   	co.country_name
   FROM 
   	customer AS cu
   INNER JOIN
   	address AS a ON a.customer_id  = cu.customer_id 
   INNER JOIN
   	city AS c ON c.city_id = a.city_id
   INNER JOIN
   	region AS r ON c.region_id = r.region_id
   INNER JOIN
   	country AS co ON co.country_id = r.country_id
   WHERE 
   	co.country_name = 'España';
   	
   +--------------------------------+--------------+
   | customer_name                  | country_name |
   +--------------------------------+--------------+
   | Americh Golf Management SL     | España       |
   | El Prat                        | España       |
   | Flowers, S.A                   | España       |
   | Beragua                        | España       |
   | Club Golf Puerta del hierro    | España       |
   | Naturagua                      | España       |
   | DaraDistribuciones             | España       |
   | Madrileña de riegos            | España       |
   | Dardena S.A.                   | España       |
   | Jardin de Flores               | España       |
   | Naturajardin                   | España       |
   | Jardines y Mansiones Cactus SL | España       |
   | Jardinerías Matías SL          | España       |
   | Flores S.L.                    | España       |
   | Lasas S.A.                     | España       |
   | Lasas S.A.                     | España       |
   | Flores Marivi                  | España       |
   | Fuenla City                    | España       |
   | Jardineria Sara                | España       |
   | Campohermoso                   | España       |
   | Camunas Jardines S.L.          | España       |
   | Vivero Humanes                 | España       |
   | Top Campo                      | España       |
   | Agrojardin                     | España       |
   +--------------------------------+--------------+
   	
   ```

7. Devuelve un listado con los distintos estados por los que puede pasar un
   pedido.

   ```sql
   SELECT DISTINCT 
   	o.status 
   FROM 
   	`order` AS o;
   	
   +-----------+
   | status    |
   +-----------+
   | Entregado |
   | Rechazado |
   | Pendiente |
   +-----------+
   	
   ```
   
8. Devuelve un listado con el código de cliente de aquellos clientes que
   realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar
   aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta:

   • Utilizando la función YEAR de MySQL.
   • Utilizando la función DATE_FORMAT de MySQL.
   • Sin utilizar ninguna de las funciones anteriores.

   ```sql
   -- Utilizando la función YEAR de MySQL.
   SELECT DISTINCT 
   	c.customer_id 
   FROM 
   	customer AS c
   INNER JOIN
   	pay AS p ON p.customer_id = c.customer_id
   WHERE 
   	YEAR(p.date_pay) = '2008';
   	
   -- Utilizando la función DATE_FORMAT de MySQL
   
   SELECT DISTINCT 
   	c.customer_id 
   FROM 
   	customer AS c
   INNER JOIN
   	pay AS p ON p.customer_id = c.customer_id
   WHERE 
   	DATE_FORMAT(p.date_pay, '%Y') = '2008' ;
   	
   -- Sin utilizar ninguna de las funciones anteriores.
   
   SELECT DISTINCT 
   	c.customer_id 
   FROM 
   	customer AS c
   INNER JOIN
   	pay AS p ON p.customer_id = c.customer_id
   WHERE 
   	p.date_pay LIKE '%2008%' ;
   	
   +-------------+
   | customer_id |
   +-------------+
   |           1 |
   |          13 |
   |          14 |
   |          26 |
   +-------------+
   
   ```
   
9. Devuelve un listado con el código de pedido, código de cliente, fecha
   esperada y fecha de entrega de los pedidos que no han sido entregados a
   tiempo.

   ```sql
   SELECT 
   	O.order_code AS 'Codigo Pedido',
   	O.customer_id AS 'Codigo Cliente',
   	O.date_waiting AS 'Fecha de Espera',
   	O.date_deliver AS 'Fecha de Entrega'
   FROM 
   	`order` AS O
   WHERE 
   	O.date_waiting > O.date_deliver;
   
   +---------------+----------------+-----------------+------------------+
   | Codigo Pedido | Codigo Cliente | Fecha de Espera | Fecha de Entrega |
   +---------------+----------------+-----------------+------------------+
   |             2 |              5 | 2007-10-28      | 2007-10-26       |
   |            15 |              7 | 2009-01-12      | 2009-01-11       |
   |            24 |             14 | 2008-07-31      | 2008-07-25       |
   |            30 |             13 | 2008-09-03      | 2008-08-31       |
   |            36 |             14 | 2008-12-15      | 2008-12-10       |
   |            48 |             26 | 2008-03-30      | 2008-03-29       |
   |            53 |             13 | 2008-11-15      | 2008-11-09       |
   |            58 |              3 | 2009-01-31      | 2009-01-30       |
   |            64 |              1 | 2009-01-31      | 2009-01-30       |
   |            89 |             35 | 2007-12-13      | 2007-12-10       |
   |            91 |             27 | 2009-03-29      | 2009-03-27       |
   |            93 |             27 | 2009-05-30      | 2009-05-17       |
   +---------------+----------------+-----------------+------------------+
   
   
   ```
   
10. Devuelve un listado con el código de pedido, código de cliente, fecha
    esperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al
    menos dos días antes de la fecha esperada.

    • Utilizando la función ADDDATE de MySQL.
    • Utilizando la función DATEDIFF de MySQL.
    • ¿Sería posible resolver esta consulta utilizando el operador de suma + o
    resta -?

    ```sql
    -- Utilizando la función ADDDATE de MySQL.
    SELECT 
    	O.order_code AS 'Codigo Pedido',
    	O.customer_id AS 'Codigo Cliente',
    	O.date_waiting AS 'Fecha de Espera',
    	O.date_deliver AS 'Fecha de Entrega'
    FROM 
    	`order` AS O
    WHERE 
    	O.date_deliver <= ADDDATE(O.date_waiting , INTERVAL -2 DAY);
    	
    -- Utilizando la función DATEDIFF de MySQL.
    
    SELECT 
    	O.order_code AS 'Codigo Pedido',
    	O.customer_id AS 'Codigo Cliente',
    	O.date_waiting AS 'Fecha de Espera',
    	O.date_deliver AS 'Fecha de Entrega'
    FROM 
    	`order` AS O
    WHERE 
    	DATEDIFF(O.date_waiting, O.date_deliver) >= 2;
    	
    -- ¿Sería posible resolver esta consulta utilizando el operador de -
    
    SELECT 
    	O.order_code AS 'Codigo Pedido',
    	O.customer_id AS 'Codigo Cliente',
    	O.date_waiting AS 'Fecha de Espera',
    	O.date_deliver AS 'Fecha de Entrega'
    FROM 
    	`order` AS O
    WHERE 
    	(O.date_waiting - O.date_deliver) >= 2;
    
    +---------------+----------------+-----------------+------------------+
    | Codigo Pedido | Codigo Cliente | Fecha de Espera | Fecha de Entrega |
    +---------------+----------------+-----------------+------------------+
    |             2 |              5 | 2007-10-28      | 2007-10-26       |
    |            24 |             14 | 2008-07-31      | 2008-07-25       |
    |            30 |             13 | 2008-09-03      | 2008-08-31       |
    |            36 |             14 | 2008-12-15      | 2008-12-10       |
    |            53 |             13 | 2008-11-15      | 2008-11-09       |
    |            89 |             35 | 2007-12-13      | 2007-12-10       |
    |            91 |             27 | 2009-03-29      | 2009-03-27       |
    |            93 |             27 | 2009-05-30      | 2009-05-17       |
    +---------------+----------------+-----------------+------------------+
    
    ```
    
11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.

    ```sql
    SELECT 
    	O.order_code AS 'Codigo Pedido',
    	O.customer_id AS 'Codigo Cliente',
    	O.date_waiting AS 'Fecha de Espera',
    	O.date_deliver AS 'Fecha de Entrega',
    	O.status AS 'Estado'
    FROM 
    	`order` AS O
    WHERE 
    	O.status = 'rechazado'
    	AND 
    	(YEAR (O.date_order) = '2009'
    	OR
    	YEAR (O.date_deliver) = '2009');
    	
    +---------------+----------------+-----------------+------------------+-----------+
    | Codigo Pedido | Codigo Cliente | Fecha de Espera | Fecha de Entrega | Estado    |
    +---------------+----------------+-----------------+------------------+-----------+
    |            14 |              7 | 2009-01-02      | NULL             | Rechazado |
    |            21 |              9 | 2009-01-09      | 2009-01-09       | Rechazado |
    |            25 |              1 | 2009-02-08      | NULL             | Rechazado |
    |            26 |              3 | 2009-02-12      | NULL             | Rechazado |
    |            40 |             19 | 2009-03-10      | 2009-03-13       | Rechazado |
    |            46 |             23 | 2009-03-04      | 2009-03-05       | Rechazado |
    |            65 |              1 | 2009-02-08      | NULL             | Rechazado |
    |            66 |              3 | 2009-02-12      | NULL             | Rechazado |
    |            74 |             15 | 2009-01-22      | NULL             | Rechazado |
    |            81 |             28 | 2009-01-24      | NULL             | Rechazado |
    |           101 |             16 | 2009-03-27      | NULL             | Rechazado |
    |           105 |             30 | 2009-02-20      | NULL             | Rechazado |
    |           113 |             36 | 2008-11-09      | 2009-01-09       | Rechazado |
    |           120 |             16 | 2009-03-27      | NULL             | Rechazado |
    |           125 |             30 | 2009-02-20      | NULL             | Rechazado |
    +---------------+----------------+-----------------+------------------+-----------+
    
    ```

12. Devuelve un listado de todos los pedidos que han sido entregados en el
    mes de enero de cualquier año.

    ```sql
    SELECT 
    	O.order_code AS 'Codigo Pedido',
    	O.customer_id AS 'Codigo Cliente',
    	O.date_waiting AS 'Fecha de Espera',
    	O.date_deliver AS 'Fecha de Entrega',
    	O.status AS 'Estado'
    FROM 
    	`order` AS O
    WHERE 
    	O.status = 'entregado'
    	AND 
    	MONTH(O.date_deliver) = 1;
    	
    +---------------+----------------+-----------------+------------------+-----------+
    | Codigo Pedido | Codigo Cliente | Fecha de Espera | Fecha de Entrega | Estado    |
    +---------------+----------------+-----------------+------------------+-----------+
    |             1 |              5 | 2006-01-19      | 2006-01-19       | Entregado |
    |            13 |              7 | 2009-01-14      | 2009-01-15       | Entregado |
    |            15 |              7 | 2009-01-12      | 2009-01-11       | Entregado |
    |            16 |              7 | 2009-01-07      | 2009-01-15       | Entregado |
    |            17 |              7 | 2009-01-09      | 2009-01-11       | Entregado |
    |            18 |              9 | 2009-01-06      | 2009-01-07       | Entregado |
    |            22 |              9 | 2009-01-11      | 2009-01-13       | Entregado |
    |            32 |              4 | 2007-01-19      | 2007-01-27       | Entregado |
    |            55 |             14 | 2009-01-10      | 2009-01-11       | Entregado |
    |            58 |              3 | 2009-01-31      | 2009-01-30       | Entregado |
    |            64 |              1 | 2009-01-31      | 2009-01-30       | Entregado |
    |            75 |             15 | 2009-01-13      | 2009-01-13       | Entregado |
    |            79 |             28 | 2009-01-13      | 2009-01-13       | Entregado |
    |            82 |             28 | 2009-01-29      | 2009-01-29       | Entregado |
    |            95 |             35 | 2008-01-19      | 2008-01-19       | Entregado |
    |           100 |             16 | 2009-01-15      | 2009-01-15       | Entregado |
    |           102 |             16 | 2009-01-08      | 2009-01-08       | Entregado |
    |           114 |             36 | 2009-01-29      | 2009-01-31       | Entregado |
    |           119 |             16 | 2009-01-15      | 2009-01-15       | Entregado |
    |           121 |             16 | 2009-01-08      | 2009-01-08       | Entregado |
    +---------------+----------------+-----------------+------------------+-----------+
    
    ```
    
13. Devuelve un listado con todos los pagos que se realizaron en el
    año 2008 mediante Paypal. Ordene el resultado de mayor a menor.

    ```sql
    SELECT 
    	p.id_transaction AS 'id',
    	p.date_pay,
    	p.total,
    	p.method_pay AS 'Metodo',
    	p.customer_id AS 'Cliente'
    FROM 
    	pay AS  p 
    WHERE 
    	YEAR (date_pay) = '2008'
    ORDER BY 
    	total DESC;
    	
    +---------------+------------+-------+--------+---------+
    | id            | date_pay   | total | Metodo | Cliente |
    +---------------+------------+-------+--------+---------+
    | ak-std-000020 | 2008-03-18 | 18846 | PayPal |      26 |
    | ak-std-000015 | 2008-07-15 |  4160 | PayPal |      14 |
    | ak-std-000014 | 2008-08-04 |  2246 | PayPal |      13 |
    | ak-std-000001 | 2008-11-10 |  2000 | PayPal |       1 |
    | ak-std-000002 | 2008-12-10 |  2000 | PayPal |       1 |
    +---------------+------------+-------+--------+---------+
    
    ```
    
14. Devuelve un listado con todas las formas de pago que aparecen en la
    tabla pago. Tenga en cuenta que no deben aparecer formas de pago
    repetidas.

    ```sql
    SELECT DISTINCT 
    	p.method_pay AS 'Metodo'
    FROM 
    	pay AS  p;
    	
    +---------------+
    | Metodo        |
    +---------------+
    | PayPal        |
    | Transferencia |
    | Cheque        |
    +---------------+
    	
    ```
    
15. Devuelve un listado con todos los productos que pertenecen a la
    gama Ornamentales y que tienen más de 100 unidades en stock. El listado
    deberá estar ordenado por su precio de venta, mostrando en primer lugar
    los de mayor precio.

    ```sql
    SELECT
    	p.product_name AS 'Nombre',
    	p.stock_amount AS 'Cantidad',
    	p.gama AS 'Gama'
    FROM 
    	product AS p 
    INNER JOIN
    	gama_product AS gp ON gp.gama_product_id = p.gama
    WHERE 
    	gp.gama_product_id LIKE '%Ornamentales%'
    	AND 
    	p.stock_amount > 100;
    	
    +--------------------------------------------+----------+--------------+
    | Nombre                                     | Cantidad | Gama         |
    +--------------------------------------------+----------+--------------+
    | Escallonia (Mix)                           |      120 | Ornamentales |
    | Evonimus Emerald Gayeti                    |      120 | Ornamentales |
    | Evonimus Pulchellus                        |      120 | Ornamentales |
    | Forsytia Intermedia "Lynwood"              |      120 | Ornamentales |
    | Hibiscus Syriacus  "Diana" -Blanco Puro    |      120 | Ornamentales |
    | Hibiscus Syriacus  "Helene" -Blanco-C.rojo |      120 | Ornamentales |
    | Hibiscus Syriacus "Pink Giant" Rosa        |      120 | Ornamentales |
    | Laurus Nobilis Arbusto - Ramificado Bajo   |      120 | Ornamentales |
    | Lonicera Nitida                            |      120 | Ornamentales |
    | Lonicera Nitida "Maigrum"                  |      120 | Ornamentales |
    | Lonicera Pileata                           |      120 | Ornamentales |
    | Philadelphus "Virginal"                    |      120 | Ornamentales |
    | Prunus pisardii                            |      120 | Ornamentales |
    | Viburnum Tinus "Eve Price"                 |      120 | Ornamentales |
    | Weigelia "Bristol Ruby"                    |      120 | Ornamentales |
    +--------------------------------------------+----------+--------------+
    
    ```
    
16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y
    cuyo representante de ventas tenga el código de empleado 11 o 30.

    ```sql
    SELECT 
    	cu.customer_name AS 'Nombre',
    	c.city_name AS 'Ciudad',
    	cu.employee_id AS 'Codigo Empleado'
    FROM 
    	customer AS cu
    INNER JOIN
    	address AS a ON a.customer_id  = cu.customer_id 
    INNER JOIN
    	city AS c ON c.city_id = a.city_id
    WHERE 
    	c.city_name  = 'Madrid'
    	AND 
    	cu.employee_id IN (11, 30);
    
    +-----------------------------+--------+-----------------+
    | Nombre                      | Ciudad | Codigo Empleado |
    +-----------------------------+--------+-----------------+
    | Beragua                     | Madrid |              11 |
    | Club Golf Puerta del hierro | Madrid |              11 |
    | Naturagua                   | Madrid |              11 |
    | DaraDistribuciones          | Madrid |              11 |
    | Madrileña de riegos         | Madrid |              11 |
    | Jardin de Flores            | Madrid |              30 |
    | Naturajardin                | Madrid |              30 |
    +-----------------------------+--------+-----------------+
    ```

## Consultas multitabla (Composición interna)

Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2. Las consultas con
sintaxis de SQL2 se deben resolver con INNER JOIN y NATURAL JOIN.

1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su
   representante de ventas.

   ```sql
   -- VIEW 
   SELECT 
   	cliente_nombre,
   	empleado_nombre ,
   	empleado_apellido
   FROM 
   	customer_meta;
   	
   +--------------------------------+-----------------+-------------------+
   | cliente_nombre                 | empleado_nombre | empleado_apellido |
   +--------------------------------+-----------------+-------------------+
   | GoldFish Garden                | Walter Santiago | Sanchez           |
   | Gardening Associates           | Walter Santiago | Sanchez           |
   | Gerudo Valley                  | Lorena          | Paxton            |
   | Tendo Garden                   | Lorena          | Paxton            |
   | Lasas S.A.                     | Mariano         | López             |
   | Beragua                        | Emmanuel        | Magaña            |
   | Club Golf Puerta del hierro    | Emmanuel        | Magaña            |
   | Naturagua                      | Emmanuel        | Magaña            |
   | DaraDistribuciones             | Emmanuel        | Magaña            |
   | Madrileña de riegos            | Emmanuel        | Magaña            |
   | Lasas S.A.                     | Mariano         | López             |
   | Camunas Jardines S.L.          | Mariano         | López             |
   | Dardena S.A.                   | Mariano         | López             |
   | Jardin de Flores               | Julian          | Bellinelli        |
   | Flores Marivi                  | Felipe          | Rosas             |
   | Flowers, S.A                   | Felipe          | Rosas             |
   | Naturajardin                   | Julian          | Bellinelli        |
   | Golf S.A.                      | José Manuel     | Martinez          |
   | Americh Golf Management SL     | José Manuel     | Martinez          |
   | Aloha                          | José Manuel     | Martinez          |
   | El Prat                        | José Manuel     | Martinez          |
   | Sotogrande                     | José Manuel     | Martinez          |
   | Vivero Humanes                 | Julian          | Bellinelli        |
   | Fuenla City                    | Felipe          | Rosas             |
   | Jardines y Mansiones Cactus SL | Lucio           | Campoamor         |
   | Jardinerías Matías SL          | Lucio           | Campoamor         |
   | Agrojardin                     | Julian          | Bellinelli        |
   | Top Campo                      | Felipe          | Rosas             |
   | Jardineria Sara                | Felipe          | Rosas             |
   | Campohermoso                   | Julian          | Bellinelli        |
   | france telecom                 | Lionel          | Narvaez           |
   | Musée du Louvre                | Lionel          | Narvaez           |
   | Tutifruti S.A                  | Mariko          | Kishi             |
   | Flores S.L.                    | Michael         | Bolton            |
   | The Magic Garden               | Michael         | Bolton            |
   | El Jardin Viviente S.L         | Mariko          | Kishi             |
   +--------------------------------+-----------------+-------------------+
   
   ```
   
2. Muestra el nombre de los clientes que hayan realizado pagos junto con el
   nombre de sus representantes de ventas.

   ```sql
   SELECT 
   	c.cliente_nombre,
   	c.empleado_nombre
   FROM 
   	customer_meta AS c
   INNER JOIN
   	pay AS p ON p.customer_id =  c.cliente_id;
   
   +--------------------------------+-----------------+
   | cliente_nombre                 | empleado_nombre |
   +--------------------------------+-----------------+
   | GoldFish Garden                | Walter Santiago |
   | GoldFish Garden                | Walter Santiago |
   | Gardening Associates           | Walter Santiago |
   | Gardening Associates           | Walter Santiago |
   | Gardening Associates           | Walter Santiago |
   | Gerudo Valley                  | Lorena          |
   | Gerudo Valley                  | Lorena          |
   | Gerudo Valley                  | Lorena          |
   | Gerudo Valley                  | Lorena          |
   | Gerudo Valley                  | Lorena          |
   | Tendo Garden                   | Lorena          |
   | Beragua                        | Emmanuel        |
   | Naturagua                      | Emmanuel        |
   | Camunas Jardines S.L.          | Mariano         |
   | Dardena S.A.                   | Mariano         |
   | Jardin de Flores               | Julian          |
   | Jardin de Flores               | Julian          |
   | Flores Marivi                  | Felipe          |
   | Golf S.A.                      | José Manuel     |
   | Sotogrande                     | José Manuel     |
   | Jardines y Mansiones Cactus SL | Lucio           |
   | Jardinerías Matías SL          | Lucio           |
   | Agrojardin                     | Julian          |
   | Jardineria Sara                | Felipe          |
   | Tutifruti S.A                  | Mariko          |
   | El Jardin Viviente S.L         | Mariko          |
   +--------------------------------+-----------------+
   ```
   
3. Muestra el nombre de los clientes que no hayan realizado pagos junto con
   el nombre de sus representantes de ventas.

   ```sql
   SELECT 
   	c.cliente_nombre,
   	c.empleado_nombre
   FROM 
   	customer_meta AS c
   INNER JOIN
   	pay AS p ON p.customer_id =  c.cliente_id;
   	
   +--------------------------------+-----------------+
   | cliente_nombre                 | empleado_nombre |
   +--------------------------------+-----------------+
   | GoldFish Garden                | Walter Santiago |
   | GoldFish Garden                | Walter Santiago |
   | Gardening Associates           | Walter Santiago |
   | Gardening Associates           | Walter Santiago |
   | Gardening Associates           | Walter Santiago |
   | Gerudo Valley                  | Lorena          |
   | Gerudo Valley                  | Lorena          |
   | Gerudo Valley                  | Lorena          |
   | Gerudo Valley                  | Lorena          |
   | Gerudo Valley                  | Lorena          |
   | Tendo Garden                   | Lorena          |
   | Beragua                        | Emmanuel        |
   | Naturagua                      | Emmanuel        |
   | Camunas Jardines S.L.          | Mariano         |
   | Dardena S.A.                   | Mariano         |
   | Jardin de Flores               | Julian          |
   | Jardin de Flores               | Julian          |
   | Flores Marivi                  | Felipe          |
   | Golf S.A.                      | José Manuel     |
   | Sotogrande                     | José Manuel     |
   | Jardines y Mansiones Cactus SL | Lucio           |
   | Jardinerías Matías SL          | Lucio           |
   | Agrojardin                     | Julian          |
   | Jardineria Sara                | Felipe          |
   | Tutifruti S.A                  | Mariko          |
   | El Jardin Viviente S.L         | Mariko          |
   +--------------------------------+-----------------+
   ```
   
4. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus
   representantes junto con la ciudad de la oficina a la que pertenece el
   representante.

   ```sql
   SELECT 
   	c.cliente_nombre,
   	c.empleado_nombre,
   	cy.city_name 
   FROM 
   	customer_meta AS c
   INNER JOIN
   	pay AS p ON p.customer_id =  c.cliente_id
   INNER JOIN
   	office AS o ON o.office_id = c.officina
   INNER JOIN
   	city AS cy ON cy.city_id  = o.city_id ;
   	
   +--------------------------------+-----------------+----------------------+
   | cliente_nombre                 | empleado_nombre | city_name            |
   +--------------------------------+-----------------+----------------------+
   | GoldFish Garden                | Walter Santiago | San Francisco        |
   | GoldFish Garden                | Walter Santiago | San Francisco        |
   | Gardening Associates           | Walter Santiago | San Francisco        |
   | Gardening Associates           | Walter Santiago | San Francisco        |
   | Gardening Associates           | Walter Santiago | San Francisco        |
   | Gerudo Valley                  | Lorena          | Boston               |
   | Gerudo Valley                  | Lorena          | Boston               |
   | Gerudo Valley                  | Lorena          | Boston               |
   | Gerudo Valley                  | Lorena          | Boston               |
   | Gerudo Valley                  | Lorena          | Boston               |
   | Tendo Garden                   | Lorena          | Boston               |
   | Beragua                        | Emmanuel        | Barcelona            |
   | Naturagua                      | Emmanuel        | Barcelona            |
   | Camunas Jardines S.L.          | Mariano         | Madrid               |
   | Dardena S.A.                   | Mariano         | Madrid               |
   | Jardin de Flores               | Julian          | Sydney               |
   | Jardin de Flores               | Julian          | Sydney               |
   | Flores Marivi                  | Felipe          | Talavera de la Reina |
   | Golf S.A.                      | José Manuel     | Barcelona            |
   | Sotogrande                     | José Manuel     | Barcelona            |
   | Jardines y Mansiones Cactus SL | Lucio           | Madrid               |
   | Jardinerías Matías SL          | Lucio           | Madrid               |
   | Agrojardin                     | Julian          | Sydney               |
   | Jardineria Sara                | Felipe          | Talavera de la Reina |
   | Tutifruti S.A                  | Mariko          | Sydney               |
   | El Jardin Viviente S.L         | Mariko          | Sydney               |
   +--------------------------------+-----------------+----------------------+
   ```
   
5. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre
   de sus representantes junto con la ciudad de la oficina a la que pertenece el
   representante.

   ```sql
   SELECT 
   	c.cliente_nombre,
   	c.empleado_nombre,
   	cy.city_name 
   FROM 
   	customer_meta AS c
   INNER JOIN
   	pay AS p ON p.customer_id =  c.cliente_id
   INNER JOIN
   	office AS o ON o.office_id = c.officina
   INNER JOIN
   	city AS cy ON cy.city_id  = o.city_id ;
   	
   +--------------------------------+-----------------+----------------------+
   | cliente_nombre                 | empleado_nombre | city_name            |
   +--------------------------------+-----------------+----------------------+
   | GoldFish Garden                | Walter Santiago | San Francisco        |
   | GoldFish Garden                | Walter Santiago | San Francisco        |
   | Gardening Associates           | Walter Santiago | San Francisco        |
   | Gardening Associates           | Walter Santiago | San Francisco        |
   | Gardening Associates           | Walter Santiago | San Francisco        |
   | Gerudo Valley                  | Lorena          | Boston               |
   | Gerudo Valley                  | Lorena          | Boston               |
   | Gerudo Valley                  | Lorena          | Boston               |
   | Gerudo Valley                  | Lorena          | Boston               |
   | Gerudo Valley                  | Lorena          | Boston               |
   | Tendo Garden                   | Lorena          | Boston               |
   | Beragua                        | Emmanuel        | Barcelona            |
   | Naturagua                      | Emmanuel        | Barcelona            |
   | Camunas Jardines S.L.          | Mariano         | Madrid               |
   | Dardena S.A.                   | Mariano         | Madrid               |
   | Jardin de Flores               | Julian          | Sydney               |
   | Jardin de Flores               | Julian          | Sydney               |
   | Flores Marivi                  | Felipe          | Talavera de la Reina |
   | Golf S.A.                      | José Manuel     | Barcelona            |
   | Sotogrande                     | José Manuel     | Barcelona            |
   | Jardines y Mansiones Cactus SL | Lucio           | Madrid               |
   | Jardinerías Matías SL          | Lucio           | Madrid               |
   | Agrojardin                     | Julian          | Sydney               |
   | Jardineria Sara                | Felipe          | Talavera de la Reina |
   | Tutifruti S.A                  | Mariko          | Sydney               |
   | El Jardin Viviente S.L         | Mariko          | Sydney               |
   +--------------------------------+-----------------+----------------------+
   ```
   
6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.

   ```sql
   SELECT DISTINCT 
   	o.address_line_1  
   FROM 
   	customer AS c
   INNER JOIN
   	address AS a ON a.customer_id = c.customer_id
   INNER JOIN 
   	city AS c2 ON c2.city_id = a.city_id
   INNER JOIN 
   	employee AS e ON e.employee_id = c.employee_id 
   INNER JOIN 
   	office AS o ON o.office_id = e.office_id 
   WHERE 
   	c2.city_name LIKE '%Fuenlabrada%';
   	
   +------------------------------+
   | address_line_1               |
   +------------------------------+
   | Bulevar Indalecio Prieto, 32 |
   | Francisco Aguirre, 32        |
   | 5-11 Wentworth Avenue        |
   +------------------------------+
   3 rows in set (0.00 sec)
   ```

7. Devuelve el nombre de los clientes y el nombre de sus representantes junto
   con la ciudad de la oficina a la que pertenece el representante.

   ```sql
   SELECT 
   	c.cliente_nombre,
   	c.empleado_nombre,
   	cy.city_name 
   FROM 
   	customer_meta AS c
   INNER JOIN
   	office AS o ON o.office_id = c.officina
   INNER JOIN
   	city AS cy ON cy.city_id  = o.city_id
   INNER JOIN 
   	address AS a ON a.customer_id = c.cliente_id ;
   	
   +--------------------------------+-----------------+----------------------+
   | cliente_nombre                 | empleado_nombre | city_name            |
   +--------------------------------+-----------------+----------------------+
   | GoldFish Garden                | Walter Santiago | San Francisco        |
   | Gardening Associates           | Walter Santiago | San Francisco        |
   | Gerudo Valley                  | Lorena          | Boston               |
   | Tendo Garden                   | Lorena          | Boston               |
   | Lasas S.A.                     | Mariano         | Madrid               |
   | Beragua                        | Emmanuel        | Barcelona            |
   | Club Golf Puerta del hierro    | Emmanuel        | Barcelona            |
   | Naturagua                      | Emmanuel        | Barcelona            |
   | DaraDistribuciones             | Emmanuel        | Barcelona            |
   | Madrileña de riegos            | Emmanuel        | Barcelona            |
   | Lasas S.A.                     | Mariano         | Madrid               |
   | Camunas Jardines S.L.          | Mariano         | Madrid               |
   | Dardena S.A.                   | Mariano         | Madrid               |
   | Jardin de Flores               | Julian          | Sydney               |
   | Flores Marivi                  | Felipe          | Talavera de la Reina |
   | Flowers, S.A                   | Felipe          | Talavera de la Reina |
   | Naturajardin                   | Julian          | Sydney               |
   | Golf S.A.                      | José Manuel     | Barcelona            |
   | Americh Golf Management SL     | José Manuel     | Barcelona            |
   | Aloha                          | José Manuel     | Barcelona            |
   | El Prat                        | José Manuel     | Barcelona            |
   | Sotogrande                     | José Manuel     | Barcelona            |
   | Vivero Humanes                 | Julian          | Sydney               |
   | Fuenla City                    | Felipe          | Talavera de la Reina |
   | Jardines y Mansiones Cactus SL | Lucio           | Madrid               |
   | Jardinerías Matías SL          | Lucio           | Madrid               |
   | Agrojardin                     | Julian          | Sydney               |
   | Top Campo                      | Felipe          | Talavera de la Reina |
   | Jardineria Sara                | Felipe          | Talavera de la Reina |
   | Campohermoso                   | Julian          | Sydney               |
   | france telecom                 | Lionel          | Paris                |
   | Musée du Louvre                | Lionel          | Paris                |
   | Tutifruti S.A                  | Mariko          | Sydney               |
   | Flores S.L.                    | Michael         | San Francisco        |
   | The Magic Garden               | Michael         | San Francisco        |
   | El Jardin Viviente S.L         | Mariko          | Sydney               |
   +--------------------------------+-----------------+----------------------+
   36 rows in set (0.00 sec)
   ```
   
8. Devuelve un listado con el nombre de los empleados junto con el nombre
   de sus jefes.

   ```sql
   SELECT
   	e.employee_first_name AS 'Empleado',
   	b.employee_first_name AS 'Jefe'
   FROM 
   	employee AS e
   INNER JOIN
   	employee AS b ON e.boss_id = b.employee_id;
   
   +-----------------+----------+
   | Empleado        | Jefe     |
   +-----------------+----------+
   | Ruben           | Marcos   |
   | Alberto         | Ruben    |
   | Maria           | Ruben    |
   | Felipe          | Alberto  |
   | Juan Carlos     | Alberto  |
   | Carlos          | Alberto  |
   | Mariano         | Carlos   |
   | Lucio           | Carlos   |
   | Hilario         | Carlos   |
   | Emmanuel        | Alberto  |
   | José Manuel     | Emmanuel |
   | David           | Emmanuel |
   | Oscar           | Emmanuel |
   | Francois        | Alberto  |
   | Lionel          | Francois |
   | Laurent         | Francois |
   | Michael         | Alberto  |
   | Walter Santiago | Michael  |
   | Hilary          | Alberto  |
   | Marcus          | Hilary   |
   | Lorena          | Hilary   |
   | Nei             | Alberto  |
   | Narumi          | Nei      |
   | Takuma          | Nei      |
   | Amy             | Alberto  |
   | Larry           | Amy      |
   | John            | Amy      |
   | Kevin           | Alberto  |
   | Julian          | Kevin    |
   | Mariko          | Kevin    |
   +-----------------+----------+
   ```
   
9. Devuelve un listado que muestre el nombre de cada empleados, el nombre
   de su jefe y el nombre del jefe de sus jefe.

   ```sql
   SELECT
   	e.employee_first_name AS 'Empleado',
   	b.employee_first_name AS 'Jefe',
   	b2.employee_first_name AS 'Jefe Superior'
   FROM 
   	employee AS e
   INNER JOIN
   	employee AS b ON e.boss_id = b.employee_id
   INNER JOIN
   	employee AS b2 ON b.boss_id = b2.employee_id;
   	
   +-----------------+----------+---------------+
   | Empleado        | Jefe     | Jefe Superior |
   +-----------------+----------+---------------+
   | Alberto         | Ruben    | Marcos        |
   | Maria           | Ruben    | Marcos        |
   | Felipe          | Alberto  | Ruben         |
   | Juan Carlos     | Alberto  | Ruben         |
   | Carlos          | Alberto  | Ruben         |
   | Mariano         | Carlos   | Alberto       |
   | Lucio           | Carlos   | Alberto       |
   | Hilario         | Carlos   | Alberto       |
   | Emmanuel        | Alberto  | Ruben         |
   | José Manuel     | Emmanuel | Alberto       |
   | David           | Emmanuel | Alberto       |
   | Oscar           | Emmanuel | Alberto       |
   | Francois        | Alberto  | Ruben         |
   | Lionel          | Francois | Alberto       |
   | Laurent         | Francois | Alberto       |
   | Michael         | Alberto  | Ruben         |
   | Walter Santiago | Michael  | Alberto       |
   | Hilary          | Alberto  | Ruben         |
   | Marcus          | Hilary   | Alberto       |
   | Lorena          | Hilary   | Alberto       |
   | Nei             | Alberto  | Ruben         |
   | Narumi          | Nei      | Alberto       |
   | Takuma          | Nei      | Alberto       |
   | Amy             | Alberto  | Ruben         |
   | Larry           | Amy      | Alberto       |
   | John            | Amy      | Alberto       |
   | Kevin           | Alberto  | Ruben         |
   | Julian          | Kevin    | Alberto       |
   | Mariko          | Kevin    | Alberto       |
   +-----------------+----------+---------------+
   29 rows in set (0.00 sec)
   ```
   
10. Devuelve el nombre de los clientes a los que no se les ha entregado a
    tiempo un pedido.

    ```sql
    SELECT DISTINCT 
    	c.customer_name 
    FROM 
    	`order` AS o 
    INNER JOIN
    	customer AS c ON c.customer_id = o.customer_id 
    WHERE 
    	o.date_waiting < o.date_deliver ;
    	
    +--------------------------------+
    | customer_name                  |
    +--------------------------------+
    | GoldFish Garden                |
    | Beragua                        |
    | Naturagua                      |
    | Gardening Associates           |
    | Camunas Jardines S.L.          |
    | Gerudo Valley                  |
    | Golf S.A.                      |
    | Sotogrande                     |
    | Jardines y Mansiones Cactus SL |
    | Dardena S.A.                   |
    | Jardinerías Matías SL          |
    | Tutifruti S.A                  |
    | Jardineria Sara                |
    | Flores S.L.                    |
    | El Jardin Viviente S.L         |
    +--------------------------------+
    15 rows in set (0.00 sec)
    ```
    
11. Devuelve un listado de las diferentes gamas de producto que ha comprado
    cada cliente.

    ```sql
    SELECT DISTINCT 
    	p.gama 
    FROM 
    	`order` AS o 
    INNER JOIN
    	customer AS c ON c.customer_id = o.customer_id 
    INNER JOIN 
    	order_detail AS od ON od.order_code = o.order_code 
    INNER JOIN 
    	product AS p ON p.product_code = od.product_code;
    	
    +--------------+
    | gama         |
    +--------------+
    | Frutales     |
    | Aromáticas   |
    | Ornamentales |
    | Herramientas |
    +--------------+
    4 rows in set (0.00 sec)
    ```
    
    

## Consultas multitabla (Composición externa)

Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, NATURAL
LEFT JOIN y NATURAL RIGHT JOIN.

1. Devuelve un listado que muestre solamente los clientes que no han
   realizado ningún pago.

   ```sql
   SELECT DISTINCT 
   	c.customer_name 
   FROM 
   	customer AS c
   LEFT JOIN
   	pay AS p ON p.customer_id = c.customer_id
   WHERE
   	p.customer_id IS NULL;
   	
   +-----------------------------+
   | customer_name               |
   +-----------------------------+
   | Lasas S.A.                  |
   | Club Golf Puerta del hierro |
   | DaraDistribuciones          |
   | Madrileña de riegos         |
   | Flowers, S.A                |
   | Naturajardin                |
   | Americh Golf Management SL  |
   | Aloha                       |
   | El Prat                     |
   | Vivero Humanes              |
   | Fuenla City                 |
   | Top Campo                   |
   | Campohermoso                |
   | france telecom              |
   | Musée du Louvre             |
   | Flores S.L.                 |
   | The Magic Garden            |
   +-----------------------------+
   17 rows in set (0.00 sec)
   ```
   
2. Devuelve un listado que muestre solamente los clientes que no han
   realizado ningún pedido.

   ```sql
   SELECT DISTINCT 
   	c.customer_name 
   FROM 
   	customer AS c
   LEFT JOIN
   	`order` AS o ON o.customer_id = c.customer_id
   WHERE
   	o.customer_id IS NULL;
   	
   +-----------------------------+
   | customer_name               |
   +-----------------------------+
   | Lasas S.A.                  |
   | Club Golf Puerta del hierro |
   | DaraDistribuciones          |
   | Madrileña de riegos         |
   | Flowers, S.A                |
   | Naturajardin                |
   | Americh Golf Management SL  |
   | Aloha                       |
   | El Prat                     |
   | Vivero Humanes              |
   | Fuenla City                 |
   | Top Campo                   |
   | Campohermoso                |
   | france telecom              |
   | Musée du Louvre             |
   | The Magic Garden            |
   +-----------------------------+
   16 rows in set (0.00 sec)
   ```
   
3. Devuelve un listado que muestre los clientes que no han realizado ningún
   pago y los que no han realizado ningún pedido.

   ```sql
   SELECT DISTINCT 
   	c.customer_name 
   FROM 
   	customer AS c
   LEFT JOIN
   	`order` AS o ON o.customer_id = c.customer_id
   LEFT JOIN
   	pay AS p ON p.customer_id = c.customer_id
   WHERE
   	o.customer_id IS NULL
   	AND 
   	p.customer_id IS NULL;
   	
   +-----------------------------+
   | customer_name               |
   +-----------------------------+
   | Lasas S.A.                  |
   | Club Golf Puerta del hierro |
   | DaraDistribuciones          |
   | Madrileña de riegos         |
   | Flowers, S.A                |
   | Naturajardin                |
   | Americh Golf Management SL  |
   | Aloha                       |
   | El Prat                     |
   | Vivero Humanes              |
   | Fuenla City                 |
   | Top Campo                   |
   | Campohermoso                |
   | france telecom              |
   | Musée du Louvre             |
   | The Magic Garden            |
   +-----------------------------+
   16 rows in set (0.00 sec)
   ```
   
4. Devuelve un listado que muestre solamente los empleados que no tienen
   una oficina asociada.

   ```sql
   SELECT
   	e.employee_first_name 
   FROM 
   	employee AS e
   WHERE 
   	e.office_id IS NULL;
   ```
   
5. Devuelve un listado que muestre solamente los empleados que no tienen un
   cliente asociado.

   ```sql
   SELECT
   	e.employee_first_name 
   FROM 
   	employee AS e
   LEFT JOIN
   	customer AS c ON c.employee_id  = e.employee_id 
   WHERE 
   	c.employee_id IS NULL;
   	
   +---------------------+
   | employee_first_name |
   +---------------------+
   | Marcos              |
   | Ruben               |
   | Alberto             |
   | Maria               |
   | Juan Carlos         |
   | Carlos              |
   | Hilario             |
   | David               |
   | Oscar               |
   | Francois            |
   | Laurent             |
   | Hilary              |
   | Marcus              |
   | Nei                 |
   | Narumi              |
   | Takuma              |
   | Amy                 |
   | Larry               |
   | John                |
   | Kevin               |
   +---------------------+
   20 rows in set (0.00 sec)
   ```
   
6. Devuelve un listado que muestre solamente los empleados que no tienen un
   cliente asociado junto con los datos de la oficina donde trabajan.

   ```sql
   SELECT 
   	ed.employee_first_name
   FROM 
   	employee_data AS ed
   WHERE 
   	ed.customer_name IS NULL;
   
   +---------------------+
   | employee_first_name |
   +---------------------+
   | Marcos              |
   | Ruben               |
   | Alberto             |
   | Maria               |
   | Juan Carlos         |
   | Carlos              |
   | Hilario             |
   | David               |
   | Oscar               |
   | Francois            |
   | Laurent             |
   | Hilary              |
   | Marcus              |
   | Nei                 |
   | Narumi              |
   | Takuma              |
   | Amy                 |
   | Larry               |
   | John                |
   | Kevin               |
   +---------------------+
   20 rows in set (0.00 sec)
   ```
   
7. Devuelve un listado que muestre los empleados que no tienen una oficina
   asociada y los que no tienen un cliente asociado.

   ```sql
   SELECT 
   	ed.employee_first_name
   FROM 
   	employee_data AS ed
   WHERE 
   	ed.customer_name IS NULL
   	AND
   	ed.office_id IS NULL
   	;
   ```
   
8. Devuelve un listado de los productos que nunca han aparecido en un
   pedido.

   ```sql
   SELECT
   	pd.product_name
   FROM 
   	products_data AS pd
   WHERE
   	pd.amount IS NULL;
   +-------------------------------------------------------------+
   | product_name                                                |
   +-------------------------------------------------------------+
   | Olea-Olivos                                                 |
   | Calamondin Mini                                             |
   | Camelia Blanco, Chrysler Rojo, Soraya Naranja,              |
   +-------------------------------------------------------------+
   107 rows in set (0.00 sec)
   ```
   
9. Devuelve un listado de los productos que nunca han aparecido en un
   pedido. El resultado debe mostrar el nombre, la descripción y la imagen del
   producto.

   ```sql
   SELECT
   	pd.product_name,
   	pd.Descripcion
   FROM 
   	products_data AS pd
   WHERE
   	pd.amount IS NULL;
   	
   +---------------------------------------------------------------------------+
   | product_name                                                              |
   +---------------------------------------------------------------------------+
   | Rhaphis Excelsa                                             | Descripcion |
   | Sabal Minor                                                 | Descripcion |
   | Trachycarpus Fortunei                                       | Descripcion |
   | Washingtonia Robusta                                        | Descripcion |
   | Zamia Furfuracaea                                           | Descripcion |
   +-------------------------------------------------------------+-------------+
   107 rows in set (0.00 sec)
   ```
   
10. Devuelve las oficinas donde no trabajan ninguno de los empleados que
    hayan sido los representantes de ventas de algún cliente que haya realizado
    la compra de algún producto de la gama Frutales.

    ```sql
    SELECT DISTINCT 
        e.office_id 
    FROM 
        order_detail AS od
    INNER JOIN
        product AS p ON p.product_code = od.product_code 
    INNER JOIN 
        `order` AS o ON o.order_code = od.order_code 
    INNER JOIN 
        customer AS c ON c.customer_id = o.customer_id 
    INNER JOIN 
        employee AS e ON e.employee_id = c.employee_id
    RIGHT JOIN 
        office AS o2 ON e.office_id = o2.office_id  
    WHERE 
        p.gama = 'Frutales';
        
    +-----------+
    | office_id |
    +-----------+
    | TAL-ES    |
    | MAD-ES    |
    | BCN-ES    |
    | SFC-USA   |
    | BOS-USA   |
    | SYD-AU    |
    +-----------+
    6 rows in set (0.00 sec)
    ```
    
11. Devuelve un listado con los clientes que han realizado algún pedido pero no
    han realizado ningún pago.

    ```sql
    SELECT DISTINCT 
    	c.customer_name 
    FROM 
    	customer AS c 
    INNER JOIN
    	`order` AS o ON o.customer_id = c.customer_id 
    LEFT JOIN 
    	pay AS p ON p.customer_id = c.customer_id 
    WHERE 
    	p.customer_id IS NULL;
    
    +---------------+
    | customer_name |
    +---------------+
    | Flores S.L.   |
    +---------------+
    1 row in set (0.00 sec)
    ```
    
12. Devuelve un listado con los datos de los empleados que no tienen clientes
    asociados y el nombre de su jefe asociado.

    ```sql
    SELECT 
    	e.employee_first_name AS 'Empleado',
    	e2.employee_first_name AS 'Jefe Nombre'
    FROM 
    	employee AS e
    LEFT JOIN
    	customer AS c ON c.employee_id = e.employee_id 
    INNER JOIN 
    	employee AS e2 ON e2.employee_id = e.boss_id
    WHERE 
    	c.employee_id IS NULL;
    	
    +-------------+-------------+
    | Empleado    | Jefe Nombre |
    +-------------+-------------+
    | Ruben       | Marcos      |
    | Alberto     | Ruben       |
    | Maria       | Ruben       |
    | Juan Carlos | Alberto     |
    | Carlos      | Alberto     |
    | Hilario     | Carlos      |
    | David       | Emmanuel    |
    | Oscar       | Emmanuel    |
    | Francois    | Alberto     |
    | Laurent     | Francois    |
    | Hilary      | Alberto     |
    | Marcus      | Hilary      |
    | Nei         | Alberto     |
    | Narumi      | Nei         |
    | Takuma      | Nei         |
    | Amy         | Alberto     |
    | Larry       | Amy         |
    | John        | Amy         |
    | Kevin       | Alberto     |
    +-------------+-------------+
    19 rows in set (0.00 sec)
    ```



## Consultas resumen

1. ¿Cuántos empleados hay en la compañía?

   ```sql
   SELECT 
   	COUNT(e.employee_id) AS 'Total Empleados'
   FROM
   	employee AS e 
   	
   +-----------------+
   | Total Empleados |
   +-----------------+
   |              31 |
   +-----------------+
   1 row in set (0.00 sec)
   ```

2. ¿Cuántos clientes tiene cada país?

   ```sql
   SELECT
   	ec.country_name,
   	ec.Total_Clientes
   FROM
   	employee_country AS ec
   ORDER BY
   	ec.country_name ASC;
   	
   +----------------+----------------+
   | country_name   | Total_Clientes |
   +----------------+----------------+
   | Australia      |              2 |
   | EEUU           |              1 |
   | España         |             24 |
   | Inglaterra     |              2 |
   | Spain          |              3 |
   | United Kingdom |              1 |
   | USA            |              3 |
   +----------------+----------------+
   7 rows in set (0.00 sec)
   ```

3. ¿Cuál fue el pago medio en 2009?

   ```sql
   SELECT 
   	AVG(p.total) AS 'pago_medio_2009'
   FROM 
   	pay AS p
   WHERE 
   	YEAR(p.date_pay) = '2009';
   	
   +-----------------+
   | pago_medio_2009 |
   +-----------------+
   |       4504.0769 |
   +-----------------+
   1 row in set (0.00 sec)
   ```

4. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma
   descendente por el número de pedidos.

   ```sql
   SELECT 
   	o.status, 
   	count(o.order_code) AS 'Numero_Pedidos' 
   FROM 
   	`order` AS o
   GROUP BY
   	o.status 
   ORDER BY
   	Numero_Pedidos DESC;
   	
   +-----------+----------------+
   | status    | Numero_Pedidos |
   +-----------+----------------+
   | Entregado |             61 |
   | Pendiente |             30 |
   | Rechazado |             24 |
   +-----------+----------------+
   3 rows in set (0.00 sec)	
   ```
   
5. Calcula el precio de venta del producto más caro y más barato en una
   misma consulta.

   ```sql
   SELECT 
   	MAX(p.price_sell) AS precio_mayor, 
   	MIN(p.price_sell) AS precio_menor
   FROM 
   	product AS p;
   	
   +--------------+--------------+
   | precio_mayor | precio_menor |
   +--------------+--------------+
   |          462 |            1 |
   +--------------+--------------+
   1 row in set (0.00 sec)
   ```
   
6. Calcula el número de clientes que tiene la empresa.

   ```sql
   SELECT 
   	COUNT(c.customer_id) AS 'Total Clientes'
   FROM
   	customer AS c
   	
   +----------------+
   | Total Clientes |
   +----------------+
   |             36 |
   +----------------+
   1 row in set (0.00 sec)
   ```

7. ¿Cuántos clientes existen con domicilio en la ciudad de Madrid?

   ```sql
   SELECT 
   	cy.city_name,
   	COUNT(c.customer_id) AS 'Total Clientes'
   FROM
   	customer AS c
   INNER JOIN
   	address AS a ON a.customer_id = c.customer_id
   INNER JOIN 
   	city AS cy ON cy.city_id = a.city_id
   WHERE 
   	cy.city_name LIKE '%Madrid%'
   GROUP BY 
   	cy.city_name;
   	
   +-----------+----------------+
   | city_name | Total Clientes |
   +-----------+----------------+
   | Madrid    |             11 |
   +-----------+----------------+
   1 row in set (0.00 sec)
   ```

8. ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan
   por M?

   ```sql
   SELECT 
   	cy.city_name,
   	COUNT(c.customer_id) AS 'Total Clientes'
   FROM
   	customer AS c
   INNER JOIN
   	address AS a ON a.customer_id = c.customer_id
   INNER JOIN 
   	city AS cy ON cy.city_id = a.city_id
   WHERE 
   	cy.city_name LIKE 'M%'
   GROUP BY 
   	cy.city_name;
   	
   +----------------------+----------------+
   | city_name            | Total Clientes |
   +----------------------+----------------+
   | Madrid               |             11 |
   | Miami                |              2 |
   | Montornes del valles |              1 |
   +----------------------+----------------+
   3 rows in set (0.00 sec)
   ```
   
9. Devuelve el nombre de los representantes de ventas y el número de clientes
   al que atiende cada uno.

   ```sql
   SELECT 
   	Empleado,
   	Clientes
   FROM
   	employee_customer_count;
   	
   +-----------------+----------+
   | Empleado        | Clientes |
   +-----------------+----------+
   | Felipe          |        5 |
   | Mariano         |        4 |
   | Lucio           |        2 |
   | Emmanuel        |        5 |
   | José Manuel     |        5 |
   | Lionel          |        2 |
   | Michael         |        2 |
   | Walter Santiago |        2 |
   | Lorena          |        2 |
   | Julian          |        5 |
   | Mariko          |        2 |
   +-----------------+----------+
   11 rows in set (0,00 sec)
   ```
   
10. Calcula el número de clientes que no tiene asignado representante de
    ventas.

    ```sql
    SELECT 
    	((SELECT 
    		COUNT(c.customer_id)
    	FROM
    		customer AS c) - COUNT(clientes)) AS 'Clientes Sin Representante'
    FROM 
    	employee_customer_count;
    	
    +----------------------------+
    | Clientes Sin Representante |
    +----------------------------+
    |                         25 |
    +----------------------------+
    1 row in set (0,00 sec)
    
    ```
    
11. Calcula la fecha del primer y último pago realizado por cada uno de los
    clientes. El listado deberá mostrar el nombre y los apellidos de cada cliente.

    ```sql
    SELECT
    	c.customer_name,
    	MIN(p.date_pay) AS 'Primer_Pago',
    	Max(p.date_pay) AS 'Ultimo Pago'
    FROM 
    	customer AS c
    INNER JOIN 
    	pay AS p ON p.customer_id = c.customer_id
    GROUP BY
    	c.customer_name;
    	
    +--------------------------------+-------------+-------------+
    | customer_name                  | Primer_Pago | Ultimo Pago |
    +--------------------------------+-------------+-------------+
    | GoldFish Garden                | 2008-11-10  | 2008-12-10  |
    | Gardening Associates           | 2009-01-16  | 2009-02-19  |
    | Gerudo Valley                  | 2007-01-08  | 2007-01-08  |
    | Tendo Garden                   | 2006-01-18  | 2006-01-18  |
    | Beragua                        | 2009-01-13  | 2009-01-13  |
    | Naturagua                      | 2009-01-06  | 2009-01-06  |
    | Camunas Jardines S.L.          | 2008-08-04  | 2008-08-04  |
    | Dardena S.A.                   | 2008-07-15  | 2008-07-15  |
    | Jardin de Flores               | 2009-01-15  | 2009-02-15  |
    | Flores Marivi                  | 2009-02-16  | 2009-02-16  |
    | Golf S.A.                      | 2009-03-06  | 2009-03-06  |
    | Sotogrande                     | 2009-03-26  | 2009-03-26  |
    | Jardines y Mansiones Cactus SL | 2008-03-18  | 2008-03-18  |
    | Jardinerías Matías SL          | 2009-02-08  | 2009-02-08  |
    | Agrojardin                     | 2009-01-13  | 2009-01-13  |
    | Jardineria Sara                | 2009-01-16  | 2009-01-16  |
    | Tutifruti S.A                  | 2007-10-06  | 2007-10-06  |
    | El Jardin Viviente S.L         | 2006-05-26  | 2006-05-26  |
    +--------------------------------+-------------+-------------+
    18 rows in set (0,00 sec)
    
    ```
    
12. Calcula el número de productos diferentes que hay en cada uno de los
    pedidos.

    ```sql
    SELECT 
    	o.order_code, 
    	COUNT(DISTINCT od.product_code) AS productos_diferentes
    FROM 
    	`order` AS o
    LEFT JOIN order_detail AS od ON o.order_code = od.order_code
    
    GROUP BY 
    	o.order_code;
    +------------+----------------------+
    | order_code | productos_diferentes |
    +------------+----------------------+	
    |        127 |                    1 |
    |        128 |                    2 |
    +------------+----------------------+
    115 rows in set (0,01 sec)
    
    ```
    
13. Calcula la suma de la cantidad total de todos los productos que aparecen en
    cada uno de los pedidos.

    ```sql
    SELECT 
    	o.order_code, SUM(od.amount) AS cantidad_total
    FROM 
    	`order` AS o
    LEFT JOIN order_detail AS od ON o.order_code  = od.order_code
    GROUP BY 
    	o.order_code;
    +------------+----------------+
    | order_code | cantidad_total |
    +------------+----------------+
    |          1 |            113 |
    |        127 |             10 |
    |        128 |             33 |
    +------------+----------------+
    115 rows in set (0,00 sec)
    
    ```
    
14. Devuelve un listado de los 20 productos más vendidos y el número total de
    unidades que se han vendido de cada uno. El listado deberá estar ordenado
    por el número total de unidades vendidas.

    ```sql
    SELECT 
    	p.product_name, SUM(od.amount) AS total_unidades_vendidas
    FROM 
    	product AS p
    LEFT JOIN 
    	order_detail AS od ON p.product_code  = od.product_code
    GROUP BY 
    	p.product_name
    ORDER BY 
    	total_unidades_vendidas DESC
    LIMIT 20;
    
    +-----------------------------------------------+-------------------------+
    | product_name                                  | total_unidades_vendidas |
    +-----------------------------------------------+-------------------------+
    | Thymus Vulgaris                               |                     961 |
    | Limonero 30/40                                |                     131 |
    | Nectarina                                     |                     130 |
    | Lavándula Dentata                             |                     128 |
    | Nerium oleander ARBOL Calibre 8/10            |                     127 |
    +-----------------------------------------------+-------------------------+
    20 rows in set (0,00 sec)
    
    ```
    
15. La facturación que ha tenido la empresa en toda la historia, indicando la
    base imponible, el IVA y el total facturado. La base imponible se calcula
    sumando el coste del producto por el número de unidades vendidas de la
    tabla detalle_pedido. El IVA es el 21 % de la base imponible, y el total la
    suma de los dos campos anteriores.

    ```sql
    SELECT 
        SUM(od.price_unit  * od.amount) AS base_imponible,
        SUM(od.price_unit * od.amount) * 0.21 AS iva,
        SUM(od.price_unit * od.amount) + (SUM(od.price_unit * od.amount) * 0.21) AS total_facturado
    FROM order_detail AS od;
    
    +----------------+----------+-----------------+
    | base_imponible | iva      | total_facturado |
    +----------------+----------+-----------------+
    |         217738 | 45724.98 |       263462.98 |
    +----------------+----------+-----------------+
    1 row in set (0,00 sec)
    
    ```
    
16. La misma información que en la pregunta anterior, pero agrupada por
    código de producto.

    ```sql
    SELECT 
    	p.product_code,
        SUM(od.price_unit  * od.amount) AS base_imponible,
        SUM(od.price_unit * od.amount) * 0.21 AS iva,
        SUM(od.price_unit * od.amount) + (SUM(od.price_unit * od.amount) * 0.21) AS total_facturado
    FROM 
    	order_detail AS od
    INNER JOIN
    	product AS p ON p.product_code = od.product_code 
    GROUP BY 
    	p.product_code;
    
    +--------------+----------------+----------+-----------------+
    | product_code | base_imponible | iva      | total_facturado |
    +--------------+----------------+----------+-----------------+
    | 11679        |            630 |   132.30 |          762.30 |
    | 21636        |            564 |   118.44 |          682.44 |
    | 22225        |            996 |   209.16 |         1205.16 |
    | OR-243       |            128 |    26.88 |          154.88 |
    | OR-247       |          73510 | 15437.10 |        88947.10 |
    | OR-249       |            150 |    31.50 |          181.50 |
    | OR-250       |             30 |     6.30 |           36.30 |
    | OR-99        |            517 |   108.57 |          625.57 |
    +--------------+----------------+----------+-----------------+
    147 rows in set (0,00 sec)
    
    	
    ```
    
17. La misma información que en la pregunta anterior, pero agrupada por
    código de producto filtrada por los códigos que empiecen por OR.

    ```sql
    SELECT 
    	p.product_code,
        SUM(od.price_unit  * od.amount) AS base_imponible,
        SUM(od.price_unit * od.amount) * 0.21 AS iva,
        SUM(od.price_unit * od.amount) + (SUM(od.price_unit * od.amount) * 0.21) AS total_facturado
    FROM 
    	order_detail AS od
    INNER JOIN
    	product AS p ON p.product_code = od.product_code 
    WHERE 
    	p.product_code LIKE 'OR%'
    GROUP BY 
    	p.product_code;
    +--------------+----------------+----------+-----------------+
    | product_code | base_imponible | iva      | total_facturado |
    +--------------+----------------+----------+-----------------+
    | OR-236       |           2205 |   463.05 |         2668.05 |
    | OR-237       |            950 |   199.50 |         1149.50 |
    | OR-240       |            468 |    98.28 |          566.28 |
    | OR-241       |            485 |   101.85 |          586.85 |
    | OR-243       |            128 |    26.88 |          154.88 |
    | OR-247       |          73510 | 15437.10 |        88947.10 |
    | OR-249       |            150 |    31.50 |          181.50 |
    | OR-250       |             30 |     6.30 |           36.30 |
    | OR-99        |            517 |   108.57 |          625.57 |
    +--------------+----------------+----------+-----------------+
    67 rows in set (0,00 sec)
    
    ```
    
18. Lista las ventas totales de los productos que hayan facturado más de 3000
    euros. Se mostrará el nombre, unidades vendidas, total facturado y total
    facturado con impuestos (21% IVA).

    ```sql
    SELECT 
        p.product_name,
        SUM(od.amount) AS unidades_vendidas,
        SUM(od.price_unit  * od.amount) AS total_facturado,
        (SUM(od.price_unit * od.amount) + (SUM(od.price_unit * od.amount) * 0.21)) AS total_con_iva
    FROM order_detail AS od
    LEFT JOIN product AS p ON od.product_code = p.product_code
    GROUP BY p.product_name
    HAVING total_facturado > 3000;
    
    +---------------------------+------+-------+---------------+
    | product_name              | uv   | tf    | total_con_iva |
    +---------------------------+------+-------+---------------+
    | Limonero 30/40            |  131 | 13092 |      15841.32 |
    | Cerezo                    |  316 | 22216 |      26881.36 |
    | Kaki                      |   87 |  5463 |       6610.23 |
    | Camelia japonica ejemplar |   32 |  3237 |       3916.77 |
    | Beucarnea Recurvata       |  150 |  7250 |       8772.50 |
    | Bismarckia Nobilis        |   35 |  9310 |      11265.10 |
    | Chamaerops Humilis        |  335 | 16514 |      19981.94 |
    | Dracaena Drago            |   55 |  3520 |       4259.20 |
    | Trachycarpus Fortunei     |  279 | 73510 |      88947.10 |
    +---------------------------+------+-------+---------------+
    9 rows in set (0,00 sec)
    
    ```
    
19. Muestre la suma total de todos los pagos que se realizaron para cada uno
    de los años que aparecen en la tabla pagos.

    ```sql
    SELECT 
    	YEAR(p.date_pay) AS year, 
    	SUM(total) AS total_pagos
    FROM pay AS p
    GROUP BY YEAR(p.date_pay);
    
    +------+-------------+
    | year | total_pagos |
    +------+-------------+
    | 2008 |       29252 |
    | 2009 |       58553 |
    | 2007 |       85170 |
    | 2006 |       24965 |
    +------+-------------+
    4 rows in set (0,00 sec)
    
    ```



## Subconsultas

##### Con operadores básicos de comparación

1. Devuelve el nombre del cliente con mayor límite de crédito.

   ```sql
   SELECT 
   	c.customer_name 
   FROM
   	customer AS c
   WHERE 
   	c.credit_limit = (
   		SELECT 
   			MAX(credit_limit)
   		FROM 
   			customer);
   			
   +---------------+
   | customer_name |
   +---------------+
   | Tendo Garden  |
   +---------------+
   1 row in set (0,00 sec)
   
   ```

2. Devuelve el nombre del producto que tenga el precio de venta más caro.

   ```sql
   SELECT
   	p.product_name,
   	p.price_sell
   FROM 
   	product_info_sell AS p
   ORDER BY
   	p.price_sell DESC
   LIMIT 1;
   
   +-----------------------+------------+
   | product_name          | price_sell |
   +-----------------------+------------+
   | Trachycarpus Fortunei |        462 |
   +-----------------------+------------+
   1 row in set (0,00 sec)
   
   ```

3. Devuelve el nombre del producto del que se han vendido más unidades.
   (Tenga en cuenta que tendrá que calcular cuál es el número total de
   unidades que se han vendido de cada producto a partir de los datos de la
   tabla detalle_pedido)

   ```sql
   SELECT
   	p.product_name,
   	p.UV
   FROM 
   	product_info_sell AS p
   ORDER BY
   	p.UV DESC
   LIMIT 1;
   +--------------+----+
   | product_name | UV |
   +--------------+----+
   | Cerezo       | 28 |
   +--------------+----+
   1 row in set (0,01 sec)
   
   ```
   
4. Los clientes cuyo límite de crédito sea mayor que los pagos que haya
   realizado. (Sin utilizar INNER JOIN).

   ```sql
   SELECT 
   	c.customer_name
   FROM
   	customer AS c
   WHERE 
   	c.credit_limit > (
   		SELECT 
   			COUNT(p.total)
   		FROM 
   			pay AS p
   		WHERE 
   			c.customer_id  = p.customer_id);
   
   +--------------------------------+
   | customer_name                  |
   +--------------------------------+
   | GoldFish Garden                |
   | Gardening Associates           |
   | Gerudo Valley                  |
   | Tendo Garden                   |
   | Lasas S.A.                     |
   | Beragua                        |
   | Club Golf Puerta del hierro    |
   | Naturagua                      |
   | Sotogrande                     |
   | Vivero Humanes                 |
   | Fuenla City                    |
   | Jardines y Mansiones Cactus SL |
   | Jardinerías Matías SL          |
   | Agrojardin                     |
   | Top Campo                      |
   | Jardineria Sara                |
   | Campohermoso                   |
   | france telecom                 |
   | Musée du Louvre                |
   | Tutifruti S.A                  |
   | Flores S.L.                    |
   | The Magic Garden               |
   | El Jardin Viviente S.L         |
   +--------------------------------+
   36 rows in set (0,00 sec)
   
   ```
   
5. Devuelve el producto que más unidades tiene en stock.

   ```sql
   SELECT
   	p.product_name,
   	p.stock_amount
   FROM 
   	product_info_sell AS p
   ORDER BY
   	p.stock_amount DESC
   LIMIT 1;
   
   +---------------------+--------------+
   | product_name        | stock_amount |
   +---------------------+--------------+
   | Kaki Rojo Brillante |          400 |
   +---------------------+--------------+
   1 row in set (0,00 sec)
   
   ```

6. Devuelve el producto que menos unidades tiene en stock.

   ```sql
   SELECT
   	p.product_name,
   	p.stock_amount
   FROM 
   	product_info_sell AS p
   ORDER BY
   	p.stock_amount ASC
   LIMIT 1;
   
   +---------------+--------------+
   | product_name  | stock_amount |
   +---------------+--------------+
   | Brahea Armata |            0 |
   +---------------+--------------+
   1 row in set (0,00 sec)
   ```

7. Devuelve el nombre, los apellidos y el email de los empleados que están a
   cargo de Alberto Soria.

   ```sql
   SELECT 
   	e.employee_first_name,
   	e.employee_first_surname,
   	e.employee_email 
   FROM 
   	employee AS e
   WHERE
   	e.boss_id = (
   		SELECT
   			e2.employee_id
   		FROM
   			employee AS e2 
   		WHERE 
   			e2.employee_first_name = 'Alberto'
   			AND 
   			e2.employee_first_surname = 'Soria'
   	);
   	
   +---------------------+------------------------+---------------------------+
   | employee_first_name | employee_first_surname | employee_email            |
   +---------------------+------------------------+---------------------------+
   | Felipe              | Rosas                  | frosas@jardineria.es      |
   | Juan Carlos         | Ortiz                  | cortiz@jardineria.es      |
   | Carlos              | Soria                  | csoria@jardineria.es      |
   | Emmanuel            | Magaña                 | manu@jardineria.es        |
   | Francois            | Fignon                 | ffignon@gardening.com     |
   | Michael             | Bolton                 | mbolton@gardening.com     |
   | Hilary              | Washington             | hwashington@gardening.com |
   | Nei                 | Nishikori              | nnishikori@gardening.com  |
   | Amy                 | Johnson                | ajohnson@gardening.com    |
   | Kevin               | Fallmer                | kfalmer@gardening.com     |
   +---------------------+------------------------+---------------------------+
   10 rows in set (0,00 sec)
   ```

##### **Subconsultas con ALL y ANY**

8. Devuelve el nombre del cliente con mayor límite de crédito.

   ```sql
   SELECT 
   	c.customer_name
   FROM 
   	customer AS c
   WHERE c.credit_limit >= ALL  (
   	SELECT c2.credit_limit
       FROM customer AS c2
   );
   
   +---------------+
   | customer_name |
   +---------------+
   | Tendo Garden  |
   +---------------+
   1 row in set (0,00 sec)
   
   
   ```

9. Devuelve el nombre del producto que tenga el precio de venta más caro.

   ```sql
   SELECT 
   	p.product_name 
   FROM 
   	product AS p 
   WHERE p.price_sell >= ALL (
   	SELECT p2.price_sell
       FROM product AS p2
   );
   
   +-----------------------+
   | product_name          |
   +-----------------------+
   | Trachycarpus Fortunei |
   +-----------------------+
   1 row in set (0,00 sec)
   
   ```

10. Devuelve el producto que menos unidades tiene en stock.

    ```sql
    SELECT 
    	p.product_name 
    FROM 
    	product AS p
    WHERE p.stock_amount <= ALL (
    	SELECT p2.stock_amount
        FROM product AS p2
    );
    
    +---------------+
    | product_name  |
    +---------------+
    | Brahea Armata |
    +---------------+
    1 row in set (0,00 sec)
    
    
    ```

##### Subconsultas con IN y NOT IN

11. Devuelve el nombre, apellido1 y cargo de los empleados que no
    representen a ningún cliente.

    ```sql
    SELECT Empleado, rol FROM employee_not_customers;
    
    +-------------------+-----------------------+
    | Empleado          | rol                   |
    +-------------------+-----------------------+
    | Marcos Magaña     | Director General      |
    | Ruben López       | Subdirector Marketing |
    | Alberto Soria     | Subdirector Ventas    |
    | Maria Solís       | Secretaria            |
    | Juan Carlos Ortiz | Representante Ventas  |
    | Hilario Rodriguez | Representante Ventas  |
    | David Palma       | Representante Ventas  |
    | Oscar Palma       | Representante Ventas  |
    | Laurent Serra     | Representante Ventas  |
    | Marcus Paxton     | Representante Ventas  |
    | Narumi Riko       | Representante Ventas  |
    | Takuma Nomura     | Representante Ventas  |
    | Larry Westfalls   | Representante Ventas  |
    | John Walton       | Representante Ventas  |
    | Carlos Soria      | Director Oficina      |
    | Francois Fignon   | Director Oficina      |
    | Hilary Washington | Director Oficina      |
    | Nei Nishikori     | Director Oficina      |
    | Amy Johnson       | Director Oficina      |
    | Kevin Fallmer     | Director Oficina      |
    +-------------------+-----------------------+
    20 rows in set (0,00 sec)
    
    ```
    
12. Devuelve un listado que muestre solamente los clientes que no han
    realizado ningún pago.

    ```sql
    SELECT 
    	c.customer_name 
    FROM 
    	customer AS c
    WHERE 
    	c.customer_id NOT IN (
    		SELECT 
    			p.customer_id
    		FROM 
    			pay AS P
    		
    	);
    	
    +-----------------------------+
    | customer_name               |
    +-----------------------------+
    | Lasas S.A.                  |
    | Club Golf Puerta del hierro |
    | DaraDistribuciones          |
    | Madrileña de riegos         |
    | Lasas S.A.                  |
    | Flowers, S.A                |
    | Naturajardin                |
    | Americh Golf Management SL  |
    | Aloha                       |
    | El Prat                     |
    | Vivero Humanes              |
    | Fuenla City                 |
    | Top Campo                   |
    | Campohermoso                |
    | france telecom              |
    | Musée du Louvre             |
    | Flores S.L.                 |
    | The Magic Garden            |
    +-----------------------------+
    18 rows in set (0.00 sec)
    ```
    
13. Devuelve un listado que muestre solamente los clientes que sí han realizado
    algún pago.

    ```sql
    SELECT 
    	c.customer_name 
    FROM 
    	customer AS c
    WHERE 
    	c.customer_id IN (
    		SELECT 
    			p.customer_id
    		FROM 
    			pay AS P
    		
    	);
    	
    +--------------------------------+
    | customer_name                  |
    +--------------------------------+
    | GoldFish Garden                |
    | Gardening Associates           |
    | Gerudo Valley                  |
    | Tendo Garden                   |
    | Beragua                        |
    | Naturagua                      |
    | Camunas Jardines S.L.          |
    | Dardena S.A.                   |
    | Jardin de Flores               |
    | Flores Marivi                  |
    | Golf S.A.                      |
    | Sotogrande                     |
    | Jardines y Mansiones Cactus SL |
    | Jardinerías Matías SL          |
    | Agrojardin                     |
    | Jardineria Sara                |
    | Tutifruti S.A                  |
    | El Jardin Viviente S.L         |
    +--------------------------------+
    18 rows in set (0.00 sec)
    ```
    
14. Devuelve un listado de los productos que nunca han aparecido en un
    pedido.

    ```sql
    SELECT DISTINCT 
    	p.product_name 
    FROM
    	product AS p 
    WHERE 
    	p.product_code NOT IN(
    		SELECT 
    			od.product_code
    		FROM 
    			order_detail AS od 
    		
    	);
    	
    +-------------------------------------------------------------+
    | product_name                                                |
    +-------------------------------------------------------------+
    | Olea-Olivos                                                 |
    | Calamondin Mini                                             |
    | Chamaerops Humilis "Cerifera"                               |
    | Chrysalidocarpus Lutescens -ARECA                           |
    | Cordyline Australis -DRACAENA                               |
    | Cycas Revoluta                                              |
    | Dracaena Drago                                              |
    | Livistonia Decipiens                                        |
    | Rhaphis Excelsa                                             |
    | Sabal Minor                                                 |
    | Trachycarpus Fortunei                                       |
    | Washingtonia Robusta                                        |
    | Zamia Furfuracaea                                           |
    +-------------------------------------------------------------+
    107 rows in set (0.00 sec)
    ```
    
15. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos
    empleados que no sean representante de ventas de ningún cliente.

    ```sql
    SELECT 
        e.employee_first_name ,
        e.employee_first_surname last_name,
        r.rol_name
    FROM 
        employee AS e
    INNER JOIN 
        office AS o ON e.office_id = o.office_id
    INNER JOIN 
    	rol AS r ON r.rol_id = e.rol_id  
    WHERE 
        e.employee_id NOT IN (
            SELECT 
                DISTINCT employee_id 
            FROM 
                customer 
            WHERE 
                employee_id IS NOT NULL
        ) AND NOT
        r.rol_name = 'Representante Ventas'
        ;
        
    +---------------------+------------+-----------------------+
    | employee_first_name | last_name  | rol_name              |
    +---------------------+------------+-----------------------+
    | Marcos              | Magaña     | Director General      |
    | Ruben               | López      | Subdirector Marketing |
    | Alberto             | Soria      | Subdirector Ventas    |
    | Maria               | Solís      | Secretaria            |
    | Carlos              | Soria      | Director Oficina      |
    | Francois            | Fignon     | Director Oficina      |
    | Hilary              | Washington | Director Oficina      |
    | Nei                 | Nishikori  | Director Oficina      |
    | Amy                 | Johnson    | Director Oficina      |
    | Kevin               | Fallmer    | Director Oficina      |
    +---------------------+------------+-----------------------+
    10 rows in set (0.00 sec)
    ```
    
16. Devuelve las oficinas donde no trabajan ninguno de los empleados que
    hayan sido los representantes de ventas de algún cliente que haya realizado
    la compra de algún producto de la gama Frutales.

    ```sql
    SELECT 
        o.office_id
    FROM 
        office AS o
    WHERE 
        NOT EXISTS (
            SELECT 1
            FROM 
                employee AS e
            INNER JOIN 
                customer AS c ON e.employee_id = c.employee_id
            INNER JOIN 
                `order` AS ord ON c.customer_id = ord.customer_id
            INNER JOIN 
                order_detail AS od ON ord.order_code = od.order_code
            INNER JOIN 
                product AS p ON od.product_code = p.product_code
            WHERE 
                e.office_id = o.office_id
                AND p.gama = 'Frutales'
        );
        
    +-----------+
    | office_id |
    +-----------+
    | LON-UK    |
    | PAR-FR    |
    | TOK-JP    |
    +-----------+
    3 rows in set (0.00 sec)
    ```
    
17. Devuelve un listado con los clientes que han realizado algún pedido pero no
    han realizado ningún pago.

    ```sql
    SELECT 
    	c.customer_name 
    FROM 
    	customer AS c
    WHERE 
    	c.customer_id NOT IN (
    		SELECT 
    			p.customer_id
    		FROM 
    			pay AS P
    		
    	);
    	
    +-----------------------------+
    | customer_name               |
    +-----------------------------+
    | Lasas S.A.                  |
    | Club Golf Puerta del hierro |
    | DaraDistribuciones          |
    | Madrileña de riegos         |
    | Lasas S.A.                  |
    | Flowers, S.A                |
    | Naturajardin                |
    | Americh Golf Management SL  |
    | Aloha                       |
    | El Prat                     |
    | Vivero Humanes              |
    | Fuenla City                 |
    | Top Campo                   |
    | Campohermoso                |
    | france telecom              |
    | Musée du Louvre             |
    | Flores S.L.                 |
    | The Magic Garden            |
    +-----------------------------+
    18 rows in set (0.00 sec)
    ```

##### **Subconsultas con EXISTS y NOT EXISTS**

18. Devuelve un listado que muestre solamente los clientes que no han
    realizado ningún pago.

    ```sql
    SELECT 
        c.customer_name 
    FROM 
        customer AS c
    WHERE 
        NOT EXISTS (
            SELECT 
                p.customer_id
            FROM 
                pay AS p
            WHERE
                p.customer_id = c.customer_id
        );
    	
    +-----------------------------+
    | customer_name               |
    +-----------------------------+
    | Lasas S.A.                  |
    | Club Golf Puerta del hierro |
    | DaraDistribuciones          |
    | Madrileña de riegos         |
    | Lasas S.A.                  |
    | Flowers, S.A                |
    | Naturajardin                |
    | Americh Golf Management SL  |
    | Aloha                       |
    | El Prat                     |
    | Vivero Humanes              |
    | Fuenla City                 |
    | Top Campo                   |
    | Campohermoso                |
    | france telecom              |
    | Musée du Louvre             |
    | Flores S.L.                 |
    | The Magic Garden            |
    +-----------------------------+
    18 rows in set (0.00 sec)
    ```
    
19. Devuelve un listado que muestre solamente los clientes que sí han realizado
    algún pago.

    ```sql
    SELECT 
        c.customer_name 
    FROM 
        customer AS c
    WHERE 
        EXISTS (
            SELECT 
                p.customer_id
            FROM 
                pay AS p
            WHERE
                p.customer_id = c.customer_id
        );
        
    +--------------------------------+
    | customer_name                  |
    +--------------------------------+
    | GoldFish Garden                |
    | Gardening Associates           |
    | Gerudo Valley                  |
    | Tendo Garden                   |
    | Beragua                        |
    | Naturagua                      |
    | Camunas Jardines S.L.          |
    | Dardena S.A.                   |
    | Jardin de Flores               |
    | Flores Marivi                  |
    | Golf S.A.                      |
    | Sotogrande                     |
    | Jardines y Mansiones Cactus SL |
    | Jardinerías Matías SL          |
    | Agrojardin                     |
    | Jardineria Sara                |
    | Tutifruti S.A                  |
    | El Jardin Viviente S.L         |
    +--------------------------------+
    18 rows in set (0.00 sec)
    ```
    
20. Devuelve un listado de los productos que nunca han aparecido en un
    pedido.

    ```sql
    SELECT product_code, product_name FROM show_products_nots;
    +--------------+-------------------------------------------------------------+
    | product_code | product_name                                                |
    +--------------+-------------------------------------------------------------+
    | OR-119       | Laurus Nobilis Arbusto - Ramificado Bajo                    |
    | OR-125       | Viburnum Tinus "Eve Price"                                  |
    | FR-16        | Calamondin Copa EXTRA Con FRUTA                             |
    | OR-200       | Juniperus horizontalis Wiltonii                             |
    | FR-78        | Higuera                                                     |
    | FR-80        | Higuera                                                     |
    | OR-146       | Bougamvillea Sanderiana Tutor                               |
    | OR-150       | Bougamvillea roja, naranja                                  |
    +--------------+-------------------------------------------------------------+
    147 rows in set (0.00 sec)
    ```
    
21. Devuelve un listado de los productos que han aparecido en un pedido
    alguna vez.

    ```sql
    SELECT product_code, product_name FROM show_products_yes;
    
    +--------------+-------------------------------------------------------------+
    | product_code | product_name                                                |
    +--------------+-------------------------------------------------------------+
    | OR-238       | Livistonia Decipiens                                        |
    | OR-239       | Livistonia Decipiens                                        |
    | OR-242       | Rhaphis Excelsa                                             |
    | OR-244       | Sabal Minor                                                 |
    | OR-245       | Sabal Minor                                                 |
    | OR-246       | Trachycarpus Fortunei                                       |
    | OR-248       | Washingtonia Robusta                                        |
    | OR-251       | Zamia Furfuracaea                                           |
    +--------------+-------------------------------------------------------------+
    129 rows in set (0.00 sec)
    ```

##### Subconsultas correlacionadas

#### Consultas variadas

1. Devuelve el listado de clientes indicando el nombre del cliente y cuántos
   pedidos ha realizado. Tenga en cuenta que pueden existir clientes que no
   han realizado ningún pedido.

   ```sql
   SELECT 
       c.customer_name , 
       c.customer_surname , 
       COUNT(o.order_code) AS pedidos_realizados
   FROM 
       customer AS c
   LEFT JOIN 
       `order` AS o ON o.customer_id  = c.customer_id 
   GROUP BY 
       c.customer_name, c.customer_surname;
       
    +--------------------------------+------------------+--------------------+
   | customer_name                  | customer_surname | pedidos_realizados |
   +--------------------------------+------------------+--------------------+
   | Vivero Humanes                 | NULL             |                  0 |
   | Fuenla City                    | NULL             |                  0 |
   | Jardines y Mansiones Cactus SL | NULL             |                  5 |
   | Jardinerías Matías SL          | NULL             |                  5 |
   | Agrojardin                     | NULL             |                  5 |
   | Top Campo                      | NULL             |                  0 |
   | Jardineria Sara                | NULL             |                 10 |
   | Campohermoso                   | NULL             |                  0 |
   | france telecom                 | NULL             |                  0 |
   | Musée du Louvre                | NULL             |                  0 |
   | Tutifruti S.A                  | NULL             |                  5 |
   | Flores S.L.                    | NULL             |                  5 |
   | The Magic Garden               | NULL             |                  0 |
   | El Jardin Viviente S.L         | NULL             |                  5 |
   +--------------------------------+------------------+--------------------+
   35 rows in set (0,00 sec)
     
   ```
   
2. Devuelve un listado con los nombres de los clientes y el total pagado por
   cada uno de ellos. Tenga en cuenta que pueden existir clientes que no han
   realizado ningún pago.

   ```sql
   SELECT 
       c.customer_name , 
       c.customer_surname , 
       COUNT(o.order_code) AS pedidos_realizados
   FROM 
       customer AS c
   LEFT JOIN 
       `order` AS o ON o.customer_id  = c.customer_id 
   GROUP BY 
       c.customer_name, c.customer_surname;
       
    +--------------------------------+------------------+--------------------+
   | customer_name                  | customer_surname | pedidos_realizados |
   +--------------------------------+------------------+--------------------+
   | Vivero Humanes                 | NULL             |                  0 |
   | Fuenla City                    | NULL             |                  0 |
   | Jardines y Mansiones Cactus SL | NULL             |                  5 |
   | Jardinerías Matías SL          | NULL             |                  5 |
   | Agrojardin                     | NULL             |                  5 |
   | Top Campo                      | NULL             |                  0 |
   | Jardineria Sara                | NULL             |                 10 |
   | Campohermoso                   | NULL             |                  0 |
   | france telecom                 | NULL             |                  0 |
   | Musée du Louvre                | NULL             |                  0 |
   | Tutifruti S.A                  | NULL             |                  5 |
   | Flores S.L.                    | NULL             |                  5 |
   | The Magic Garden               | NULL             |                  0 |
   | El Jardin Viviente S.L         | NULL             |                  5 |
   +--------------------------------+------------------+--------------------+
   35 rows in set (0,00 sec)
   ```
   
3. Devuelve el nombre de los clientes que hayan hecho pedidos en 2008
   ordenados alfabéticamente de menor a mayor.

   ```sql
   SELECT 
       c.customer_name , 
       c.customer_surname 
   FROM 
       customer AS c
   LEFT JOIN 
       `order` AS o ON o.customer_id = c.customer_id 
   WHERE 
       YEAR(o.date_order) = 2008
   ORDER BY 
       c.customer_name , 
       c.customer_surname;
       
   +--------------------------------+------------------+
   | customer_name                  | customer_surname |
   +--------------------------------+------------------+
   | Camunas Jardines S.L.          | NULL             |
   | GoldFish Garden                | NULL             |
   | GoldFish Garden                | NULL             |
   | GoldFish Garden                | NULL             |
   | Jardin de Flores               | NULL             |
   | Jardin de Flores               | NULL             |
   | Jardines y Mansiones Cactus SL | NULL             |
   | Jardines y Mansiones Cactus SL | NULL             |
   | Jardines y Mansiones Cactus SL | NULL             |
   | Jardines y Mansiones Cactus SL | NULL             |
   | Jardines y Mansiones Cactus SL | NULL             |
   | Tendo Garden                   | NULL             |
   | Tendo Garden                   | NULL             |
   | Tutifruti S.A                  | NULL             |
   | Tutifruti S.A                  | NULL             |
   | Tutifruti S.A                  | NULL             |
   +--------------------------------+------------------+
   34 rows in set (0,00 sec)
   
   ```
   
4. Devuelve el nombre del cliente, el nombre y primer apellido de su
   representante de ventas y el número de teléfono de la oficina del
   representante de ventas, de aquellos clientes que no hayan realizado ningún
   pago.

   ```sql
   SELECT 
   	eom.customer_name AS 'Cliente',
   	eom.employee_first_name AS 'Empleado',
   	eom.office_phone_number AS 'Officina Numero'
   FROM
   	employee_office_meta AS eom
   WHERE 
   	N_pagos = 0
   	AND 
   	eom.customer_name  IS NOT NULL
   	;
   
   +-----------------------------+--------------+-----------------+
   | Cliente                     | Empleado     | Officina Numero |
   +-----------------------------+--------------+-----------------+
   | Club Golf Puerta del hierro | Emmanuel     | +34 93 3561182  |
   | DaraDistribuciones          | Emmanuel     | +34 93 3561182  |
   | Madrileña de riegos         | Emmanuel     | +34 93 3561182  |
   | Americh Golf Management SL  | José Manuel  | +34 93 3561182  |
   | Aloha                       | José Manuel  | +34 93 3561182  |
   | El Prat                     | José Manuel  | +34 93 3561182  |
   | Lasas S.A.                  | Mariano      | +34 91 7514487  |
   | france telecom              | Lionel       | +33 14 723 4404 |
   | Musée du Louvre             | Lionel       | +33 14 723 4404 |
   | Flores S.L.                 | Michael      | +1 650 219 4782 |
   | The Magic Garden            | Michael      | +1 650 219 4782 |
   | Naturajardin                | Julian       | +61 2 9264 2451 |
   | Vivero Humanes              | Julian       | +61 2 9264 2451 |
   | Campohermoso                | Julian       | +61 2 9264 2451 |
   | Flowers, S.A                | Felipe       | +34 925 867231  |
   | Fuenla City                 | Felipe       | +34 925 867231  |
   | Top Campo                   | Felipe       | +34 925 867231  |
   +-----------------------------+--------------+-----------------+
   17 rows in set (0,01 sec)
   
   ```
   
5. Devuelve el listado de clientes donde aparezca el nombre del cliente, el
   nombre y primer apellido de su representante de ventas y la ciudad donde
   está su oficina.

   ```sql
   SELECT 
   	eom.customer_name AS 'Cliente',
   	CONCAT(eom.employee_first_name, ' ',
   	eom.employee_first_surname) AS 'Empleado',
   	eom.city_name AS 'Officina Numero'
   FROM
   	employee_office_meta AS eom
   WHERE 
   	eom.customer_name  IS NOT NULL
   	;
   	
   +--------------------------------+-------------------------+----------------------+
   | Cliente                        | Empleado                | Ciudad               |
   +--------------------------------+-------------------------+----------------------+
   | Beragua                        | Emmanuel Magaña         | Barcelona            |
   | Club Golf Puerta del hierro    | Emmanuel Magaña         | Barcelona            |
   | Naturagua                      | Emmanuel Magaña         | Barcelona            |
   | DaraDistribuciones             | Emmanuel Magaña         | Barcelona            |
   | Jardin de Flores               | Julian Bellinelli       | Sydney               |
   | Naturajardin                   | Julian Bellinelli       | Sydney               |
   | Vivero Humanes                 | Julian Bellinelli       | Sydney               |
   | Agrojardin                     | Julian Bellinelli       | Sydney               |
   | Campohermoso                   | Julian Bellinelli       | Sydney               |
   | Tutifruti S.A                  | Mariko Kishi            | Sydney               |
   | El Jardin Viviente S.L         | Mariko Kishi            | Sydney               |
   | Flores Marivi                  | Felipe Rosas            | Talavera de la Reina |
   | Flowers, S.A                   | Felipe Rosas            | Talavera de la Reina |
   | Fuenla City                    | Felipe Rosas            | Talavera de la Reina |
   | Top Campo                      | Felipe Rosas            | Talavera de la Reina |
   | Jardineria Sara                | Felipe Rosas            | Talavera de la Reina |
   +--------------------------------+-------------------------+----------------------+
   35 rows in set (0,00 sec)
   
   ```
   
6. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos
   empleados que no sean representante de ventas de ningún cliente.

   ```sql
   SELECT 
   	CONCAT(eom.employee_first_name, ' ',
   	eom.employee_first_surname) AS 'Empleado',
   	eom.rol_name AS 'rol',
   	eom.office_phone_number AS 'Numero'
   FROM
   	employee_office_meta AS eom
   WHERE 
   	eom.customer_name  IS NULL
   	;
   	
   +-------------------+-----------------------+-----------------+
   | Empleado          | rol                   | Numero          |
   +-------------------+-----------------------+-----------------+
   | David Palma       | Representante Ventas  | +34 93 3561182  |
   | Oscar Palma       | Representante Ventas  | +34 93 3561182  |
   | Hilary Washington | Director Oficina      | +1 215 837 0825 |
   | Marcus Paxton     | Representante Ventas  | +1 215 837 0825 |
   | Amy Johnson       | Director Oficina      | +44 20 78772041 |
   | Larry Westfalls   | Representante Ventas  | +44 20 78772041 |
   | John Walton       | Representante Ventas  | +44 20 78772041 |
   | Carlos Soria      | Director Oficina      | +34 91 7514487  |
   | Hilario Rodriguez | Representante Ventas  | +34 91 7514487  |
   | Francois Fignon   | Director Oficina      | +33 14 723 4404 |
   | Laurent Serra     | Representante Ventas  | +33 14 723 4404 |
   | Kevin Fallmer     | Director Oficina      | +61 2 9264 2451 |
   | Marcos Magaña     | Director General      | +34 925 867231  |
   | Ruben López       | Subdirector Marketing | +34 925 867231  |
   | Alberto Soria     | Subdirector Ventas    | +34 925 867231  |
   | Maria Solís       | Secretaria            | +34 925 867231  |
   | Juan Carlos Ortiz | Representante Ventas  | +34 925 867231  |
   | Nei Nishikori     | Director Oficina      | +81 33 224 5000 |
   | Narumi Riko       | Representante Ventas  | +81 33 224 5000 |
   | Takuma Nomura     | Representante Ventas  | +81 33 224 5000 |
   +-------------------+-----------------------+-----------------+
   20 rows in set (0,00 sec)
   
   ```
   
7. Devuelve un listado indicando todas las ciudades donde hay oficinas y el
   número de empleados que tiene.

   ```sql
   SELECT
   	cy.city_name AS ciudad_oficina, 
   	COUNT(c.customer_id) AS total_empleados
   FROM 
   	office AS o
   INNER JOIN 
   	city AS cy ON cy.city_id = o.city_id
   INNER JOIN 
   	employee AS e ON e.office_id = o.office_id 
   INNER JOIN 
   	customer AS c ON c.employee_id = e.employee_id 
   GROUP BY 
   	cy.city_name;
   
   +----------------------+-----------------+
   | ciudad_oficina       | total_empleados |
   +----------------------+-----------------+
   | Talavera de la Reina |               5 |
   | Madrid               |               6 |
   | Barcelona            |              10 |
   | Paris                |               2 |
   | San Francisco        |               4 |
   | Boston               |               2 |
   | Sydney               |               7 |
   +----------------------+-----------------+
   7 rows in set (0,01 sec)
   
   ```








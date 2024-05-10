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

-- PROCEDIMIENTO 

USE garden;

DROP PROCEDURE IF EXISTS add_provider_new_data;

DELIMITER $$

CREATE PROCEDURE add_provider_new_data(
    IN nombre VARCHAR(40),
    IN apellido VARCHAR(40)
)
BEGIN
   	DECLARE mensaje VARCHAR(100);
   	DECLARE last_id INT;
   
   	SELECT MAX(p.provider_id) INTO last_id FROM provider AS p;
   	
   	IF last_id IS NULL THEN
		SET last_id = 1;
	ELSE
		SET last_id = last_id + 1;
	END IF;
   
   	INSERT INTO provider(
   			provider_id,
			provider_name,
			provider_surname 
		) VALUES (
			last_id + 1,
			nombre, 
			apellido
	);

	IF ROW_COUNT() > 0 THEN
		SET mensaje = 'Se actualizó el registro correctamente.';
	ELSE
		SET mensaje = 'No se encontró ningún registro para actualizar.';
	END IF;

	SELECT mensaje AS Resultado;

END $$

DELIMITER ;

-- PROCEDIMIENTO 

USE garden;

DROP PROCEDURE IF EXISTS off_employee;

DELIMITER $$

CREATE PROCEDURE off_employee(
	IN id INT
)
BEGIN
   	DECLARE mensaje VARCHAR(100);
   	
   	UPDATE 
   		employee 
   	SET 
   		actived = 0
   	WHERE 
   		employee_id = id;

	IF ROW_COUNT() > 0 THEN
		SET mensaje = 'Se actualizó el registro correctamente.';
	ELSE
		SET mensaje = 'No se encontró ningún registro para actualizar.';
	END IF;

	SELECT mensaje AS Resultado;

END $$

DELIMITER ;


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
	COUNT(c.customer_id) AS 'Clientes'
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
	
-- Vista para facilitar las busquedas
USE garden;

DROP VIEW IF EXISTS office_city_info;

CREATE VIEW office_city_info AS
SELECT 
	o.office_id,
	c.city_name,
	o.office_phone_number,
	country_name
FROM 
	office AS o
INNER JOIN
	city AS c ON c.city_id = o.city_id
INNER JOIN
	region AS r ON c.region_id = r.region_id
INNER JOIN
	country AS co ON co.country_id = r.country_id;



USE garden;

-- Datos
CALL add_oficina ('BCN-ES','Barcelona','España','Barcelona','08019','+34 93 3561182','Avenida Diagonal, 38','3A escalera Derecha');
CALL add_oficina ('BOS-USA','Boston','EEUU','MA','02108','+1 215 837 0825','1550 Court Place','Suite 102');
CALL add_oficina ('LON-UK','Londres','Inglaterra','EMEA','EC2N 1HN','+44 20 78772041','52 Old Broad Street','Ground Floor');
CALL add_oficina ('MAD-ES','Madrid','España','Madrid','28032','+34 91 7514487','Bulevar Indalecio Prieto, 32','');
CALL add_oficina ('PAR-FR','Paris','Francia','EMEA','75017','+33 14 723 4404','29 Rue Jouffroy d''abbans','');
CALL add_oficina ('SFC-USA','San Francisco','EEUU','CA','94080','+1 650 219 4782','100 Market Street','Suite 300');
CALL add_oficina ('SYD-AU','Sydney','Australia','APAC','NSW 2010','+61 2 9264 2451','5-11 Wentworth Avenue','Floor #2');
CALL add_oficina ('TAL-ES','Talavera de la Reina','España','Castilla-LaMancha','45632','+34 925 867231','Francisco Aguirre, 32','5º piso (exterior)');
CALL add_oficina ('TOK-JP','Tokyo','Japón','Chiyoda-Ku','102-8578','+81 33 224 5000','4-1 Kioicho','');

CALL add_empleado (1,'Marcos','Magaña','Perez','3897','marcos@jardineria.es','TAL-ES',NULL,'Director General');
CALL add_empleado (2,'Ruben','López','Martinez','2899','rlopez@jardineria.es','TAL-ES',1,'Subdirector Marketing');
CALL add_empleado (3,'Alberto','Soria','Carrasco','2837','asoria@jardineria.es','TAL-ES',2,'Subdirector Ventas');
CALL add_empleado (4,'Maria','Solís','Jerez','2847','msolis@jardineria.es','TAL-ES',2,'Secretaria');
CALL add_empleado (5,'Felipe','Rosas','Marquez','2844','frosas@jardineria.es','TAL-ES',3,'Representante Ventas');
CALL add_empleado (6,'Juan Carlos','Ortiz','Serrano','2845','cortiz@jardineria.es','TAL-ES',3,'Representante Ventas');
CALL add_empleado (7,'Carlos','Soria','Jimenez','2444','csoria@jardineria.es','MAD-ES',3,'Director Oficina');
CALL add_empleado (8,'Mariano','López','Murcia','2442','mlopez@jardineria.es','MAD-ES',7,'Representante Ventas');
CALL add_empleado (9,'Lucio','Campoamor','Martín','2442','lcampoamor@jardineria.es','MAD-ES',7,'Representante Ventas');
CALL add_empleado (10,'Hilario','Rodriguez','Huertas','2444','hrodriguez@jardineria.es','MAD-ES',7,'Representante Ventas');
CALL add_empleado (11,'Emmanuel','Magaña','Perez','2518','manu@jardineria.es','BCN-ES',3,'Director Oficina');
CALL add_empleado (12,'José Manuel','Martinez','De la Osa','2519','jmmart@hotmail.es','BCN-ES',11,'Representante Ventas');
CALL add_empleado (13,'David','Palma','Aceituno','2519','dpalma@jardineria.es','BCN-ES',11,'Representante Ventas');
CALL add_empleado (14,'Oscar','Palma','Aceituno','2519','opalma@jardineria.es','BCN-ES',11,'Representante Ventas');
CALL add_empleado (15,'Francois','Fignon','','9981','ffignon@gardening.com','PAR-FR',3,'Director Oficina');
CALL add_empleado (16,'Lionel','Narvaez','','9982','lnarvaez@gardening.com','PAR-FR',15,'Representante Ventas');
CALL add_empleado (17,'Laurent','Serra','','9982','lserra@gardening.com','PAR-FR',15,'Representante Ventas');
CALL add_empleado (18,'Michael','Bolton','','7454','mbolton@gardening.com','SFC-USA',3,'Director Oficina');
CALL add_empleado (19,'Walter Santiago','Sanchez','Lopez','7454','wssanchez@gardening.com','SFC-USA',18,'Representante Ventas');
CALL add_empleado (20,'Hilary','Washington','','7565','hwashington@gardening.com','BOS-USA',3,'Director Oficina');
CALL add_empleado (21,'Marcus','Paxton','','7565','mpaxton@gardening.com','BOS-USA',20,'Representante Ventas');
CALL add_empleado (22,'Lorena','Paxton','','7665','lpaxton@gardening.com','BOS-USA',20,'Representante Ventas');
CALL add_empleado (23,'Nei','Nishikori','','8734','nnishikori@gardening.com','TOK-JP',3,'Director Oficina');
CALL add_empleado (24,'Narumi','Riko','','8734','nriko@gardening.com','TOK-JP',23,'Representante Ventas');
CALL add_empleado (25,'Takuma','Nomura','','8735','tnomura@gardening.com','TOK-JP',23,'Representante Ventas');
CALL add_empleado (26,'Amy','Johnson','','3321','ajohnson@gardening.com','LON-UK',3,'Director Oficina');
CALL add_empleado (27,'Larry','Westfalls','','3322','lwestfalls@gardening.com','LON-UK',26,'Representante Ventas');
CALL add_empleado (28,'John','Walton','','3322','jwalton@gardening.com','LON-UK',26,'Representante Ventas');
CALL add_empleado (29,'Kevin','Fallmer','','3210','kfalmer@gardening.com','SYD-AU',3,'Director Oficina');
CALL add_empleado (30,'Julian','Bellinelli','','3211','jbellinelli@gardening.com','SYD-AU',29,'Representante Ventas');
CALL add_empleado (31,'Mariko','Kishi','','3211','mkishi@gardening.com','SYD-AU',29,'Representante Ventas');

CALL add_gama_producto ('Herbaceas','Plantas para jardin decorativas',NULL,NULL);
CALL add_gama_producto ('Herramientas','Herramientas para todo tipo de acción',NULL,NULL);
CALL add_gama_producto ('Aromáticas','Plantas aromáticas',NULL,NULL);
CALL add_gama_producto ('Frutales','Árboles pequeños de producción frutal',NULL,NULL);
CALL add_gama_producto ('Ornamentales','Plantas vistosas para la decoración del jardín',NULL,NULL);

CALL add_cliente (1,'GoldFish Garden','Daniel G','GoldFish','5556901745','5556901746','False Street 52 2 A',NULL,'San Francisco',NULL,'USA','24006',19,3000);
CALL add_cliente (3,'Gardening Associates','Anne','Wright','5557410345','5557410346','Wall-e Avenue',NULL,'Miami','Miami','USA','24010',19,6000);
CALL add_cliente (4,'Gerudo Valley','Link','Flaute','5552323129','5552323128','Oaks Avenue nº22',NULL,'New York',NULL,'USA','85495',22,12000);
CALL add_cliente (5,'Tendo Garden','Akane','Tendo','55591233210','55591233211','Null Street nº69',NULL,'Miami',NULL,'USA','696969',22,600000);
CALL add_cliente (6,'Lasas S.A.','Antonio','Lasas','34916540145','34914851312','C/Leganes 15',NULL,'Fuenlabrada','Madrid','Spain','28945',8,154310);
CALL add_cliente (7,'Beragua','Jose','Bermejo','654987321','916549872','C/pintor segundo','Getafe','Madrid','Madrid','Spain','28942',11,20000);
CALL add_cliente (8,'Club Golf Puerta del hierro','Paco','Lopez','62456810','919535678','C/sinesio delgado','Madrid','Madrid','Madrid','Spain','28930',11,40000);
CALL add_cliente (9,'Naturagua','Guillermo','Rengifo','689234750','916428956','C/majadahonda','Boadilla','Madrid','Madrid','Spain','28947',11,32000);
CALL add_cliente (10,'DaraDistribuciones','David','Serrano','675598001','916421756','C/azores','Fuenlabrada','Madrid','Madrid','Spain','28946',11,50000);
CALL add_cliente (11,'Madrileña de riegos','Jose','Tacaño','655983045','916689215','C/Lagañas','Fuenlabrada','Madrid','Madrid','Spain','28943',11,20000);
CALL add_cliente (12,'Lasas S.A.','Antonio','Lasas','34916540145','34914851312','C/Leganes 15',NULL,'Fuenlabrada','Madrid','Spain','28945',8,154310);
CALL add_cliente (13,'Camunas Jardines S.L.','Pedro','Camunas','34914873241','34914871541','C/Virgenes 45','C/Princesas 2 1ºB','San Lorenzo del Escorial','Madrid','Spain','28145',8,16481);
CALL add_cliente (14,'Dardena S.A.','Juan','Rodriguez','34912453217','34912484764','C/Nueva York 74',NULL,'Madrid','Madrid','Spain','28003',8,321000);
CALL add_cliente (15,'Jardin de Flores','Javier','Villar','654865643','914538776','C/ Oña 34',NULL,'Madrid','Madrid','Spain','28950',30,40000);
CALL add_cliente (16,'Flores Marivi','Maria','Rodriguez','666555444','912458657','C/Leganes24',NULL,'Fuenlabrada','Madrid','Spain','28945',5,1500);
CALL add_cliente (17,'Flowers, S.A','Beatriz','Fernandez','698754159','978453216','C/Luis Salquillo4',NULL,'Montornes del valles','Barcelona','Spain','24586',5,3500);
CALL add_cliente (18,'Naturajardin','Victoria','Cruz','612343529','916548735','Plaza Magallón 15',NULL,'Madrid','Madrid','Spain','28011',30,5050);
CALL add_cliente (19,'Golf S.A.','Luis','Martinez','916458762','912354475','C/Estancado',NULL,'Santa cruz de Tenerife','Islas Canarias','Spain','38297',12,30000);
CALL add_cliente (20,'Americh Golf Management SL','Mario','Suarez','964493072','964493063','C/Letardo',NULL,'Barcelona','Cataluña','Spain','12320',12,20000);
CALL add_cliente (21,'Aloha','Cristian','Rodrigez','916485852','914489898','C/Roman 3',NULL,'Canarias','Canarias','Spain','35488',12,50000);
CALL add_cliente (22,'El Prat','Francisco','Camacho','916882323','916493211','Avenida Tibidabo',NULL,'Barcelona','Cataluña','Spain','12320',12,30000);
CALL add_cliente (23,'Sotogrande','Maria','Santillana','915576622','914825645','C/Paseo del Parque',NULL,'Sotogrande','Cadiz','Spain','11310',12,60000);
CALL add_cliente (24,'Vivero Humanes','Federico','Gomez','654987690','916040875','C/Miguel Echegaray 54',NULL,'Humanes','Madrid','Spain','28970',30,7430);
CALL add_cliente (25,'Fuenla City','Tony','Muñoz Mena','675842139','915483754','C/Callo 52',NULL,'Fuenlabrada','Madrid','Spain','28574',5,4500);
CALL add_cliente (26,'Jardines y Mansiones Cactus SL','Eva María','Sánchez','916877445','914477777','Polígono Industrial Maspalomas, Nº52','Móstoles','Madrid','Madrid','Spain','29874',9,76000);
CALL add_cliente (27,'Jardinerías Matías SL','Matías','San Martín','916544147','917897474','C/Francisco Arce, Nº44','Bustarviejo','Madrid','Madrid','Spain','37845',9,100500);
CALL add_cliente (28,'Agrojardin','Benito','Lopez','675432926','916549264','C/Mar Caspio 43',NULL,'Getafe','Madrid','Spain','28904',30,8040);
CALL add_cliente (29,'Top Campo','Joseluis','Sanchez','685746512','974315924','C/Ibiza 32',NULL,'Humanes','Madrid','Spain','28574',5,5500);
CALL add_cliente (30,'Jardineria Sara','Sara','Marquez','675124537','912475843','C/Lima 1',NULL,'Fuenlabrada','Madrid','Spain','27584',5,7500);
CALL add_cliente (31,'Campohermoso','Luis','Jimenez','645925376','916159116','C/Peru 78',NULL,'Fuenlabrada','Madrid','Spain','28945',30,3250);
CALL add_cliente (32,'france telecom','FraÃ§ois','Toulou','(33)5120578961','(33)5120578961','6 place d Alleray 15Ã¨me',NULL,'Paris',NULL,'France','75010',16,10000);
CALL add_cliente (33,'Musée du Louvre','Pierre','Delacroux','(33)0140205050','(33)0140205442','Quai du Louvre',NULL,'Paris',NULL,'France','75058',16,30000);
CALL add_cliente (35,'Tutifruti S.A','Jacob','Jones','2 9261-2433','2 9283-1695','level 24, St. Martins Tower.-31 Market St.',NULL,'Sydney','Nueva Gales del Sur','Australia','2000',31,10000);
CALL add_cliente (36,'Flores S.L.','Antonio','Romero','654352981','685249700','Avenida España',NULL,'Madrid','Fuenlabrada','Spain','29643',18,6000);
CALL add_cliente (37,'The Magic Garden','Richard','Mcain','926523468','9364875882','Lihgting Park',NULL,'London','London','United Kingdom','65930',18,10000);
CALL add_cliente (38,'El Jardin Viviente S.L','Justin','Smith','2 8005-7161','2 8005-7162','176 Cumberland Street The rocks',NULL,'Sydney','Nueva Gales del Sur','Australia','2003',31,8000);

CALL add_pedido (1,'2006-01-17','2006-01-19','2006-01-19','Entregado','Pagado a plazos',5);
CALL add_pedido (2,'2007-10-23','2007-10-28','2007-10-26','Entregado','La entrega llego antes de lo esperado',5);
CALL add_pedido (3,'2008-06-20','2008-06-25',NULL,'Rechazado','Limite de credito superado',5);
CALL add_pedido (4,'2009-01-20','2009-01-26',NULL,'Pendiente',NULL,5);
CALL add_pedido (8,'2008-11-09','2008-11-14','2008-11-14','Entregado','El cliente paga la mitad con tarjeta y la otra mitad con efectivo, se le realizan dos facturas',1);
CALL add_pedido (9,'2008-12-22','2008-12-27','2008-12-28','Entregado','El cliente comprueba la integridad del paquete, todo correcto',1);
CALL add_pedido (10,'2009-01-15','2009-01-20',NULL,'Pendiente','El cliente llama para confirmar la fecha - Esperando al proveedor',3);
CALL add_pedido (11,'2009-01-20','2009-01-27',NULL,'Pendiente','El cliente requiere que el pedido se le entregue de 16:00h a 22:00h',1);
CALL add_pedido (12,'2009-01-22','2009-01-27',NULL,'Pendiente','El cliente requiere que el pedido se le entregue de 9:00h a 13:00h',1);
CALL add_pedido (13,'2009-01-12','2009-01-14','2009-01-15','Entregado',NULL,7);
CALL add_pedido (14,'2009-01-02','2009-01-02',null,'Rechazado','mal pago',7);
CALL add_pedido (15,'2009-01-09','2009-01-12','2009-01-11','Entregado',NULL,7);
CALL add_pedido (16,'2009-01-06','2009-01-07','2009-01-15','Entregado',NULL,7);
CALL add_pedido (17,'2009-01-08','2009-01-09','2009-01-11','Entregado','mal estado',7);
CALL add_pedido (18,'2009-01-05','2009-01-06','2009-01-07','Entregado',NULL,9);
CALL add_pedido (19,'2009-01-18','2009-02-12',NULL,'Pendiente','entregar en murcia',9);
CALL add_pedido (20,'2009-01-20','2009-02-15',NULL,'Pendiente',NULL,9);
CALL add_pedido (21,'2009-01-09','2009-01-09','2009-01-09','Rechazado','mal pago',9);
CALL add_pedido (22,'2009-01-11','2009-01-11','2009-01-13','Entregado',NULL,9);
CALL add_pedido (23,'2008-12-30','2009-01-10',NULL,'Rechazado','El pedido fue anulado por el cliente',5);
CALL add_pedido (24,'2008-07-14','2008-07-31','2008-07-25','Entregado',NULL,14);
CALL add_pedido (25,'2009-02-02','2009-02-08',NULL,'Rechazado','El cliente carece de saldo en la cuenta asociada',1);
CALL add_pedido (26,'2009-02-06','2009-02-12',NULL,'Rechazado','El cliente anula la operacion para adquirir mas producto',3);
CALL add_pedido (27,'2009-02-07','2009-02-13',NULL,'Entregado','El pedido aparece como entregado pero no sabemos en que fecha',3);
CALL add_pedido (28,'2009-02-10','2009-02-17','2009-02-20','Entregado','El cliente se queja bastante de la espera asociada al producto',3);
CALL add_pedido (29,'2008-08-01','2008-09-01','2008-09-01','Rechazado','El cliente no está conforme con el pedido',14);
CALL add_pedido (30,'2008-08-03','2008-09-03','2008-08-31','Entregado',NULL,13);
CALL add_pedido (31,'2008-09-04','2008-09-30','2008-10-04','Rechazado','El cliente ha rechazado por llegar 5 dias tarde',13);
CALL add_pedido (32,'2007-01-07','2007-01-19','2007-01-27','Entregado','Entrega tardia, el cliente puso reclamacion',4);
CALL add_pedido (33,'2007-05-20','2007-05-28',NULL,'Rechazado','El pedido fue anulado por el cliente',4);
CALL add_pedido (34,'2007-06-20','2008-06-28','2008-06-28','Entregado','Pagado a plazos',4);
CALL add_pedido (35,'2008-03-10','2009-03-20',NULL,'Rechazado','Limite de credito superado',4);
CALL add_pedido (36,'2008-10-15','2008-12-15','2008-12-10','Entregado',NULL,14);
CALL add_pedido (37,'2008-11-03','2009-11-13',NULL,'Pendiente','El pedido nunca llego a su destino',4);
CALL add_pedido (38,'2009-03-05','2009-03-06','2009-03-07','Entregado',NULL,19);
CALL add_pedido (39,'2009-03-06','2009-03-07','2009-03-09','Pendiente',NULL,19);
CALL add_pedido (40,'2009-03-09','2009-03-10','2009-03-13','Rechazado',NULL,19);
CALL add_pedido (41,'2009-03-12','2009-03-13','2009-03-13','Entregado',NULL,19);
CALL add_pedido (42,'2009-03-22','2009-03-23','2009-03-27','Entregado',NULL,19);
CALL add_pedido (43,'2009-03-25','2009-03-26','2009-03-28','Pendiente',NULL,23);
CALL add_pedido (44,'2009-03-26','2009-03-27','2009-03-30','Pendiente',NULL,23);
CALL add_pedido (45,'2009-04-01','2009-03-04','2009-03-07','Entregado',NULL,23);
CALL add_pedido (46,'2009-04-03','2009-03-04','2009-03-05','Rechazado',NULL,23);
CALL add_pedido (47,'2009-04-15','2009-03-17','2009-03-17','Entregado',NULL,23);
CALL add_pedido (48,'2008-03-17','2008-03-30','2008-03-29','Entregado','Según el Cliente, el pedido llegó defectuoso',26);
CALL add_pedido (49,'2008-07-12','2008-07-22','2008-07-30','Entregado','El pedido llegó 1 día tarde, pero no hubo queja por parte de la empresa compradora',26);
CALL add_pedido (50,'2008-03-17','2008-08-09',NULL,'Pendiente','Al parecer, el pedido se ha extraviado a la altura de Sotalbo (Ávila)',26);
CALL add_pedido (51,'2008-10-01','2008-10-14','2008-10-14','Entregado','Todo se entregó a tiempo y en perfecto estado, a pesar del pésimo estado de las carreteras.',26);
CALL add_pedido (52,'2008-12-07','2008-12-21',NULL,'Pendiente','El transportista ha llamado a Eva María para indicarle que el pedido llegará más tarde de lo esperado.',26);
CALL add_pedido (53,'2008-10-15','2008-11-15','2008-11-09','Entregado','El pedido llega 6 dias antes',13);
CALL add_pedido (54,'2009-01-11','2009-02-11',NULL,'Pendiente',NULL,14);
CALL add_pedido (55,'2008-12-10','2009-01-10','2009-01-11','Entregado','Retrasado 1 dia por problemas de transporte',14);
CALL add_pedido (56,'2008-12-19','2009-01-20',NULL,'Rechazado','El cliente a anulado el pedido el dia 2009-01-10',13);
CALL add_pedido (57,'2009-01-05','2009-02-05',NULL,'Pendiente',NULL,13);
CALL add_pedido (58,'2009-01-24','2009-01-31','2009-01-30','Entregado','Todo correcto',3);
CALL add_pedido (59,'2008-11-09','2008-11-14','2008-11-14','Entregado','El cliente paga la mitad con tarjeta y la otra mitad con efectivo, se le realizan dos facturas',1);
CALL add_pedido (60,'2008-12-22','2008-12-27','2008-12-28','Entregado','El cliente comprueba la integridad del paquete, todo correcto',1);
CALL add_pedido (61,'2009-01-15','2009-01-20',NULL,'Pendiente','El cliente llama para confirmar la fecha - Esperando al proveedor',3);
CALL add_pedido (62,'2009-01-20','2009-01-27',NULL,'Pendiente','El cliente requiere que el pedido se le entregue de 16:00h a 22:00h',1);
CALL add_pedido (63,'2009-01-22','2009-01-27',NULL,'Pendiente','El cliente requiere que el pedido se le entregue de 9:00h a 13:00h',1);
CALL add_pedido (64,'2009-01-24','2009-01-31','2009-01-30','Entregado','Todo correcto',1);
CALL add_pedido (65,'2009-02-02','2009-02-08',NULL,'Rechazado','El cliente carece de saldo en la cuenta asociada',1);
CALL add_pedido (66,'2009-02-06','2009-02-12',NULL,'Rechazado','El cliente anula la operacion para adquirir mas producto',3);
CALL add_pedido (67,'2009-02-07','2009-02-13',NULL,'Entregado','El pedido aparece como entregado pero no sabemos en que fecha',3);
CALL add_pedido (68,'2009-02-10','2009-02-17','2009-02-20','Entregado','El cliente se queja bastante de la espera asociada al producto',3);
CALL add_pedido (74,'2009-01-14','2009-01-22',NULL,'Rechazado','El pedido no llego el dia que queria el cliente por fallo del transporte',15);
CALL add_pedido (75,'2009-01-11','2009-01-13','2009-01-13','Entregado','El pedido llego perfectamente',15);
CALL add_pedido (76,'2008-11-15','2008-11-23','2008-11-23','Entregado',NULL,15);
CALL add_pedido (77,'2009-01-03','2009-01-08',NULL,'Pendiente','El pedido no pudo ser entregado por problemas meteorologicos',15);
CALL add_pedido (78,'2008-12-15','2008-12-17','2008-12-17','Entregado','Fue entregado, pero faltaba mercancia que sera entregada otro dia',15);
CALL add_pedido (79,'2009-01-12','2009-01-13','2009-01-13','Entregado',NULL,28);
CALL add_pedido (80,'2009-01-25','2009-01-26',NULL,'Pendiente','No terminó el pago',28);
CALL add_pedido (81,'2009-01-18','2009-01-24',NULL,'Rechazado','Los producto estaban en mal estado',28);
CALL add_pedido (82,'2009-01-20','2009-01-29','2009-01-29','Entregado','El pedido llego un poco mas tarde de la hora fijada',28);
CALL add_pedido (83,'2009-01-24','2009-01-28',NULL,'Entregado',NULL,28);
CALL add_pedido (89,'2007-10-05','2007-12-13','2007-12-10','Entregado','La entrega se realizo dias antes de la fecha esperada por lo que el cliente quedo satisfecho',35);
CALL add_pedido (90,'2009-02-07','2008-02-17',NULL,'Pendiente','Debido a la nevada caída en la sierra, el pedido no podrá llegar hasta el día ',27);
CALL add_pedido (91,'2009-03-18','2009-03-29','2009-03-27','Entregado','Todo se entregó a su debido tiempo, incluso con un día de antelación',27);
CALL add_pedido (92,'2009-04-19','2009-04-30','2009-05-03','Entregado','El pedido se entregó tarde debido a la festividad celebrada en España durante esas fechas',27);
CALL add_pedido (93,'2009-05-03','2009-05-30','2009-05-17','Entregado','El pedido se entregó antes de lo esperado.',27);
CALL add_pedido (94,'2009-10-18','2009-11-01',NULL,'Pendiente','El pedido está en camino.',27);
CALL add_pedido (95,'2008-01-04','2008-01-19','2008-01-19','Entregado',NULL,35);
CALL add_pedido (96,'2008-03-20','2008-04-12','2008-04-13','Entregado','La entrega se retraso un dia',35);
CALL add_pedido (97,'2008-10-08','2008-11-25','2008-11-25','Entregado',NULL,35);
CALL add_pedido (98,'2009-01-08','2009-02-13',NULL,'Pendiente',NULL,35);
CALL add_pedido (99,'2009-02-15','2009-02-27',NULL,'Pendiente',NULL,16);
CALL add_pedido (100,'2009-01-10','2009-01-15','2009-01-15','Entregado','El pedido llego perfectamente',16);
CALL add_pedido (101,'2009-03-07','2009-03-27',NULL,'Rechazado','El pedido fue rechazado por el cliente',16);
CALL add_pedido (102,'2008-12-28','2009-01-08','2009-01-08','Entregado','Pago pendiente',16);
CALL add_pedido (103,'2009-01-15','2009-01-20','2009-01-24','Pendiente',NULL,30);
CALL add_pedido (104,'2009-03-02','2009-03-06','2009-03-06','Entregado',NULL,30);
CALL add_pedido (105,'2009-02-14','2009-02-20',NULL,'Rechazado','el producto ha sido rechazado por la pesima calidad',30);
CALL add_pedido (106,'2009-05-13','2009-05-15','2009-05-20','Pendiente',NULL,30);
CALL add_pedido (107,'2009-04-06','2009-04-10','2009-04-10','Entregado',NULL,30);
CALL add_pedido (108,'2009-04-09','2009-04-15','2009-04-15','Entregado',NULL,16);
CALL add_pedido (109,'2006-05-25','2006-07-28','2006-07-28','Entregado',NULL,38);
CALL add_pedido (110,'2007-03-19','2007-04-24','2007-04-24','Entregado',NULL,38);
CALL add_pedido (111,'2008-03-05','2008-03-30','2008-03-30','Entregado',NULL,36);
CALL add_pedido (112,'2009-03-05','2009-04-06','2009-05-07','Pendiente',NULL,36);
CALL add_pedido (113,'2008-10-28','2008-11-09','2009-01-09','Rechazado','El producto ha sido rechazado por la tardanza de el envio',36);
CALL add_pedido (114,'2009-01-15','2009-01-29','2009-01-31','Entregado','El envio llego dos dias más tarde debido al mal tiempo',36);
CALL add_pedido (115,'2008-11-29','2009-01-26','2009-02-27','Pendiente',NULL,36);
CALL add_pedido (116,'2008-06-28','2008-08-01','2008-08-01','Entregado',NULL,38);
CALL add_pedido (117,'2008-08-25','2008-10-01',NULL,'Rechazado','El pedido ha sido rechazado por la acumulacion de pago pendientes del cliente',38);
CALL add_pedido (118,'2009-02-15','2009-02-27',NULL,'Pendiente',NULL,16);
CALL add_pedido (119,'2009-01-10','2009-01-15','2009-01-15','Entregado','El pedido llego perfectamente',16);
CALL add_pedido (120,'2009-03-07','2009-03-27',NULL,'Rechazado','El pedido fue rechazado por el cliente',16);
CALL add_pedido (121,'2008-12-28','2009-01-08','2009-01-08','Entregado','Pago pendiente',16);
CALL add_pedido (122,'2009-04-09','2009-04-15','2009-04-15','Entregado',NULL,16);
CALL add_pedido (123,'2009-01-15','2009-01-20','2009-01-24','Pendiente',NULL,30);
CALL add_pedido (124,'2009-03-02','2009-03-06','2009-03-06','Entregado',NULL,30);
CALL add_pedido (125,'2009-02-14','2009-02-20',NULL,'Rechazado','el producto ha sido rechazado por la pesima calidad',30);
CALL add_pedido (126,'2009-05-13','2009-05-15','2009-05-20','Pendiente',NULL,30);
CALL add_pedido (127,'2009-04-06','2009-04-10','2009-04-10','Entregado',NULL,30);
CALL add_pedido (128,'2008-11-10','2008-12-10','2008-12-29','Rechazado','El pedido ha sido rechazado por el cliente por el retraso en la entrega',38);

CALL add_producto ('11679','Sierra de Poda 400MM','Herramientas','0,258','HiperGarden Tools','Gracias a la poda se consigue manipular un poco la naturaleza, dándole la forma que más nos guste. Este trabajo básico de jardinería también facilita que las plantas crezcan de un modo más equilibrado, y que las flores y los frutos vuelvan cada año con regularidad. Lo mejor es dar forma cuando los ejemplares son jóvenes, de modo que exijan pocos cuidados cuando sean adultos. Además de saber cuándo y cómo hay que podar, tener unas herramientas adecuadas para esta labor es también de vital importancia.',15,14,11);
CALL add_producto ('21636','Pala','Herramientas','0,156','HiperGarden Tools','Palas de acero con cresta de corte en la punta para cortar bien el terreno. Buena penetración en tierras muy compactas.',15,14,13);
CALL add_producto ('22225','Rastrillo de Jardín','Herramientas','1,064','HiperGarden Tools','Fabuloso rastillo que le ayudará a eliminar piedras, hojas, ramas y otros elementos incómodos en su jardín.',15,12,11);
CALL add_producto ('30310','Azadón','Herramientas','0,168','HiperGarden Tools','Longitud:24cm. Herramienta fabricada en acero y pintura epoxi,alargando su durabilidad y preveniendo la corrosión.Diseño pensado para el ahorro de trabajo.',15,12,11);
CALL add_producto ('AR-001','Ajedrea','Aromáticas','15-20','Murcia Seasons','Planta aromática que fresca se utiliza para condimentar carnes y ensaladas, y seca, para pastas, sopas y guisantes',140,1,0);
CALL add_producto ('AR-002','Lavándula Dentata','Aromáticas','15-20','Murcia Seasons','Espliego de jardín, Alhucema rizada, Alhucema dentada, Cantueso rizado. Familia: Lamiaceae.Origen: España y Portugal. Mata de unos 60 cm de alto. Las hojas son aromáticas, dentadas y de color verde grisáceas.  Produce compactas espigas de flores pequeñas, ligeramente aromáticas, tubulares,de color azulado y con brácteas púrpuras.  Frutos: nuececillas alargadas encerradas en el tubo del cáliz.  Se utiliza en jardineria y no en perfumeria como otros cantuesos, espliegos y lavandas.  Tiene propiedades aromatizantes y calmantes. Adecuadas para la formación de setos bajos. Se dice que su aroma ahuyenta pulgones y otros insectos perjudiciales para las plantas vecinas.',140,1,0);
CALL add_producto ('AR-003','Mejorana','Aromáticas','15-20','Murcia Seasons','Origanum majorana. No hay que confundirlo con el orégano. Su sabor se parece más al tomillo, pero es más dulce y aromático.Se usan las hojas frescas o secas, picadas, machacadas o en polvo, en sopas, rellenos, quiches y tartas, tortillas, platos con papas y, como aderezo, en ramilletes de hierbas.El sabor delicado de la mejorana se elimina durante la cocción, de manera que es mejor agregarla cuando el plato esté en su punto o en aquéllos que apenas necesitan cocción.',140,1,0);
CALL add_producto ('AR-004','Melissa ','Aromáticas','15-20','Murcia Seasons','Es una planta perenne (dura varios años) conocida por el agradable y característico olor a limón que desprenden en verano. Nunca debe faltar en la huerta o jardín por su agradable aroma y por los variados usos que tiene: planta olorosa, condimentaria y medicinal. Su cultivo es muy fácil. Le va bien un suelo ligero, con buen drenaje y riego sin exceso. A pleno sol o por lo menos 5 horas de sol por día. Cada año, su abonado mineral correspondiente.En otoño, la melisa pierde el agradable olor a limón que desprende en verano sus flores azules y blancas. En este momento se debe cortar a unos 20 cm. del suelo. Brotará de forma densa en primavera.',140,1,0);
CALL add_producto ('AR-005','Mentha Sativa','Aromáticas','15-20','Murcia Seasons','¿Quién no conoce la Hierbabuena? Se trata de una plantita muy aromática, agradable y cultivada extensamente por toda España. Es hierba perenne (por tanto vive varios años, no es anual). Puedes cultivarla en maceta o plantarla en la tierra del jardín o en un rincón del huerto. Lo más importante es que cuente con bastante agua. En primavera debes aportar fertilizantes minerales. Vive mejor en semisombra que a pleno sol.Si ves orugas o los agujeros en hojas consecuencia de su ataque, retíralas una a una a mano; no uses insecticidas químicos.',140,1,0);
CALL add_producto ('AR-006','Petrosilium Hortense (Peregil)','Aromáticas','15-20','Murcia Seasons','Nombre científico o latino: Petroselinum hortense, Petroselinum crispum. Nombre común o vulgar: Perejil, Perejil rizado Familia: Umbelliferae (Umbelíferas). Origen: el origen del perejil se encuentra en el Mediterraneo. Esta naturalizada en casi toda Europa. Se utiliza como condimento y para adorno, pero también en ensaladas. Se suele regalar en las fruterías y verdulerías.El perejil lo hay de 2 tipos: de hojas planas y de hojas rizadas.',140,1,0);
CALL add_producto ('AR-007','Salvia Mix','Aromáticas','15-20','Murcia Seasons','La Salvia es un pequeño arbusto que llega hasta el metro de alto.Tiene una vida breve, de unos pocos años.En el jardín, como otras aromáticas, queda muy bien en una rocalla o para hacer una bordura perfumada a cada lado de un camino de Salvia. Abona después de cada corte y recorta el arbusto una vez pase la floración.',140,1,0);
CALL add_producto ('AR-008','Thymus Citriodra (Tomillo limón)','Aromáticas','15-20','Murcia Seasons','Nombre común o vulgar: Tomillo, Tremoncillo Familia: Labiatae (Labiadas).Origen: Región mediterránea.Arbustillo bajo, de 15 a 40 cm de altura. Las hojas son muy pequeñas, de unos 6 mm de longitud; según la variedad pueden ser verdes, verdes grisáceas, amarillas, o jaspeadas. Las flores aparecen de mediados de primavera hasta bien entrada la época estival y se presentan en racimos terminales que habitualmente son de color violeta o púrpura aunque también pueden ser blancas. Esta planta despide un intenso y típico aroma, que se incrementa con el roce. El tomillo resulta de gran belleza cuando está en flor. El tomillo atrae a avispas y abejas. En jardinería se usa como manchas, para hacer borduras, para aromatizar el ambiente, llenar huecos, cubrir rocas, para jardines en miniatura, etc. Arranque las flores y hojas secas del tallo y añadálos a un popurri, introdúzcalos en saquitos de hierbas o en la almohada.También puede usar las ramas secas con flores para añadir aroma y textura a cestos abiertos.',140,1,0);
CALL add_producto ('AR-009','Thymus Vulgaris','Aromáticas','15-20','Murcia Seasons','Nombre común o vulgar: Tomillo, Tremoncillo Familia: Labiatae (Labiadas). Origen: Región mediterránea. Arbustillo bajo, de 15 a 40 cm de altura. Las hojas son muy pequeñas, de unos 6 mm de longitud; según la variedad pueden ser verdes, verdes grisáceas, amarillas, o jaspeadas. Las flores aparecen de mediados de primavera hasta bien entrada la época estival y se presentan en racimos terminales que habitualmente son de color violeta o púrpura aunque también pueden ser blancas. Esta planta despide un intenso y típico aroma, que se incrementa con el roce. El tomillo resulta de gran belleza cuando está en flor. El tomillo atrae a avispas y abejas.\r\n En jardinería se usa como manchas, para hacer borduras, para aromatizar el ambiente, llenar huecos, cubrir rocas, para jardines en miniatura, etc. Arranque las flores y hojas secas del tallo y añadálos a un popurri, introdúzcalos en saquitos de hierbas o en la almohada. También puede usar las ramas secas con flores para añadir aroma y textura a cestos abiertos.',140,1,0);
CALL add_producto ('AR-010','Santolina Chamaecyparys','Aromáticas','15-20','Murcia Seasons','',140,1,0);
CALL add_producto ('FR-1','Expositor Cítricos Mix','Frutales','100-120','Frutales Talavera S.A','',15,7,5);
CALL add_producto ('FR-10','Limonero 2 años injerto','Frutales','','NaranjasValencianas.com','El limonero, pertenece al grupo de los cítricos, teniendo su origen hace unos 20 millones de años en el sudeste asiático. Fue introducido por los árabes en el área mediterránea entre los años 1.000 a 1.200, habiendo experimentando numerosas modificaciones debidas tanto a la selección natural mediante hibridaciones espontáneas como a las producidas por el hombre, en este caso buscando las necesidades del mercado.',15,7,5);
CALL add_producto ('FR-100','Nectarina','Frutales','8/10','Frutales Talavera S.A','Se trata de un árbol derivado por mutación de los melocotoneros comunes, y los únicos caracteres diferenciales son la ausencia de tomentosidad en la piel del fruto. La planta, si se deja crecer libremente, adopta un porte globoso con unas dimensiones medias de 4-6 metros',50,11,8);
CALL add_producto ('FR-101','Nogal','Frutales','8/10','Frutales Talavera S.A','',50,13,10);
CALL add_producto ('FR-102','Olea-Olivos','Frutales','8/10','Frutales Talavera S.A','Existen dos hipótesis sobre el origen del olivo, una que postula que proviene de las costas de Siria, Líbano e Israel y otra que considera que lo considera originario de Asia menor. La llegada a Europa probablemente tuvo lugar de mano de los Fenicios, en transito por Chipre, Creta, e Islas del Mar Egeo, pasando a Grecia y más tarde a Italia. Los primeros indicios de la presencia del olivo en las costas mediterráneas españolas coinciden con el dominio romano, aunque fueron posteriormente los árabes los que impulsaron su cultivo en Andalucía, convirtiendo a España en el primer país productor de aceite de oliva a nivel mundial.',50,18,14);
CALL add_producto ('FR-103','Olea-Olivos','Frutales','10/12','Frutales Talavera S.A','Existen dos hipótesis sobre el origen del olivo, una que postula que proviene de las costas de Siria, Líbano e Israel y otra que considera que lo considera originario de Asia menor. La llegada a Europa probablemente tuvo lugar de mano de los Fenicios, en transito por Chipre, Creta, e Islas del Mar Egeo, pasando a Grecia y más tarde a Italia. Los primeros indicios de la presencia del olivo en las costas mediterráneas españolas coinciden con el dominio romano, aunque fueron posteriormente los árabes los que impulsaron su cultivo en Andalucía, convirtiendo a España en el primer país productor de aceite de oliva a nivel mundial.',50,25,20);
CALL add_producto ('FR-104','Olea-Olivos','Frutales','12/4','Frutales Talavera S.A','Existen dos hipótesis sobre el origen del olivo, una que postula que proviene de las costas de Siria, Líbano e Israel y otra que considera que lo considera originario de Asia menor. La llegada a Europa probablemente tuvo lugar de mano de los Fenicios, en transito por Chipre, Creta, e Islas del Mar Egeo, pasando a Grecia y más tarde a Italia. Los primeros indicios de la presencia del olivo en las costas mediterráneas españolas coinciden con el dominio romano, aunque fueron posteriormente los árabes los que impulsaron su cultivo en Andalucía, convirtiendo a España en el primer país productor de aceite de oliva a nivel mundial.',50,49,39);
CALL add_producto ('FR-105','Olea-Olivos','Frutales','14/16','Frutales Talavera S.A','Existen dos hipótesis sobre el origen del olivo, una que postula que proviene de las costas de Siria, Líbano e Israel y otra que considera que lo considera originario de Asia menor. La llegada a Europa probablemente tuvo lugar de mano de los Fenicios, en transito por Chipre, Creta, e Islas del Mar Egeo, pasando a Grecia y más tarde a Italia. Los primeros indicios de la presencia del olivo en las costas mediterráneas españolas coinciden con el dominio romano, aunque fueron posteriormente los árabes los que impulsaron su cultivo en Andalucía, convirtiendo a España en el primer país productor de aceite de oliva a nivel mundial.',50,70,56);
CALL add_producto ('FR-106','Peral','Frutales','8/10','Frutales Talavera S.A','Árbol piramidal, redondeado en su juventud, luego oval, que llega hasta 20 metros de altura y por término medio vive 65 años.Tronco alto, grueso, de corteza agrietada, gris, de la cual se destacan con frecuencia placas lenticulares.Las ramas se insertan formando ángulo agudo con el tronco (45º), de corteza lisa, primero verde y luego gris-violácea, con numerosas lenticelas.',50,11,8);
CALL add_producto ('FR-107','Peral','Frutales','10/12','Frutales Talavera S.A','Árbol piramidal, redondeado en su juventud, luego oval, que llega hasta 20 metros de altura y por término medio vive 65 años.Tronco alto, grueso, de corteza agrietada, gris, de la cual se destacan con frecuencia placas lenticulares.Las ramas se insertan formando ángulo agudo con el tronco (45º), de corteza lisa, primero verde y luego gris-violácea, con numerosas lenticelas.',50,22,17);
CALL add_producto ('FR-108','Peral','Frutales','12/14','Frutales Talavera S.A','Árbol piramidal, redondeado en su juventud, luego oval, que llega hasta 20 metros de altura y por término medio vive 65 años.Tronco alto, grueso, de corteza agrietada, gris, de la cual se destacan con frecuencia placas lenticulares.Las ramas se insertan formando ángulo agudo con el tronco (45º), de corteza lisa, primero verde y luego gris-violácea, con numerosas lenticelas.',50,32,25);
CALL add_producto ('FR-11','Limonero 30/40','Frutales','','NaranjasValencianas.com','El limonero, pertenece al grupo de los cítricos, teniendo su origen hace unos 20 millones de años en el sudeste asiático. Fue introducido por los árabes en el área mediterránea entre los años 1.000 a 1.200, habiendo experimentando numerosas modificaciones debidas tanto a la selección natural mediante hibridaciones espontáneas como a las producidas por el',15,100,80);
CALL add_producto ('FR-12','Kunquat ','Frutales','','NaranjasValencianas.com','su nombre científico se origina en honor a un hoticultor escocés que recolectó especímenes en China, (\"Fortunella\"), Robert Fortune (1812-1880), y \"margarita\", del latín margaritus-a-um = perla, en alusión a sus pequeños y brillantes frutos. Se trata de un arbusto o árbol pequeño de 2-3 m de altura, inerme o con escasas espinas.Hojas lanceoladas de 4-8 (-15) cm de longitud, con el ápice redondeado y la base cuneada.Tienen el margen crenulado en su mitad superior, el haz verde brillante y el envés más pálido.Pecíolo ligeramente marginado.Flores perfumadas solitarias o agrupadas en inflorescencias axilares, blancas.El fruto es lo más característico, es el más pequeño de todos los cítricos y el único cuya cáscara se puede comer.Frutos pequeños, con semillas, de corteza fina, dulce, aromática y comestible, y de pulpa naranja amarillenta y ligeramente ácida.Sus frutos son muy pequeños y tienen un carácter principalmente ornamental.',15,21,16);
CALL add_producto ('FR-13','Kunquat  EXTRA con FRUTA','Frutales','150-170','NaranjasValencianas.com','su nombre científico se origina en honor a un hoticultor escocés que recolectó especímenes en China, (\"Fortunella\"), Robert Fortune (1812-1880), y \"margarita\", del latín margaritus-a-um = perla, en alusión a sus pequeños y brillantes frutos. Se trata de un arbusto o árbol pequeño de 2-3 m de altura, inerme o con escasas espinas.Hojas lanceoladas de 4-8 (-15) cm de longitud, con el ápice redondeado y la base cuneada.Tienen el margen crenulado en su mitad superior, el haz verde brillante y el envés más pálido.Pecíolo ligeramente marginado.Flores perfumadas solitarias o agrupadas en inflorescencias axilares, blancas.El fruto es lo más característico, es el más pequeño de todos los cítricos y el único cuya cáscara se puede comer.Frutos pequeños, con semillas, de corteza fina, dulce, aromática y comestible, y de pulpa naranja amarillenta y ligeramente ácida.Sus frutos son muy pequeños y tienen un carácter principalmente ornamental.',15,57,45);
CALL add_producto ('FR-14','Calamondin Mini','Frutales','','Frutales Talavera S.A','Se trata de un pequeño arbolito de copa densa, con tendencia a la verticalidad, inerme o con cortas espinas. Sus hojas son pequeñas, elípticas de 5-10 cm de longitud, con los pecíolos estrechamente alados.Posee 1 o 2 flores en situación axilar, al final de las ramillas.Sus frutos son muy pequeños (3-3,5 cm de diámetro), con pocas semillas, esféricos u ovales, con la zona apical aplanada; corteza de color naranja-rojizo, muy fina y fácilmente separable de la pulpa, que es dulce, ácida y comestible..',15,10,8);
CALL add_producto ('FR-15','Calamondin Copa ','Frutales','','Frutales Talavera S.A','Se trata de un pequeño arbolito de copa densa, con tendencia a la verticalidad, inerme o con cortas espinas. Sus hojas son pequeñas, elípticas de 5-10 cm de longitud, con los pecíolos estrechamente alados.Posee 1 o 2 flores en situación axilar, al final de las ramillas.Sus frutos son muy pequeños (3-3,5 cm de diámetro), con pocas semillas, esféricos u ovales, con la zona apical aplanada; corteza de color naranja-rojizo, muy fina y fácilmente separable de la pulpa, que es dulce, ácida y comestible..',15,25,20);
CALL add_producto ('FR-16','Calamondin Copa EXTRA Con FRUTA','Frutales','100-120','Frutales Talavera S.A','Se trata de un pequeño arbolito de copa densa, con tendencia a la verticalidad, inerme o con cortas espinas. Sus hojas son pequeñas, elípticas de 5-10 cm de longitud, con los pecíolos estrechamente alados.Posee 1 o 2 flores en situación axilar, al final de las ramillas.Sus frutos son muy pequeños (3-3,5 cm de diámetro), con pocas semillas, esféricos u ovales, con la zona apical aplanada; corteza de color naranja-rojizo, muy fina y fácilmente separable de la pulpa, que es dulce, ácida y comestible..',15,45,36);
CALL add_producto ('FR-17','Rosal bajo 1Âª -En maceta-inicio brotación','Frutales','','Frutales Talavera S.A','',15,2,1);
CALL add_producto ('FR-18','ROSAL TREPADOR','Frutales','','Frutales Talavera S.A','',350,4,3);
CALL add_producto ('FR-19','Camelia Blanco, Chrysler Rojo, Soraya Naranja, ','Frutales','','NaranjasValencianas.com','',350,4,3);
CALL add_producto ('FR-2','Naranjo -Plantón joven 1 año injerto','Frutales','','NaranjasValencianas.com','El naranjo es un árbol pequeño, que no supera los 3-5 metros de altura, con una copa compacta, cónica, transformada en esérica gracias a la poda. Su tronco es de color gris y liso, y las hojas son perennes, coriáceas, de un verde intenso y brillante, con forma oval o elíptico-lanceolada. Poseen, en el caso del naranjo amargo, un típico peciolo alado en forma de Â‘corazónÂ’, que en el naranjo dulce es más estrecho y menos patente.',15,6,4);
CALL add_producto ('FR-20','Landora Amarillo, Rose Gaujard bicolor blanco-rojo','Frutales','','Frutales Talavera S.A','',350,4,3);
CALL add_producto ('FR-21','Kordes Perfect bicolor rojo-amarillo, Roundelay rojo fuerte','Frutales','','Frutales Talavera S.A','',350,4,3);
CALL add_producto ('FR-22','Pitimini rojo','Frutales','','Frutales Talavera S.A','',350,4,3);
CALL add_producto ('FR-23','Rosal copa ','Frutales','','Frutales Talavera S.A','',400,8,6);
CALL add_producto ('FR-24','Albaricoquero Corbato','Frutales','','Melocotones de Cieza S.A.','árbol que puede pasar de los 6 m de altura, en la región mediterránea con ramas formando una copa redondeada. La corteza del tronco es pardo-violácea, agrietada; las ramas son rojizas y extendidas cuando jóvenes y las ramas secundarias son cortas, divergentes y escasas. Las yemas latentes son frecuentes especialmente sobre las ramas viejas.',400,8,6);
CALL add_producto ('FR-25','Albaricoquero Moniqui','Frutales','','Melocotones de Cieza S.A.','árbol que puede pasar de los 6 m de altura, en la región mediterránea con ramas formando una copa redondeada. La corteza del tronco es pardo-violácea, agrietada; las ramas son rojizas y extendidas cuando jóvenes y las ramas secundarias son cortas, divergentes y escasas. Las yemas latentes son frecuentes especialmente sobre las ramas viejas.',400,8,6);
CALL add_producto ('FR-26','Albaricoquero Kurrot','Frutales','','Melocotones de Cieza S.A.','árbol que puede pasar de los 6 m de altura, en la región mediterránea con ramas formando una copa redondeada. La corteza del tronco es pardo-violácea, agrietada; las ramas son rojizas y extendidas cuando jóvenes y las ramas secundarias son cortas, divergentes y escasas. Las yemas latentes son frecuentes especialmente sobre las ramas viejas.',400,8,6);
CALL add_producto ('FR-27','Cerezo Burlat','Frutales','','Jerte Distribuciones S.L.','Las principales especies de cerezo cultivadas en el mundo son el cerezo dulce (Prunus avium), el guindo (P. cerasus) y el cerezo \"Duke\", híbrido de los anteriores. Ambas especies son naturales del sureste de Europa y oeste de Asia. El cerezo dulce tuvo su origen probablemente en el mar Negro y en el mar Caspio, difundiéndose después hacia Europa y Asia, llevado por los pájaros y las migraciones humanas. Fue uno de los frutales más apreciados por los griegos y con el Imperio Romano se extendió a regiones muy diversas. En la actualidad, el cerezo se encuentra difundido por numerosas regiones y países del mundo con clima templado',400,8,6);
CALL add_producto ('FR-28','Cerezo Picota','Frutales','','Jerte Distribuciones S.L.','Las principales especies de cerezo cultivadas en el mundo son el cerezo dulce (Prunus avium), el guindo (P. cerasus) y el cerezo \"Duke\", híbrido de los anteriores. Ambas especies son naturales del sureste de Europa y oeste de Asia. El cerezo dulce tuvo su origen probablemente en el mar Negro y en el mar Caspio, difundiéndose después hacia Europa y Asia, llevado por los pájaros y las migraciones humanas. Fue uno de los frutales más apreciados por los griegos y con el Imperio Romano se extendió a regiones muy diversas. En la actualidad, el cerezo se encuentra difundido por numerosas regiones y países del mundo con clima templado',400,8,6);
CALL add_producto ('FR-29','Cerezo Napoleón','Frutales','','Jerte Distribuciones S.L.','Las principales especies de cerezo cultivadas en el mundo son el cerezo dulce (Prunus avium), el guindo (P. cerasus) y el cerezo \"Duke\", híbrido de los anteriores. Ambas especies son naturales del sureste de Europa y oeste de Asia. El cerezo dulce tuvo su origen probablemente en el mar Negro y en el mar Caspio, difundiéndose después hacia Europa y Asia, llevado por los pájaros y las migraciones humanas. Fue uno de los frutales más apreciados por los griegos y con el Imperio Romano se extendió a regiones muy diversas. En la actualidad, el cerezo se encuentra difundido por numerosas regiones y países del mundo con clima templado',400,8,6);
CALL add_producto ('FR-3','Naranjo 2 años injerto','Frutales','','NaranjasValencianas.com','El naranjo es un árbol pequeño, que no supera los 3-5 metros de altura, con una copa compacta, cónica, transformada en esérica gracias a la poda. Su tronco es de color gris y liso, y las hojas son perennes, coriáceas, de un verde intenso y brillante, con forma oval o elíptico-lanceolada. Poseen, en el caso del naranjo amargo, un típico peciolo alado en forma de Â‘corazónÂ’, que en el naranjo dulce es más estrecho y menos patente.',15,7,5);
CALL add_producto ('FR-30','Ciruelo R. Claudia Verde   ','Frutales','','Frutales Talavera S.A','árbol de tamaño mediano que alcanza una altura máxima de 5-6 m. Tronco de corteza pardo-azulada, brillante, lisa o agrietada longitudinalmente. Produce ramas alternas, pequeñas, delgadas, unas veces lisas, glabras y otras pubescentes y vellosas',400,8,6);
CALL add_producto ('FR-31','Ciruelo Santa Rosa','Frutales','','Frutales Talavera S.A','árbol de tamaño mediano que alcanza una altura máxima de 5-6 m. Tronco de corteza pardo-azulada, brillante, lisa o agrietada longitudinalmente. Produce ramas alternas, pequeñas, delgadas, unas veces lisas, glabras y otras pubescentes y vellosas',400,8,6);
CALL add_producto ('FR-32','Ciruelo Golden Japan','Frutales','','Frutales Talavera S.A','árbol de tamaño mediano que alcanza una altura máxima de 5-6 m. Tronco de corteza pardo-azulada, brillante, lisa o agrietada longitudinalmente. Produce ramas alternas, pequeñas, delgadas, unas veces lisas, glabras y otras pubescentes y vellosas',400,8,6);
CALL add_producto ('FR-33','Ciruelo Friar','Frutales','','Frutales Talavera S.A','árbol de tamaño mediano que alcanza una altura máxima de 5-6 m. Tronco de corteza pardo-azulada, brillante, lisa o agrietada longitudinalmente. Produce ramas alternas, pequeñas, delgadas, unas veces lisas, glabras y otras pubescentes y vellosas',400,8,6);
CALL add_producto ('FR-34','Ciruelo Reina C. De Ollins','Frutales','','Frutales Talavera S.A','árbol de tamaño mediano que alcanza una altura máxima de 5-6 m. Tronco de corteza pardo-azulada, brillante, lisa o agrietada longitudinalmente. Produce ramas alternas, pequeñas, delgadas, unas veces lisas, glabras y otras pubescentes y vellosas',400,8,6);
CALL add_producto ('FR-35','Ciruelo Claudia Negra','Frutales','','Frutales Talavera S.A','árbol de tamaño mediano que alcanza una altura máxima de 5-6 m. Tronco de corteza pardo-azulada, brillante, lisa o agrietada longitudinalmente. Produce ramas alternas, pequeñas, delgadas, unas veces lisas, glabras y otras pubescentes y vellosas',400,8,6);
CALL add_producto ('FR-36','Granado Mollar de Elche','Frutales','','Frutales Talavera S.A','pequeño árbol caducifolio, a veces con porte arbustivo, de 3 a 6 m de altura, con el tronco retorcido. Madera dura y corteza escamosa de color grisáceo. Las ramitas jóvenes son más o menos cuadrangulares o angostas y de cuatro alas, posteriormente se vuelven redondas con corteza de color café grisáceo, la mayoría de las ramas, pero especialmente las pequeñas ramitas axilares, son en forma de espina o terminan en una espina aguda; la copa es extendida.',400,9,7);
CALL add_producto ('FR-37','Higuera Napolitana','Frutales','','Frutales Talavera S.A','La higuera (Ficus carica L.) es un árbol típico de secano en los países mediterráneos. Su rusticidad y su fácil multiplicación hacen de la higuera un frutal muy apropiado para el cultivo extensivo.. Siempre ha sido considerado como árbol que no requiere cuidado alguno una vez plantado y arraigado, limitándose el hombre a recoger de él los frutos cuando maduran, unos para consumo en fresco y otros para conserva. Las únicas higueras con cuidados culturales esmerados, en muchas comarcas, son las brevales, por el interés económico de su primera cosecha, la de brevas.',400,9,7);
CALL add_producto ('FR-38','Higuera Verdal','Frutales','','Frutales Talavera S.A','La higuera (Ficus carica L.) es un árbol típico de secano en los países mediterráneos. Su rusticidad y su fácil multiplicación hacen de la higuera un frutal muy apropiado para el cultivo extensivo.. Siempre ha sido considerado como árbol que no requiere cuidado alguno una vez plantado y arraigado, limitándose el hombre a recoger de él los frutos cuando maduran, unos para consumo en fresco y otros para conserva. Las únicas higueras con cuidados culturales esmerados, en muchas comarcas, son las brevales, por el interés económico de su primera cosecha, la de brevas.',400,9,7);
CALL add_producto ('FR-39','Higuera Breva','Frutales','','Frutales Talavera S.A','La higuera (Ficus carica L.) es un árbol típico de secano en los países mediterráneos. Su rusticidad y su fácil multiplicación hacen de la higuera un frutal muy apropiado para el cultivo extensivo.. Siempre ha sido considerado como árbol que no requiere cuidado alguno una vez plantado y arraigado, limitándose el hombre a recoger de él los frutos cuando maduran, unos para consumo en fresco y otros para conserva. Las únicas higueras con cuidados culturales esmerados, en muchas comarcas, son las brevales, por el interés económico de su primera cosecha, la de brevas.',400,9,7);
CALL add_producto ('FR-4','Naranjo calibre 8/10','Frutales','','NaranjasValencianas.com','El naranjo es un árbol pequeño, que no supera los 3-5 metros de altura, con una copa compacta, cónica, transformada en esérica gracias a la poda. Su tronco es de color gris y liso, y las hojas son perennes, coriáceas, de un verde intenso y brillante, con forma oval o elíptico-lanceolada. Poseen, en el caso del naranjo amargo, un típico peciolo alado en forma de Â‘corazónÂ’, que en el naranjo dulce es más estrecho y menos patente.',15,29,23);
CALL add_producto ('FR-40','Manzano Starking Delicious','Frutales','','Frutales Talavera S.A','alcanza como máximo 10 m. de altura y tiene una copa globosa. Tronco derecho que normalmente alcanza de 2 a 2,5 m. de altura, con corteza cubierta de lenticelas, lisa, adherida, de color ceniciento verdoso sobre los ramos y escamosa y gris parda sobre las partes viejas del árbol. Tiene una vida de unos 60-80 años. Las ramas se insertan en ángulo abierto sobre el tallo, de color verde oscuro, a veces tendiendo a negruzco o violáceo. Los brotes jóvenes terminan con frecuencia en una espina',400,8,6);
CALL add_producto ('FR-41','Manzano Reineta','Frutales','','Frutales Talavera S.A','alcanza como máximo 10 m. de altura y tiene una copa globosa. Tronco derecho que normalmente alcanza de 2 a 2,5 m. de altura, con corteza cubierta de lenticelas, lisa, adherida, de color ceniciento verdoso sobre los ramos y escamosa y gris parda sobre las partes viejas del árbol. Tiene una vida de unos 60-80 años. Las ramas se insertan en ángulo abierto sobre el tallo, de color verde oscuro, a veces tendiendo a negruzco o violáceo. Los brotes jóvenes terminan con frecuencia en una espina',400,8,6);
CALL add_producto ('FR-42','Manzano Golden Delicious','Frutales','','Frutales Talavera S.A','alcanza como máximo 10 m. de altura y tiene una copa globosa. Tronco derecho que normalmente alcanza de 2 a 2,5 m. de altura, con corteza cubierta de lenticelas, lisa, adherida, de color ceniciento verdoso sobre los ramos y escamosa y gris parda sobre las partes viejas del árbol. Tiene una vida de unos 60-80 años. Las ramas se insertan en ángulo abierto sobre el tallo, de color verde oscuro, a veces tendiendo a negruzco o violáceo. Los brotes jóvenes terminan con frecuencia en una espina',400,8,6);
CALL add_producto ('FR-43','Membrillero Gigante de Wranja','Frutales','','Frutales Talavera S.A','',400,8,6);
CALL add_producto ('FR-44','Melocotonero Spring Crest','Frutales','','Melocotones de Cieza S.A.','Árbol caducifolio de porte bajo con corteza lisa, de color ceniciento. Sus hojas son alargadas con el margen ligeramente aserrado, de color verde brillante, algo más claras por el envés. El melocotonero está muy arraigado en la cultura asiática.\r\nEn Japón, el noble heroe Momotaro, una especie de Cid japonés, nació del interior de un enorme melocotón que flotaba río abajo.\r\nEn China se piensa que comer melocotón confiere longevidad al ser humano, ya que formaba parte de la dieta de sus dioses inmortales.',400,8,6);
CALL add_producto ('FR-45','Melocotonero Amarillo de Agosto','Frutales','','Melocotones de Cieza S.A.','Árbol caducifolio de porte bajo con corteza lisa, de color ceniciento. Sus hojas son alargadas con el margen ligeramente aserrado, de color verde brillante, algo más claras por el envés. El melocotonero está muy arraigado en la cultura asiática.\r\nEn Japón, el noble heroe Momotaro, una especie de Cid japonés, nació del interior de un enorme melocotón que flotaba río abajo.\r\nEn China se piensa que comer melocotón confiere longevidad al ser humano, ya que formaba parte de la dieta de sus dioses inmortales.',400,8,6);
CALL add_producto ('FR-46','Melocotonero Federica','Frutales','','Melocotones de Cieza S.A.','Árbol caducifolio de porte bajo con corteza lisa, de color ceniciento. Sus hojas son alargadas con el margen ligeramente aserrado, de color verde brillante, algo más claras por el envés. El melocotonero está muy arraigado en la cultura asiática.\r\nEn Japón, el noble heroe Momotaro, una especie de Cid japonés, nació del interior de un enorme melocotón que flotaba río abajo.\r\nEn China se piensa que comer melocotón confiere longevidad al ser humano, ya que formaba parte de la dieta de sus dioses inmortales.',400,8,6);
CALL add_producto ('FR-47','Melocotonero Paraguayo','Frutales','','Melocotones de Cieza S.A.','Árbol caducifolio de porte bajo con corteza lisa, de color ceniciento. Sus hojas son alargadas con el margen ligeramente aserrado, de color verde brillante, algo más claras por el envés. El melocotonero está muy arraigado en la cultura asiática.\r\nEn Japón, el noble heroe Momotaro, una especie de Cid japonés, nació del interior de un enorme melocotón que flotaba río abajo.\r\nEn China se piensa que comer melocotón confiere longevidad al ser humano, ya que formaba parte de la dieta de sus dioses inmortales.',400,8,6);
CALL add_producto ('FR-48','Nogal Común','Frutales','','Frutales Talavera S.A','',400,9,7);
CALL add_producto ('FR-49','Parra Uva de Mesa','Frutales','','Frutales Talavera S.A','',400,8,6);
CALL add_producto ('FR-5','Mandarino -Plantón joven','Frutales','','Frutales Talavera S.A','',15,6,4);
CALL add_producto ('FR-50','Peral Castell','Frutales','','Frutales Talavera S.A','Árbol piramidal, redondeado en su juventud, luego oval, que llega hasta 20 metros de altura y por término medio vive 65 años.Tronco alto, grueso, de corteza agrietada, gris, de la cual se destacan con frecuencia placas lenticulares.Las ramas se insertan formando ángulo agudo con el tronco (45º), de corteza lisa, primero verde y luego gris-violácea, con numerosas lenticelas.',400,8,6);
CALL add_producto ('FR-51','Peral Williams','Frutales','','Frutales Talavera S.A','Árbol piramidal, redondeado en su juventud, luego oval, que llega hasta 20 metros de altura y por término medio vive 65 años.Tronco alto, grueso, de corteza agrietada, gris, de la cual se destacan con frecuencia placas lenticulares.Las ramas se insertan formando ángulo agudo con el tronco (45º), de corteza lisa, primero verde y luego gris-violácea, con numerosas lenticelas.',400,8,6);
CALL add_producto ('FR-52','Peral Conference','Frutales','','Frutales Talavera S.A','Árbol piramidal, redondeado en su juventud, luego oval, que llega hasta 20 metros de altura y por término medio vive 65 años.Tronco alto, grueso, de corteza agrietada, gris, de la cual se destacan con frecuencia placas lenticulares.Las ramas se insertan formando ángulo agudo con el tronco (45º), de corteza lisa, primero verde y luego gris-violácea, con numerosas lenticelas.',400,8,6);
CALL add_producto ('FR-53','Peral Blanq. de Aranjuez','Frutales','','Frutales Talavera S.A','Árbol piramidal, redondeado en su juventud, luego oval, que llega hasta 20 metros de altura y por término medio vive 65 años.Tronco alto, grueso, de corteza agrietada, gris, de la cual se destacan con frecuencia placas lenticulares.Las ramas se insertan formando ángulo agudo con el tronco (45º), de corteza lisa, primero verde y luego gris-violácea, con numerosas lenticelas.',400,8,6);
CALL add_producto ('FR-54','Níspero Tanaca','Frutales','','Frutales Talavera S.A','Aunque originario del Sudeste de China, el níspero llegó a Europa procedente de Japón en el siglo XVIII como árbol ornamental. En el siglo XIX se inició el consumo de los frutos en toda el área mediterránea, donde se adaptó muy bien a las zonas de cultivo de los cítricos.El cultivo intensivo comenzó a desarrollarse a finales de los años 60 y principios de los 70, cuando comenzaron a implantarse las variedades y técnicas de cultivo actualmente utilizadas.',400,9,7);
CALL add_producto ('FR-55','Olivo Cipresino','Frutales','','Frutales Talavera S.A','Existen dos hipótesis sobre el origen del olivo, una que postula que proviene de las costas de Siria, Líbano e Israel y otra que considera que lo considera originario de Asia menor. La llegada a Europa probablemente tuvo lugar de mano de los Fenicios, en transito por Chipre, Creta, e Islas del Mar Egeo, pasando a Grecia y más tarde a Italia. Los primeros indicios de la presencia del olivo en las costas mediterráneas españolas coinciden con el dominio romano, aunque fueron posteriormente los árabes los que impulsaron su cultivo en Andalucía, convirtiendo a España en el primer país productor de aceite de oliva a nivel mundial.',400,8,6);
CALL add_producto ('FR-56','Nectarina','Frutales','','Frutales Talavera S.A','',400,8,6);
CALL add_producto ('FR-57','Kaki Rojo Brillante','Frutales','','NaranjasValencianas.com','De crecimiento algo lento los primeros años, llega a alcanzar hasta doce metros de altura o más, aunque en cultivo se prefiere algo más bajo (5-6). Tronco corto y copa extendida. Ramifica muy poco debido a la dominancia apical. Porte más o menos piramidal, aunque con la edad se hace más globoso.',400,9,7);
CALL add_producto ('FR-58','Albaricoquero','Frutales','8/10','Melocotones de Cieza S.A.','árbol que puede pasar de los 6 m de altura, en la región mediterránea con ramas formando una copa redondeada. La corteza del tronco es pardo-violácea, agrietada; las ramas son rojizas y extendidas cuando jóvenes y las ramas secundarias son cortas, divergentes y escasas. Las yemas latentes son frecuentes especialmente sobre las ramas viejas.',200,11,8);
CALL add_producto ('FR-59','Albaricoquero','Frutales','10/12','Melocotones de Cieza S.A.','árbol que puede pasar de los 6 m de altura, en la región mediterránea con ramas formando una copa redondeada. La corteza del tronco es pardo-violácea, agrietada; las ramas son rojizas y extendidas cuando jóvenes y las ramas secundarias son cortas, divergentes y escasas. Las yemas latentes son frecuentes especialmente sobre las ramas viejas.',200,22,17);
CALL add_producto ('FR-6','Mandarino 2 años injerto','Frutales','','Frutales Talavera S.A','',15,7,5);
CALL add_producto ('FR-60','Albaricoquero','Frutales','12/14','Melocotones de Cieza S.A.','árbol que puede pasar de los 6 m de altura, en la región mediterránea con ramas formando una copa redondeada. La corteza del tronco es pardo-violácea, agrietada; las ramas son rojizas y extendidas cuando jóvenes y las ramas secundarias son cortas, divergentes y escasas. Las yemas latentes son frecuentes especialmente sobre las ramas viejas.',200,32,25);
CALL add_producto ('FR-61','Albaricoquero','Frutales','14/16','Melocotones de Cieza S.A.','árbol que puede pasar de los 6 m de altura, en la región mediterránea con ramas formando una copa redondeada. La corteza del tronco es pardo-violácea, agrietada; las ramas son rojizas y extendidas cuando jóvenes y las ramas secundarias son cortas, divergentes y escasas. Las yemas latentes son frecuentes especialmente sobre las ramas viejas.',200,49,39);
CALL add_producto ('FR-62','Albaricoquero','Frutales','16/18','Melocotones de Cieza S.A.','árbol que puede pasar de los 6 m de altura, en la región mediterránea con ramas formando una copa redondeada. La corteza del tronco es pardo-violácea, agrietada; las ramas son rojizas y extendidas cuando jóvenes y las ramas secundarias son cortas, divergentes y escasas. Las yemas latentes son frecuentes especialmente sobre las ramas viejas.',200,70,56);
CALL add_producto ('FR-63','Cerezo','Frutales','8/10','Jerte Distribuciones S.L.','Las principales especies de cerezo cultivadas en el mundo son el cerezo dulce (Prunus avium), el guindo (P. cerasus) y el cerezo \"Duke\", híbrido de los anteriores. Ambas especies son naturales del sureste de Europa y oeste de Asia. El cerezo dulce tuvo su origen probablemente en el mar Negro y en el mar Caspio, difundiéndose después hacia Europa y Asia, llevado por los pájaros y las migraciones humanas. Fue uno de los frutales más apreciados por los griegos y con el Imperio Romano se extendió a regiones muy diversas. En la actualidad, el cerezo se encuentra difundido por numerosas regiones y países del mundo con clima templado',300,11,8);
CALL add_producto ('FR-64','Cerezo','Frutales','10/12','Jerte Distribuciones S.L.','Las principales especies de cerezo cultivadas en el mundo son el cerezo dulce (Prunus avium), el guindo (P. cerasus) y el cerezo \"Duke\", híbrido de los anteriores. Ambas especies son naturales del sureste de Europa y oeste de Asia. El cerezo dulce tuvo su origen probablemente en el mar Negro y en el mar Caspio, difundiéndose después hacia Europa y Asia, llevado por los pájaros y las migraciones humanas. Fue uno de los frutales más apreciados por los griegos y con el Imperio Romano se extendió a regiones muy diversas. En la actualidad, el cerezo se encuentra difundido por numerosas regiones y países del mundo con clima templado',15,22,17);
CALL add_producto ('FR-65','Cerezo','Frutales','12/14','Jerte Distribuciones S.L.','Las principales especies de cerezo cultivadas en el mundo son el cerezo dulce (Prunus avium), el guindo (P. cerasus) y el cerezo \"Duke\", híbrido de los anteriores. Ambas especies son naturales del sureste de Europa y oeste de Asia. El cerezo dulce tuvo su origen probablemente en el mar Negro y en el mar Caspio, difundiéndose después hacia Europa y Asia, llevado por los pájaros y las migraciones humanas. Fue uno de los frutales más apreciados por los griegos y con el Imperio Romano se extendió a regiones muy diversas. En la actualidad, el cerezo se encuentra difundido por numerosas regiones y países del mundo con clima templado',200,32,25);
CALL add_producto ('FR-66','Cerezo','Frutales','14/16','Jerte Distribuciones S.L.','Las principales especies de cerezo cultivadas en el mundo son el cerezo dulce (Prunus avium), el guindo (P. cerasus) y el cerezo \"Duke\", híbrido de los anteriores. Ambas especies son naturales del sureste de Europa y oeste de Asia. El cerezo dulce tuvo su origen probablemente en el mar Negro y en el mar Caspio, difundiéndose después hacia Europa y Asia, llevado por los pájaros y las migraciones humanas. Fue uno de los frutales más apreciados por los griegos y con el Imperio Romano se extendió a regiones muy diversas. En la actualidad, el cerezo se encuentra difundido por numerosas regiones y países del mundo con clima templado',50,49,39);
CALL add_producto ('FR-67','Cerezo','Frutales','16/18','Jerte Distribuciones S.L.','Las principales especies de cerezo cultivadas en el mundo son el cerezo dulce (Prunus avium), el guindo (P. cerasus) y el cerezo \"Duke\", híbrido de los anteriores. Ambas especies son naturales del sureste de Europa y oeste de Asia. El cerezo dulce tuvo su origen probablemente en el mar Negro y en el mar Caspio, difundiéndose después hacia Europa y Asia, llevado por los pájaros y las migraciones humanas. Fue uno de los frutales más apreciados por los griegos y con el Imperio Romano se extendió a regiones muy diversas. En la actualidad, el cerezo se encuentra difundido por numerosas regiones y países del mundo con clima templado',50,70,56);
CALL add_producto ('FR-68','Cerezo','Frutales','18/20','Jerte Distribuciones S.L.','Las principales especies de cerezo cultivadas en el mundo son el cerezo dulce (Prunus avium), el guindo (P. cerasus) y el cerezo \"Duke\", híbrido de los anteriores. Ambas especies son naturales del sureste de Europa y oeste de Asia. El cerezo dulce tuvo su origen probablemente en el mar Negro y en el mar Caspio, difundiéndose después hacia Europa y Asia, llevado por los pájaros y las migraciones humanas. Fue uno de los frutales más apreciados por los griegos y con el Imperio Romano se extendió a regiones muy diversas. En la actualidad, el cerezo se encuentra difundido por numerosas regiones y países del mundo con clima templado',50,80,64);
CALL add_producto ('FR-69','Cerezo','Frutales','20/25','Jerte Distribuciones S.L.','Las principales especies de cerezo cultivadas en el mundo son el cerezo dulce (Prunus avium), el guindo (P. cerasus) y el cerezo \"Duke\", híbrido de los anteriores. Ambas especies son naturales del sureste de Europa y oeste de Asia. El cerezo dulce tuvo su origen probablemente en el mar Negro y en el mar Caspio, difundiéndose después hacia Europa y Asia, llevado por los pájaros y las migraciones humanas. Fue uno de los frutales más apreciados por los griegos y con el Imperio Romano se extendió a regiones muy diversas. En la actualidad, el cerezo se encuentra difundido por numerosas regiones y países del mundo con clima templado',50,91,72);
CALL add_producto ('FR-7','Mandarino calibre 8/10','Frutales','','Frutales Talavera S.A','',15,29,23);
CALL add_producto ('FR-70','Ciruelo','Frutales','8/10','Frutales Talavera S.A','árbol de tamaño mediano que alcanza una altura máxima de 5-6 m. Tronco de corteza pardo-azulada, brillante, lisa o agrietada longitudinalmente. Produce ramas alternas, pequeñas, delgadas, unas veces lisas, glabras y otras pubescentes y vellosas',50,11,8);
CALL add_producto ('FR-71','Ciruelo','Frutales','10/12','Frutales Talavera S.A','árbol de tamaño mediano que alcanza una altura máxima de 5-6 m. Tronco de corteza pardo-azulada, brillante, lisa o agrietada longitudinalmente. Produce ramas alternas, pequeñas, delgadas, unas veces lisas, glabras y otras pubescentes y vellosas',50,22,17);
CALL add_producto ('FR-72','Ciruelo','Frutales','12/14','Frutales Talavera S.A','árbol de tamaño mediano que alcanza una altura máxima de 5-6 m. Tronco de corteza pardo-azulada, brillante, lisa o agrietada longitudinalmente. Produce ramas alternas, pequeñas, delgadas, unas veces lisas, glabras y otras pubescentes y vellosas',50,32,25);
CALL add_producto ('FR-73','Granado','Frutales','8/10','Frutales Talavera S.A','pequeño árbol caducifolio, a veces con porte arbustivo, de 3 a 6 m de altura, con el tronco retorcido. Madera dura y corteza escamosa de color grisáceo. Las ramitas jóvenes son más o menos cuadrangulares o angostas y de cuatro alas, posteriormente se vuelven redondas con corteza de color café grisáceo, la mayoría de las ramas, pero especialmente las pequeñas ramitas axilares, son en forma de espina o terminan en una espina aguda; la copa es extendida.',50,13,10);
CALL add_producto ('FR-74','Granado','Frutales','10/12','Frutales Talavera S.A','pequeño árbol caducifolio, a veces con porte arbustivo, de 3 a 6 m de altura, con el tronco retorcido. Madera dura y corteza escamosa de color grisáceo. Las ramitas jóvenes son más o menos cuadrangulares o angostas y de cuatro alas, posteriormente se vuelven redondas con corteza de color café grisáceo, la mayoría de las ramas, pero especialmente las pequeñas ramitas axilares, son en forma de espina o terminan en una espina aguda; la copa es extendida.',50,22,17);
CALL add_producto ('FR-75','Granado','Frutales','12/14','Frutales Talavera S.A','pequeño árbol caducifolio, a veces con porte arbustivo, de 3 a 6 m de altura, con el tronco retorcido. Madera dura y corteza escamosa de color grisáceo. Las ramitas jóvenes son más o menos cuadrangulares o angostas y de cuatro alas, posteriormente se vuelven redondas con corteza de color café grisáceo, la mayoría de las ramas, pero especialmente las pequeñas ramitas axilares, son en forma de espina o terminan en una espina aguda; la copa es extendida.',50,32,25);
CALL add_producto ('FR-76','Granado','Frutales','14/16','Frutales Talavera S.A','pequeño árbol caducifolio, a veces con porte arbustivo, de 3 a 6 m de altura, con el tronco retorcido. Madera dura y corteza escamosa de color grisáceo. Las ramitas jóvenes son más o menos cuadrangulares o angostas y de cuatro alas, posteriormente se vuelven redondas con corteza de color café grisáceo, la mayoría de las ramas, pero especialmente las pequeñas ramitas axilares, son en forma de espina o terminan en una espina aguda; la copa es extendida.',50,49,39);
CALL add_producto ('FR-77','Granado','Frutales','16/18','Frutales Talavera S.A','pequeño árbol caducifolio, a veces con porte arbustivo, de 3 a 6 m de altura, con el tronco retorcido. Madera dura y corteza escamosa de color grisáceo. Las ramitas jóvenes son más o menos cuadrangulares o angostas y de cuatro alas, posteriormente se vuelven redondas con corteza de color café grisáceo, la mayoría de las ramas, pero especialmente las pequeñas ramitas axilares, son en forma de espina o terminan en una espina aguda; la copa es extendida.',50,70,56);
CALL add_producto ('FR-78','Higuera','Frutales','8/10','Frutales Talavera S.A','La higuera (Ficus carica L.) es un árbol típico de secano en los países mediterráneos. Su rusticidad y su fácil multiplicación hacen de la higuera un frutal muy apropiado para el cultivo extensivo.. Siempre ha sido considerado como árbol que no requiere cuidado alguno una vez plantado y arraigado, limitándose el hombre a recoger de él los frutos cuando maduran, unos para consumo en fresco y otros para conserva. Las únicas higueras con cuidados culturales esmerados, en muchas comarcas, son las brevales, por el interés económico de su primera cosecha, la de brevas.',50,15,12);
CALL add_producto ('FR-79','Higuera','Frutales','10/12','Frutales Talavera S.A','La higuera (Ficus carica L.) es un árbol típico de secano en los países mediterráneos. Su rusticidad y su fácil multiplicación hacen de la higuera un frutal muy apropiado para el cultivo extensivo.. Siempre ha sido considerado como árbol que no requiere cuidado alguno una vez plantado y arraigado, limitándose el hombre a recoger de él los frutos cuando maduran, unos para consumo en fresco y otros para conserva. Las únicas higueras con cuidados culturales esmerados, en muchas comarcas, son las brevales, por el interés económico de su primera cosecha, la de brevas.',50,22,17);
CALL add_producto ('FR-8','Limonero -Plantón joven','Frutales','','NaranjasValencianas.com','El limonero, pertenece al grupo de los cítricos, teniendo su origen hace unos 20 millones de años en el sudeste asiático. Fue introducido por los árabes en el área mediterránea entre los años 1.000 a 1.200, habiendo experimentando numerosas modificaciones debidas tanto a la selección natural mediante hibridaciones espontáneas como a las producidas por el',15,6,4);
CALL add_producto ('FR-80','Higuera','Frutales','12/14','Frutales Talavera S.A','La higuera (Ficus carica L.) es un árbol típico de secano en los países mediterráneos. Su rusticidad y su fácil multiplicación hacen de la higuera un frutal muy apropiado para el cultivo extensivo.. Siempre ha sido considerado como árbol que no requiere cuidado alguno una vez plantado y arraigado, limitándose el hombre a recoger de él los frutos cuando maduran, unos para consumo en fresco y otros para conserva. Las únicas higueras con cuidados culturales esmerados, en muchas comarcas, son las brevales, por el interés económico de su primera cosecha, la de brevas.',50,32,25);
CALL add_producto ('FR-81','Higuera','Frutales','14/16','Frutales Talavera S.A','La higuera (Ficus carica L.) es un árbol típico de secano en los países mediterráneos. Su rusticidad y su fácil multiplicación hacen de la higuera un frutal muy apropiado para el cultivo extensivo.. Siempre ha sido considerado como árbol que no requiere cuidado alguno una vez plantado y arraigado, limitándose el hombre a recoger de él los frutos cuando maduran, unos para consumo en fresco y otros para conserva. Las únicas higueras con cuidados culturales esmerados, en muchas comarcas, son las brevales, por el interés económico de su primera cosecha, la de brevas.',50,49,39);
CALL add_producto ('FR-82','Higuera','Frutales','16/18','Frutales Talavera S.A','La higuera (Ficus carica L.) es un árbol típico de secano en los países mediterráneos. Su rusticidad y su fácil multiplicación hacen de la higuera un frutal muy apropiado para el cultivo extensivo.. Siempre ha sido considerado como árbol que no requiere cuidado alguno una vez plantado y arraigado, limitándose el hombre a recoger de él los frutos cuando maduran, unos para consumo en fresco y otros para conserva. Las únicas higueras con cuidados culturales esmerados, en muchas comarcas, son las brevales, por el interés económico de su primera cosecha, la de brevas.',50,70,56);
CALL add_producto ('FR-83','Higuera','Frutales','18/20','Frutales Talavera S.A','La higuera (Ficus carica L.) es un árbol típico de secano en los países mediterráneos. Su rusticidad y su fácil multiplicación hacen de la higuera un frutal muy apropiado para el cultivo extensivo.. Siempre ha sido considerado como árbol que no requiere cuidado alguno una vez plantado y arraigado, limitándose el hombre a recoger de él los frutos cuando maduran, unos para consumo en fresco y otros para conserva. Las únicas higueras con cuidados culturales esmerados, en muchas comarcas, son las brevales, por el interés económico de su primera cosecha, la de brevas.',50,80,64);
CALL add_producto ('FR-84','Kaki','Frutales','8/10','NaranjasValencianas.com','De crecimiento algo lento los primeros años, llega a alcanzar hasta doce metros de altura o más, aunque en cultivo se prefiere algo más bajo (5-6). Tronco corto y copa extendida. Ramifica muy poco debido a la dominancia apical. Porte más o menos piramidal, aunque con la edad se hace más globoso.',50,13,10);
CALL add_producto ('FR-85','Kaki','Frutales','16/18','NaranjasValencianas.com','De crecimiento algo lento los primeros años, llega a alcanzar hasta doce metros de altura o más, aunque en cultivo se prefiere algo más bajo (5-6). Tronco corto y copa extendida. Ramifica muy poco debido a la dominancia apical. Porte más o menos piramidal, aunque con la edad se hace más globoso.',50,70,56);
CALL add_producto ('FR-86','Manzano','Frutales','8/10','Frutales Talavera S.A','alcanza como máximo 10 m. de altura y tiene una copa globosa. Tronco derecho que normalmente alcanza de 2 a 2,5 m. de altura, con corteza cubierta de lenticelas, lisa, adherida, de color ceniciento verdoso sobre los ramos y escamosa y gris parda sobre las partes viejas del árbol. Tiene una vida de unos 60-80 años. Las ramas se insertan en ángulo abierto sobre el tallo, de color verde oscuro, a veces tendiendo a negruzco o violáceo. Los brotes jóvenes terminan con frecuencia en una espina',50,11,8);
CALL add_producto ('FR-87','Manzano','Frutales','10/12','Frutales Talavera S.A','alcanza como máximo 10 m. de altura y tiene una copa globosa. Tronco derecho que normalmente alcanza de 2 a 2,5 m. de altura, con corteza cubierta de lenticelas, lisa, adherida, de color ceniciento verdoso sobre los ramos y escamosa y gris parda sobre las partes viejas del árbol. Tiene una vida de unos 60-80 años. Las ramas se insertan en ángulo abierto sobre el tallo, de color verde oscuro, a veces tendiendo a negruzco o violáceo. Los brotes jóvenes terminan con frecuencia en una espina',50,22,17);
CALL add_producto ('FR-88','Manzano','Frutales','12/14','Frutales Talavera S.A','alcanza como máximo 10 m. de altura y tiene una copa globosa. Tronco derecho que normalmente alcanza de 2 a 2,5 m. de altura, con corteza cubierta de lenticelas, lisa, adherida, de color ceniciento verdoso sobre los ramos y escamosa y gris parda sobre las partes viejas del árbol. Tiene una vida de unos 60-80 años. Las ramas se insertan en ángulo abierto sobre el tallo, de color verde oscuro, a veces tendiendo a negruzco o violáceo. Los brotes jóvenes terminan con frecuencia en una espina',50,32,25);
CALL add_producto ('FR-89','Manzano','Frutales','14/16','Frutales Talavera S.A','alcanza como máximo 10 m. de altura y tiene una copa globosa. Tronco derecho que normalmente alcanza de 2 a 2,5 m. de altura, con corteza cubierta de lenticelas, lisa, adherida, de color ceniciento verdoso sobre los ramos y escamosa y gris parda sobre las partes viejas del árbol. Tiene una vida de unos 60-80 años. Las ramas se insertan en ángulo abierto sobre el tallo, de color verde oscuro, a veces tendiendo a negruzco o violáceo. Los brotes jóvenes terminan con frecuencia en una espina',50,49,39);
CALL add_producto ('FR-9','Limonero calibre 8/10','Frutales','','NaranjasValencianas.com','El limonero, pertenece al grupo de los cítricos, teniendo su origen hace unos 20 millones de años en el sudeste asiático. Fue introducido por los árabes en el área mediterránea entre los años 1.000 a 1.200, habiendo experimentando numerosas modificaciones debidas tanto a la selección natural mediante hibridaciones espontáneas como a las producidas por el',15,29,23);
CALL add_producto ('FR-90','Níspero','Frutales','16/18','Frutales Talavera S.A','Aunque originario del Sudeste de China, el níspero llegó a Europa procedente de Japón en el siglo XVIII como árbol ornamental. En el siglo XIX se inició el consumo de los frutos en toda el área mediterránea, donde se adaptó muy bien a las zonas de cultivo de los cítricos.El cultivo intensivo comenzó a desarrollarse a finales de los años 60 y principios de los 70, cuando comenzaron a implantarse las variedades y técnicas de cultivo actualmente utilizadas.',50,70,56);
CALL add_producto ('FR-91','Níspero','Frutales','18/20','Frutales Talavera S.A','Aunque originario del Sudeste de China, el níspero llegó a Europa procedente de Japón en el siglo XVIII como árbol ornamental. En el siglo XIX se inició el consumo de los frutos en toda el área mediterránea, donde se adaptó muy bien a las zonas de cultivo de los cítricos.El cultivo intensivo comenzó a desarrollarse a finales de los años 60 y principios de los 70, cuando comenzaron a implantarse las variedades y técnicas de cultivo actualmente utilizadas.',50,80,64);
CALL add_producto ('FR-92','Melocotonero','Frutales','8/10','Melocotones de Cieza S.A.','Árbol caducifolio de porte bajo con corteza lisa, de color ceniciento. Sus hojas son alargadas con el margen ligeramente aserrado, de color verde brillante, algo más claras por el envés. El melocotonero está muy arraigado en la cultura asiática.\r\nEn Japón, el noble heroe Momotaro, una especie de Cid japonés, nació del interior de un enorme melocotón que flotaba río abajo.\r\nEn China se piensa que comer melocotón confiere longevidad al ser humano, ya que formaba parte de la dieta de sus dioses inmortales.',50,11,8);
CALL add_producto ('FR-93','Melocotonero','Frutales','10/12','Melocotones de Cieza S.A.','Árbol caducifolio de porte bajo con corteza lisa, de color ceniciento. Sus hojas son alargadas con el margen ligeramente aserrado, de color verde brillante, algo más claras por el envés. El melocotonero está muy arraigado en la cultura asiática.\r\nEn Japón, el noble heroe Momotaro, una especie de Cid japonés, nació del interior de un enorme melocotón que flotaba río abajo.\r\nEn China se piensa que comer melocotón confiere longevidad al ser humano, ya que formaba parte de la dieta de sus dioses inmortales.',50,22,17);
CALL add_producto ('FR-94','Melocotonero','Frutales','12/14','Melocotones de Cieza S.A.','Árbol caducifolio de porte bajo con corteza lisa, de color ceniciento. Sus hojas son alargadas con el margen ligeramente aserrado, de color verde brillante, algo más claras por el envés. El melocotonero está muy arraigado en la cultura asiática.\r\nEn Japón, el noble heroe Momotaro, una especie de Cid japonés, nació del interior de un enorme melocotón que flotaba río abajo.\r\nEn China se piensa que comer melocotón confiere longevidad al ser humano, ya que formaba parte de la dieta de sus dioses inmortales.',50,32,25);
CALL add_producto ('FR-95','Melocotonero','Frutales','14/16','Melocotones de Cieza S.A.','Árbol caducifolio de porte bajo con corteza lisa, de color ceniciento. Sus hojas son alargadas con el margen ligeramente aserrado, de color verde brillante, algo más claras por el envés. El melocotonero está muy arraigado en la cultura asiática.\r\nEn Japón, el noble heroe Momotaro, una especie de Cid japonés, nació del interior de un enorme melocotón que flotaba río abajo.\r\nEn China se piensa que comer melocotón confiere longevidad al ser humano, ya que formaba parte de la dieta de sus dioses inmortales.',50,49,39);
CALL add_producto ('FR-96','Membrillero','Frutales','8/10','Frutales Talavera S.A','arbolito caducifolio de 4-6 m de altura con el tronco tortuoso y la corteza lisa, grisácea, que se desprende en escamas con la edad. Copa irregular, con ramas inermes, flexuosas, parduzcas, punteadas. Ramillas jóvenes tomentosas',50,11,8);
CALL add_producto ('FR-97','Membrillero','Frutales','10/12','Frutales Talavera S.A','arbolito caducifolio de 4-6 m de altura con el tronco tortuoso y la corteza lisa, grisácea, que se desprende en escamas con la edad. Copa irregular, con ramas inermes, flexuosas, parduzcas, punteadas. Ramillas jóvenes tomentosas',50,22,17);
CALL add_producto ('FR-98','Membrillero','Frutales','12/14','Frutales Talavera S.A','arbolito caducifolio de 4-6 m de altura con el tronco tortuoso y la corteza lisa, grisácea, que se desprende en escamas con la edad. Copa irregular, con ramas inermes, flexuosas, parduzcas, punteadas. Ramillas jóvenes tomentosas',50,32,25);
CALL add_producto ('FR-99','Membrillero','Frutales','14/16','Frutales Talavera S.A','arbolito caducifolio de 4-6 m de altura con el tronco tortuoso y la corteza lisa, grisácea, que se desprende en escamas con la edad. Copa irregular, con ramas inermes, flexuosas, parduzcas, punteadas. Ramillas jóvenes tomentosas',50,49,39);
CALL add_producto ('OR-001','Arbustos Mix Maceta','Ornamentales','40-60','Valencia Garden Service','',25,5,4);
CALL add_producto ('OR-100','Mimosa Injerto CLASICA Dealbata ','Ornamentales','100-110','Viveros EL OASIS','Acacia dealbata. Nombre común o vulgar: Mimosa fina, Mimosa, Mimosa común, Mimosa plateada, Aromo francés. Familia: Mimosaceae. Origen: Australia, Sureste, (N. G. del Sur y Victoria). Arbol de follaje persistente muy usado en parques por su atractiva floración amarilla hacia fines del invierno. Altura: de 3 a 10 metros generalmente. Crecimiento rápido. Follaje perenne de tonos plateados, muy ornamental. Sus hojas son de textura fina, de color verde y sus flores amarillas que aparecen en racimos grandes. Florece de Enero a Marzo (Hemisferio Norte). Legumbre de 5-9 cm de longitud, recta o ligeramente curvada, con los bordes algo constreñidos entre las semillas, que se disponen en el fruto longitudinalmente...',100,12,9);
CALL add_producto ('OR-101','Expositor Mimosa Semilla Mix','Ornamentales','170-200','Viveros EL OASIS','Acacia dealbata. Nombre común o vulgar: Mimosa fina, Mimosa, Mimosa común, Mimosa plateada, Aromo francés. Familia: Mimosaceae. Origen: Australia, Sureste, (N. G. del Sur y Victoria). Arbol de follaje persistente muy usado en parques por su atractiva floración amarilla hacia fines del invierno. Altura: de 3 a 10 metros generalmente. Crecimiento rápido. Follaje perenne de tonos plateados, muy ornamental. Sus hojas son de textura fina, de color verde y sus flores amarillas que aparecen en racimos grandes. Florece de Enero a Marzo (Hemisferio Norte). Legumbre de 5-9 cm de longitud, recta o ligeramente curvada, con los bordes algo constreñidos entre las semillas, que se disponen en el fruto longitudinalmente...',100,6,4);
CALL add_producto ('OR-102','Mimosa Semilla Bayleyana  ','Ornamentales','170-200','Viveros EL OASIS','Acacia dealbata. Nombre común o vulgar: Mimosa fina, Mimosa, Mimosa común, Mimosa plateada, Aromo francés. Familia: Mimosaceae. Origen: Australia, Sureste, (N. G. del Sur y Victoria). Arbol de follaje persistente muy usado en parques por su atractiva floración amarilla hacia fines del invierno. Altura: de 3 a 10 metros generalmente. Crecimiento rápido. Follaje perenne de tonos plateados, muy ornamental. Sus hojas son de textura fina, de color verde y sus flores amarillas que aparecen en racimos grandes. Florece de Enero a Marzo (Hemisferio Norte). Legumbre de 5-9 cm de longitud, recta o ligeramente curvada, con los bordes algo constreñidos entre las semillas, que se disponen en el fruto longitudinalmente...',100,6,4);
CALL add_producto ('OR-103','Mimosa Semilla Bayleyana   ','Ornamentales','200-225','Viveros EL OASIS','Acacia dealbata. Nombre común o vulgar: Mimosa fina, Mimosa, Mimosa común, Mimosa plateada, Aromo francés. Familia: Mimosaceae. Origen: Australia, Sureste, (N. G. del Sur y Victoria). Arbol de follaje persistente muy usado en parques por su atractiva floración amarilla hacia fines del invierno. Altura: de 3 a 10 metros generalmente. Crecimiento rápido. Follaje perenne de tonos plateados, muy ornamental. Sus hojas son de textura fina, de color verde y sus flores amarillas que aparecen en racimos grandes. Florece de Enero a Marzo (Hemisferio Norte). Legumbre de 5-9 cm de longitud, recta o ligeramente curvada, con los bordes algo constreñidos entre las semillas, que se disponen en el fruto longitudinalmente...',100,10,8);
CALL add_producto ('OR-104','Mimosa Semilla Cyanophylla    ','Ornamentales','200-225','Viveros EL OASIS','Acacia dealbata. Nombre común o vulgar: Mimosa fina, Mimosa, Mimosa común, Mimosa plateada, Aromo francés. Familia: Mimosaceae. Origen: Australia, Sureste, (N. G. del Sur y Victoria). Arbol de follaje persistente muy usado en parques por su atractiva floración amarilla hacia fines del invierno. Altura: de 3 a 10 metros generalmente. Crecimiento rápido. Follaje perenne de tonos plateados, muy ornamental. Sus hojas son de textura fina, de color verde y sus flores amarillas que aparecen en racimos grandes. Florece de Enero a Marzo (Hemisferio Norte). Legumbre de 5-9 cm de longitud, recta o ligeramente curvada, con los bordes algo constreñidos entre las semillas, que se disponen en el fruto longitudinalmente...',100,10,8);
CALL add_producto ('OR-105','Mimosa Semilla Espectabilis  ','Ornamentales','160-170','Viveros EL OASIS','Acacia dealbata. Nombre común o vulgar: Mimosa fina, Mimosa, Mimosa común, Mimosa plateada, Aromo francés. Familia: Mimosaceae. Origen: Australia, Sureste, (N. G. del Sur y Victoria). Arbol de follaje persistente muy usado en parques por su atractiva floración amarilla hacia fines del invierno. Altura: de 3 a 10 metros generalmente. Crecimiento rápido. Follaje perenne de tonos plateados, muy ornamental. Sus hojas son de textura fina, de color verde y sus flores amarillas que aparecen en racimos grandes. Florece de Enero a Marzo (Hemisferio Norte). Legumbre de 5-9 cm de longitud, recta o ligeramente curvada, con los bordes algo constreñidos entre las semillas, que se disponen en el fruto longitudinalmente...',100,6,4);
CALL add_producto ('OR-106','Mimosa Semilla Longifolia   ','Ornamentales','200-225','Viveros EL OASIS','Acacia dealbata. Nombre común o vulgar: Mimosa fina, Mimosa, Mimosa común, Mimosa plateada, Aromo francés. Familia: Mimosaceae. Origen: Australia, Sureste, (N. G. del Sur y Victoria). Arbol de follaje persistente muy usado en parques por su atractiva floración amarilla hacia fines del invierno. Altura: de 3 a 10 metros generalmente. Crecimiento rápido. Follaje perenne de tonos plateados, muy ornamental. Sus hojas son de textura fina, de color verde y sus flores amarillas que aparecen en racimos grandes. Florece de Enero a Marzo (Hemisferio Norte). Legumbre de 5-9 cm de longitud, recta o ligeramente curvada, con los bordes algo constreñidos entre las semillas, que se disponen en el fruto longitudinalmente...',100,10,8);
CALL add_producto ('OR-107','Mimosa Semilla Floribunda 4 estaciones','Ornamentales','120-140','Viveros EL OASIS','Acacia dealbata. Nombre común o vulgar: Mimosa fina, Mimosa, Mimosa común, Mimosa plateada, Aromo francés. Familia: Mimosaceae. Origen: Australia, Sureste, (N. G. del Sur y Victoria). Arbol de follaje persistente muy usado en parques por su atractiva floración amarilla hacia fines del invierno. Altura: de 3 a 10 metros generalmente. Crecimiento rápido. Follaje perenne de tonos plateados, muy ornamental. Sus hojas son de textura fina, de color verde y sus flores amarillas que aparecen en racimos grandes. Florece de Enero a Marzo (Hemisferio Norte). Legumbre de 5-9 cm de longitud, recta o ligeramente curvada, con los bordes algo constreñidos entre las semillas, que se disponen en el fruto longitudinalmente...',100,6,4);
CALL add_producto ('OR-108','Abelia Floribunda','Ornamentales','35-45','Viveros EL OASIS','',100,5,4);
CALL add_producto ('OR-109','Callistemom (Mix)','Ornamentales','35-45','Viveros EL OASIS','Limpitatubos. arbolito de 6-7 m de altura. Ramas flexibles y colgantes (de ahí lo de \"llorón\")..',100,5,4);
CALL add_producto ('OR-110','Callistemom (Mix)','Ornamentales','40-60','Viveros EL OASIS','Limpitatubos. arbolito de 6-7 m de altura. Ramas flexibles y colgantes (de ahí lo de \"llorón\")..',100,2,1);
CALL add_producto ('OR-111','Corylus Avellana \"Contorta\"','Ornamentales','35-45','Viveros EL OASIS','',100,5,4);
CALL add_producto ('OR-112','Escallonia (Mix)','Ornamentales','35-45','Viveros EL OASIS','',120,5,4);
CALL add_producto ('OR-113','Evonimus Emerald Gayeti','Ornamentales','35-45','Viveros EL OASIS','',120,5,4);
CALL add_producto ('OR-114','Evonimus Pulchellus','Ornamentales','35-45','Viveros EL OASIS','',120,5,4);
CALL add_producto ('OR-115','Forsytia Intermedia \"Lynwood\"','Ornamentales','35-45','Viveros EL OASIS','',120,7,5);
CALL add_producto ('OR-116','Hibiscus Syriacus  \"Diana\" -Blanco Puro','Ornamentales','35-45','Viveros EL OASIS','Por su capacidad de soportar podas, pueden ser fácilmente moldeadas como bonsái en el transcurso de pocos años. Flores de muchos colores según la variedad, desde el blanco puro al rojo intenso, del amarillo al anaranjado. La flor apenas dura 1 día, pero continuamente aparecen nuevas y la floración se prolonga durante todo el periodo de crecimiento vegetativo.',120,7,5);
CALL add_producto ('OR-117','Hibiscus Syriacus  \"Helene\" -Blanco-C.rojo','Ornamentales','35-45','Viveros EL OASIS','Por su capacidad de soportar podas, pueden ser fácilmente moldeadas como bonsái en el transcurso de pocos años. Flores de muchos colores según la variedad, desde el blanco puro al rojo intenso, del amarillo al anaranjado. La flor apenas dura 1 día, pero continuamente aparecen nuevas y la floración se prolonga durante todo el periodo de crecimiento vegetativo.',120,7,5);
CALL add_producto ('OR-118','Hibiscus Syriacus \"Pink Giant\" Rosa','Ornamentales','35-45','Viveros EL OASIS','Por su capacidad de soportar podas, pueden ser fácilmente moldeadas como bonsái en el transcurso de pocos años. Flores de muchos colores según la variedad, desde el blanco puro al rojo intenso, del amarillo al anaranjado. La flor apenas dura 1 día, pero continuamente aparecen nuevas y la floración se prolonga durante todo el periodo de crecimiento vegetativo.',120,7,5);
CALL add_producto ('OR-119','Laurus Nobilis Arbusto - Ramificado Bajo','Ornamentales','40-50','Viveros EL OASIS','',120,5,4);
CALL add_producto ('OR-120','Lonicera Nitida ','Ornamentales','35-45','Viveros EL OASIS','',120,5,4);
CALL add_producto ('OR-121','Lonicera Nitida \"Maigrum\"','Ornamentales','35-45','Viveros EL OASIS','',120,5,4);
CALL add_producto ('OR-122','Lonicera Pileata','Ornamentales','35-45','Viveros EL OASIS','',120,5,4);
CALL add_producto ('OR-123','Philadelphus \"Virginal\"','Ornamentales','35-45','Viveros EL OASIS','',120,5,4);
CALL add_producto ('OR-124','Prunus pisardii  ','Ornamentales','35-45','Viveros EL OASIS','',120,5,4);
CALL add_producto ('OR-125','Viburnum Tinus \"Eve Price\"','Ornamentales','35-45','Viveros EL OASIS','',120,5,4);
CALL add_producto ('OR-126','Weigelia \"Bristol Ruby\"','Ornamentales','35-45','Viveros EL OASIS','',120,5,4);
CALL add_producto ('OR-127','Camelia japonica','Ornamentales','40-60','Viveros EL OASIS','Arbusto excepcional por su floración otoñal, invernal o primaveral. Flores: Las flores son solitarias, aparecen en el ápice de cada rama, y son con una corola simple o doble, y comprendiendo varios colores. Suelen medir unos 7-12 cm de diÃ metro y tienen 5 sépalos y 5 pétalos. Estambres numerosos unidos en la mitad o en 2/3 de su longitud.',50,7,5);
CALL add_producto ('OR-128','Camelia japonica ejemplar','Ornamentales','200-250','Viveros EL OASIS','Arbusto excepcional por su floración otoñal, invernal o primaveral. Flores: Las flores son solitarias, aparecen en el ápice de cada rama, y son con una corola simple o doble, y comprendiendo varios colores. Suelen medir unos 7-12 cm de diÃ metro y tienen 5 sépalos y 5 pétalos. Estambres numerosos unidos en la mitad o en 2/3 de su longitud.',50,98,78);
CALL add_producto ('OR-129','Camelia japonica ejemplar','Ornamentales','250-300','Viveros EL OASIS','Arbusto excepcional por su floración otoñal, invernal o primaveral. Flores: Las flores son solitarias, aparecen en el ápice de cada rama, y son con una corola simple o doble, y comprendiendo varios colores. Suelen medir unos 7-12 cm de diÃ metro y tienen 5 sépalos y 5 pétalos. Estambres numerosos unidos en la mitad o en 2/3 de su longitud.',50,110,88);
CALL add_producto ('OR-130','Callistemom COPA','Ornamentales','110/120','Viveros EL OASIS','Limpitatubos. arbolito de 6-7 m de altura. Ramas flexibles y colgantes (de ahí lo de \"llorón\")..',50,18,14);
CALL add_producto ('OR-131','Leptospermum formado PIRAMIDE','Ornamentales','80-100','Viveros EL OASIS','',50,18,14);
CALL add_producto ('OR-132','Leptospermum COPA','Ornamentales','110/120','Viveros EL OASIS','',50,18,14);
CALL add_producto ('OR-133','Nerium oleander-CALIDAD \"GARDEN\"','Ornamentales','40-45','Viveros EL OASIS','',50,2,1);
CALL add_producto ('OR-134','Nerium Oleander Arbusto GRANDE','Ornamentales','160-200','Viveros EL OASIS','',100,38,30);
CALL add_producto ('OR-135','Nerium oleander COPA  Calibre 6/8','Ornamentales','50-60','Viveros EL OASIS','',100,5,4);
CALL add_producto ('OR-136','Nerium oleander ARBOL Calibre 8/10','Ornamentales','225-250','Viveros EL OASIS','',100,18,14);
CALL add_producto ('OR-137','ROSAL TREPADOR','Ornamentales','','Viveros EL OASIS','',100,4,3);
CALL add_producto ('OR-138','Camelia Blanco, Chrysler Rojo, Soraya Naranja, ','Ornamentales','','Viveros EL OASIS','',100,4,3);
CALL add_producto ('OR-139','Landora Amarillo, Rose Gaujard bicolor blanco-rojo','Ornamentales','','Viveros EL OASIS','',100,4,3);
CALL add_producto ('OR-140','Kordes Perfect bicolor rojo-amarillo, Roundelay rojo fuerte','Ornamentales','','Viveros EL OASIS','',100,4,3);
CALL add_producto ('OR-141','Pitimini rojo','Ornamentales','','Viveros EL OASIS','',100,4,3);
CALL add_producto ('OR-142','Solanum Jazminoide','Ornamentales','150-160','Viveros EL OASIS','',100,2,1);
CALL add_producto ('OR-143','Wisteria Sinensis  azul, rosa, blanca','Ornamentales','','Viveros EL OASIS','',100,9,7);
CALL add_producto ('OR-144','Wisteria Sinensis INJERTADAS DECÃ“','Ornamentales','140-150','Viveros EL OASIS','',100,12,9);
CALL add_producto ('OR-145','Bougamvillea Sanderiana Tutor','Ornamentales','80-100','Viveros EL OASIS','',100,2,1);
CALL add_producto ('OR-146','Bougamvillea Sanderiana Tutor','Ornamentales','125-150','Viveros EL OASIS','',100,4,3);
CALL add_producto ('OR-147','Bougamvillea Sanderiana Tutor','Ornamentales','180-200','Viveros EL OASIS','',100,7,5);
CALL add_producto ('OR-148','Bougamvillea Sanderiana Espaldera','Ornamentales','45-50','Viveros EL OASIS','',100,7,5);
CALL add_producto ('OR-149','Bougamvillea Sanderiana Espaldera','Ornamentales','140-150','Viveros EL OASIS','',100,17,13);
CALL add_producto ('OR-150','Bougamvillea roja, naranja','Ornamentales','110-130','Viveros EL OASIS','',100,2,1);
CALL add_producto ('OR-151','Bougamvillea Sanderiana, 3 tut. piramide','Ornamentales','','Viveros EL OASIS','',100,6,4);
CALL add_producto ('OR-152','Expositor Árboles clima continental','Ornamentales','170-200','Viveros EL OASIS','',100,6,4);
CALL add_producto ('OR-153','Expositor Árboles clima mediterráneo','Ornamentales','170-200','Viveros EL OASIS','',100,6,4);
CALL add_producto ('OR-154','Expositor Árboles borde del mar','Ornamentales','170-200','Viveros EL OASIS','',100,6,4);
CALL add_producto ('OR-155','Acer Negundo  ','Ornamentales','200-225','Viveros EL OASIS','',100,6,4);
CALL add_producto ('OR-156','Acer platanoides  ','Ornamentales','200-225','Viveros EL OASIS','',100,10,8);
CALL add_producto ('OR-157','Acer Pseudoplatanus ','Ornamentales','200-225','Viveros EL OASIS','',100,10,8);
CALL add_producto ('OR-158','Brachychiton Acerifolius  ','Ornamentales','200-225','Viveros EL OASIS','',100,6,4);
CALL add_producto ('OR-159','Brachychiton Discolor  ','Ornamentales','200-225','Viveros EL OASIS','',100,6,4);
CALL add_producto ('OR-160','Brachychiton Rupestris','Ornamentales','170-200','Viveros EL OASIS','',100,10,8);
CALL add_producto ('OR-161','Cassia Corimbosa  ','Ornamentales','200-225','Viveros EL OASIS','',100,6,4);
CALL add_producto ('OR-162','Cassia Corimbosa ','Ornamentales','200-225','Viveros EL OASIS','',100,10,8);
CALL add_producto ('OR-163','Chitalpa Summer Bells   ','Ornamentales','200-225','Viveros EL OASIS','',80,10,8);
CALL add_producto ('OR-164','Erytrina Kafra','Ornamentales','170-180','Viveros EL OASIS','',80,6,4);
CALL add_producto ('OR-165','Erytrina Kafra','Ornamentales','200-225','Viveros EL OASIS','',80,10,8);
CALL add_producto ('OR-166','Eucalyptus Citriodora  ','Ornamentales','170-200','Viveros EL OASIS','',80,6,4);
CALL add_producto ('OR-167','Eucalyptus Ficifolia  ','Ornamentales','170-200','Viveros EL OASIS','',80,6,4);
CALL add_producto ('OR-168','Eucalyptus Ficifolia   ','Ornamentales','200-225','Viveros EL OASIS','',80,10,8);
CALL add_producto ('OR-169','Hibiscus Syriacus  Var. Injertadas 1 Tallo ','Ornamentales','170-200','Viveros EL OASIS','',80,12,9);
CALL add_producto ('OR-170','Lagunaria Patersonii  ','Ornamentales','140-150','Viveros EL OASIS','',80,6,4);
CALL add_producto ('OR-171','Lagunaria Patersonii   ','Ornamentales','200-225','Viveros EL OASIS','',80,10,8);
CALL add_producto ('OR-172','Lagunaria patersonii  calibre 8/10','Ornamentales','200-225','Viveros EL OASIS','',80,18,14);
CALL add_producto ('OR-173','Morus Alba  ','Ornamentales','200-225','Viveros EL OASIS','',80,6,4);
CALL add_producto ('OR-174','Morus Alba  calibre 8/10','Ornamentales','200-225','Viveros EL OASIS','',80,18,14);
CALL add_producto ('OR-175','Platanus Acerifolia   ','Ornamentales','200-225','Viveros EL OASIS','',80,10,8);
CALL add_producto ('OR-176','Prunus pisardii  ','Ornamentales','200-225','Viveros EL OASIS','',80,10,8);
CALL add_producto ('OR-177','Robinia Pseudoacacia Casque Rouge   ','Ornamentales','200-225','Viveros EL OASIS','',80,15,12);
CALL add_producto ('OR-178','Salix Babylonica  Pendula  ','Ornamentales','170-200','Viveros EL OASIS','',80,6,4);
CALL add_producto ('OR-179','Sesbania Punicea   ','Ornamentales','170-200','Viveros EL OASIS','',80,6,4);
CALL add_producto ('OR-180','Tamarix  Ramosissima Pink Cascade   ','Ornamentales','170-200','Viveros EL OASIS','',80,6,4);
CALL add_producto ('OR-181','Tamarix  Ramosissima Pink Cascade   ','Ornamentales','200-225','Viveros EL OASIS','',80,10,8);
CALL add_producto ('OR-182','Tecoma Stands   ','Ornamentales','200-225','Viveros EL OASIS','',80,6,4);
CALL add_producto ('OR-183','Tecoma Stands  ','Ornamentales','200-225','Viveros EL OASIS','',80,10,8);
CALL add_producto ('OR-184','Tipuana Tipu  ','Ornamentales','170-200','Viveros EL OASIS','',80,6,4);
CALL add_producto ('OR-185','Pleioblastus distichus-Bambú enano','Ornamentales','15-20','Viveros EL OASIS','',80,6,4);
CALL add_producto ('OR-186','Sasa palmata ','Ornamentales','20-30','Viveros EL OASIS','',80,6,4);
CALL add_producto ('OR-187','Sasa palmata ','Ornamentales','40-45','Viveros EL OASIS','',80,10,8);
CALL add_producto ('OR-188','Sasa palmata ','Ornamentales','50-60','Viveros EL OASIS','',80,25,20);
CALL add_producto ('OR-189','Phylostachys aurea','Ornamentales','180-200','Viveros EL OASIS','',80,22,17);
CALL add_producto ('OR-190','Phylostachys aurea','Ornamentales','250-300','Viveros EL OASIS','',80,32,25);
CALL add_producto ('OR-191','Phylostachys Bambusa Spectabilis','Ornamentales','180-200','Viveros EL OASIS','',80,24,19);
CALL add_producto ('OR-192','Phylostachys biseti','Ornamentales','160-170','Viveros EL OASIS','',80,22,17);
CALL add_producto ('OR-193','Phylostachys biseti','Ornamentales','160-180','Viveros EL OASIS','',80,20,16);
CALL add_producto ('OR-194','Pseudosasa japonica (Metake)','Ornamentales','225-250','Viveros EL OASIS','',80,20,16);
CALL add_producto ('OR-195','Pseudosasa japonica (Metake) ','Ornamentales','30-40','Viveros EL OASIS','',80,6,4);
CALL add_producto ('OR-196','Cedrus Deodara ','Ornamentales','80-100','Viveros EL OASIS','',80,10,8);
CALL add_producto ('OR-197','Cedrus Deodara \"Feeling Blue\" Novedad','Ornamentales','rastrero','Viveros EL OASIS','',80,12,9);
CALL add_producto ('OR-198','Juniperus chinensis \"Blue Alps\"','Ornamentales','20-30','Viveros EL OASIS','',80,4,3);
CALL add_producto ('OR-199','Juniperus Chinensis Stricta','Ornamentales','20-30','Viveros EL OASIS','',80,4,3);
CALL add_producto ('OR-200','Juniperus horizontalis Wiltonii','Ornamentales','20-30','Viveros EL OASIS','',80,4,3);
CALL add_producto ('OR-201','Juniperus squamata \"Blue Star\"','Ornamentales','20-30','Viveros EL OASIS','',80,4,3);
CALL add_producto ('OR-202','Juniperus x media Phitzeriana verde','Ornamentales','20-30','Viveros EL OASIS','',80,4,3);
CALL add_producto ('OR-203','Pinus Canariensis','Ornamentales','80-100','Viveros EL OASIS','',80,10,8);
CALL add_producto ('OR-204','Pinus Halepensis','Ornamentales','160-180','Viveros EL OASIS','',80,10,8);
CALL add_producto ('OR-205','Pinus Pinea -Pino Piñonero','Ornamentales','70-80','Viveros EL OASIS','',80,10,8);
CALL add_producto ('OR-206','Thuja Esmeralda ','Ornamentales','80-100','Viveros EL OASIS','',80,5,4);
CALL add_producto ('OR-207','Tuja Occidentalis Woodwardii','Ornamentales','20-30','Viveros EL OASIS','',80,4,3);
CALL add_producto ('OR-208','Tuja orientalis \"Aurea nana\"','Ornamentales','20-30','Viveros EL OASIS','',80,4,3);
CALL add_producto ('OR-209','Archontophoenix Cunninghamiana','Ornamentales','80 - 100','Viveros EL OASIS','',80,10,8);
CALL add_producto ('OR-210','Beucarnea Recurvata','Ornamentales','130  - 150','Viveros EL OASIS','',2,39,31);
CALL add_producto ('OR-211','Beucarnea Recurvata','Ornamentales','180 - 200','Viveros EL OASIS','',5,59,47);
CALL add_producto ('OR-212','Bismarckia Nobilis','Ornamentales','200 - 220','Viveros EL OASIS','',4,217,173);
CALL add_producto ('OR-213','Bismarckia Nobilis','Ornamentales','240 - 260','Viveros EL OASIS','',4,266,212);
CALL add_producto ('OR-214','Brahea Armata','Ornamentales','45 - 60','Viveros EL OASIS','',0,10,8);
CALL add_producto ('OR-215','Brahea Armata','Ornamentales','120 - 140','Viveros EL OASIS','',100,112,89);
CALL add_producto ('OR-216','Brahea Edulis','Ornamentales','80 - 100','Viveros EL OASIS','',100,19,15);
CALL add_producto ('OR-217','Brahea Edulis','Ornamentales','140 - 160','Viveros EL OASIS','',100,64,51);
CALL add_producto ('OR-218','Butia Capitata','Ornamentales','70 - 90','Viveros EL OASIS','',100,25,20);
CALL add_producto ('OR-219','Butia Capitata','Ornamentales','90 - 110','Viveros EL OASIS','',100,29,23);
CALL add_producto ('OR-220','Butia Capitata','Ornamentales','90 - 120','Viveros EL OASIS','',100,36,28);
CALL add_producto ('OR-221','Butia Capitata','Ornamentales','85 - 105','Viveros EL OASIS','',100,59,47);
CALL add_producto ('OR-222','Butia Capitata','Ornamentales','130 - 150','Viveros EL OASIS','',100,87,69);
CALL add_producto ('OR-223','Chamaerops Humilis','Ornamentales','40 - 45','Viveros EL OASIS','',100,4,3);
CALL add_producto ('OR-224','Chamaerops Humilis','Ornamentales','50 - 60','Viveros EL OASIS','',100,7,5);
CALL add_producto ('OR-225','Chamaerops Humilis','Ornamentales','70 - 90','Viveros EL OASIS','',100,10,8);
CALL add_producto ('OR-226','Chamaerops Humilis','Ornamentales','115 - 130','Viveros EL OASIS','',100,38,30);
CALL add_producto ('OR-227','Chamaerops Humilis','Ornamentales','130 - 150','Viveros EL OASIS','',100,64,51);
CALL add_producto ('OR-228','Chamaerops Humilis \"Cerifera\"','Ornamentales','70 - 80','Viveros EL OASIS','',100,32,25);
CALL add_producto ('OR-229','Chrysalidocarpus Lutescens -ARECA','Ornamentales','130 - 150','Viveros EL OASIS','',100,22,17);
CALL add_producto ('OR-230','Cordyline Australis -DRACAENA','Ornamentales','190 - 210','Viveros EL OASIS','',100,38,30);
CALL add_producto ('OR-231','Cycas Revoluta','Ornamentales','55 - 65','Viveros EL OASIS','',100,15,12);
CALL add_producto ('OR-232','Cycas Revoluta','Ornamentales','80 - 90','Viveros EL OASIS','',100,34,27);
CALL add_producto ('OR-233','Dracaena Drago','Ornamentales','60 - 70','Viveros EL OASIS','',1,13,10);
CALL add_producto ('OR-234','Dracaena Drago','Ornamentales','130 - 150','Viveros EL OASIS','',2,64,51);
CALL add_producto ('OR-235','Dracaena Drago','Ornamentales','150 - 175','Viveros EL OASIS','',2,92,73);
CALL add_producto ('OR-236','Jubaea Chilensis','Ornamentales','','Viveros EL OASIS','',100,49,39);
CALL add_producto ('OR-237','Livistonia Australis','Ornamentales','100 - 125','Viveros EL OASIS','',50,19,15);
CALL add_producto ('OR-238','Livistonia Decipiens','Ornamentales','90 - 110','Viveros EL OASIS','',50,19,15);
CALL add_producto ('OR-239','Livistonia Decipiens','Ornamentales','180 - 200','Viveros EL OASIS','',50,49,39);
CALL add_producto ('OR-240','Phoenix Canariensis','Ornamentales','110 - 130','Viveros EL OASIS','',50,6,4);
CALL add_producto ('OR-241','Phoenix Canariensis','Ornamentales','180 - 200','Viveros EL OASIS','',50,19,15);
CALL add_producto ('OR-242','Rhaphis Excelsa','Ornamentales','80 - 100','Viveros EL OASIS','',50,21,16);
CALL add_producto ('OR-243','Rhaphis Humilis','Ornamentales','150- 170','Viveros EL OASIS','',50,64,51);
CALL add_producto ('OR-244','Sabal Minor','Ornamentales','60 - 75','Viveros EL OASIS','',50,11,8);
CALL add_producto ('OR-245','Sabal Minor','Ornamentales','120 - 140','Viveros EL OASIS','',50,34,27);
CALL add_producto ('OR-246','Trachycarpus Fortunei','Ornamentales','90 - 105','Viveros EL OASIS','',50,18,14);
CALL add_producto ('OR-247','Trachycarpus Fortunei','Ornamentales','250-300','Viveros EL OASIS','',2,462,369);
CALL add_producto ('OR-248','Washingtonia Robusta','Ornamentales','60 - 70','Viveros EL OASIS','',15,3,2);
CALL add_producto ('OR-249','Washingtonia Robusta','Ornamentales','130 - 150','Viveros EL OASIS','',15,5,4);
CALL add_producto ('OR-250','Yucca Jewel','Ornamentales','80 - 105','Viveros EL OASIS','',15,10,8);
CALL add_producto ('OR-251','Zamia Furfuracaea','Ornamentales','90 - 110','Viveros EL OASIS','',15,168,134);
CALL add_producto ('OR-99','Mimosa DEALBATA Gaulois Astier  ','Ornamentales','200-225','Viveros EL OASIS','Acacia dealbata. Nombre común o vulgar: Mimosa fina, Mimosa, Mimosa común, Mimosa plateada, Aromo francés. Familia: Mimosaceae. Origen: Australia, Sureste, (N. G. del Sur y Victoria). Arbol de follaje persistente muy usado en parques por su atractiva floración amarilla hacia fines del invierno. Altura: de 3 a 10 metros generalmente. Crecimiento rápido. Follaje perenne de tonos plateados, muy ornamental. Sus hojas son de textura fina, de color verde y sus flores amarillas que aparecen en racimos grandes. Florece de Enero a Marzo (Hemisferio Norte). Legumbre de 5-9 cm de longitud, recta o ligeramente curvada, con los bordes algo constreñidos entre las semillas, que se disponen en el fruto longitudinalmente...',100,14,11);

CALL add_detalle_pedido (1,'FR-67',10,70,3);
CALL add_detalle_pedido (1,'OR-127',40,4,1);
CALL add_detalle_pedido (1,'OR-141',25,4,2);
CALL add_detalle_pedido (1,'OR-241',15,19,4);
CALL add_detalle_pedido (1,'OR-99',23,14,5);
CALL add_detalle_pedido (2,'FR-4',3,29,6);
CALL add_detalle_pedido (2,'FR-40',7,8,7);
CALL add_detalle_pedido (2,'OR-140',50,4,3);
CALL add_detalle_pedido (2,'OR-141',20,5,2);
CALL add_detalle_pedido (2,'OR-159',12,6,5);
CALL add_detalle_pedido (2,'OR-227',67,64,1);
CALL add_detalle_pedido (2,'OR-247',5,462,4);
CALL add_detalle_pedido (3,'FR-48',120,9,6);
CALL add_detalle_pedido (3,'OR-122',32,5,4);
CALL add_detalle_pedido (3,'OR-123',11,5,5);
CALL add_detalle_pedido (3,'OR-213',30,266,1);
CALL add_detalle_pedido (3,'OR-217',15,65,2);
CALL add_detalle_pedido (3,'OR-218',24,25,3);
CALL add_detalle_pedido (4,'FR-31',12,8,7);
CALL add_detalle_pedido (4,'FR-34',42,8,6);
CALL add_detalle_pedido (4,'FR-40',42,9,8);
CALL add_detalle_pedido (4,'OR-152',3,6,5);
CALL add_detalle_pedido (4,'OR-155',4,6,3);
CALL add_detalle_pedido (4,'OR-156',17,9,4);
CALL add_detalle_pedido (4,'OR-157',38,10,2);
CALL add_detalle_pedido (4,'OR-222',21,59,1);
CALL add_detalle_pedido (8,'FR-106',3,11,1);
CALL add_detalle_pedido (8,'FR-108',1,32,2);
CALL add_detalle_pedido (8,'FR-11',10,100,3);
CALL add_detalle_pedido (9,'AR-001',80,1,3);
CALL add_detalle_pedido (9,'AR-008',450,1,2);
CALL add_detalle_pedido (9,'FR-106',80,8,1);
CALL add_detalle_pedido (9,'FR-69',15,91,2);
CALL add_detalle_pedido (10,'FR-82',5,70,2);
CALL add_detalle_pedido (10,'FR-91',30,75,1);
CALL add_detalle_pedido (10,'OR-234',5,64,3);
CALL add_detalle_pedido (11,'AR-006',180,1,3);
CALL add_detalle_pedido (11,'OR-247',80,8,1);
CALL add_detalle_pedido (12,'AR-009',290,1,1);
CALL add_detalle_pedido (13,'11679',5,14,1);
CALL add_detalle_pedido (13,'21636',12,14,2);
CALL add_detalle_pedido (13,'FR-11',5,100,3);
CALL add_detalle_pedido (14,'FR-100',8,11,2);
CALL add_detalle_pedido (14,'FR-13',13,57,1);
CALL add_detalle_pedido (15,'FR-84',4,13,3);
CALL add_detalle_pedido (15,'OR-101',2,6,2);
CALL add_detalle_pedido (15,'OR-156',6,10,1);
CALL add_detalle_pedido (15,'OR-203',9,10,4);
CALL add_detalle_pedido (16,'30310',12,12,1);
CALL add_detalle_pedido (16,'FR-36',10,9,2);
CALL add_detalle_pedido (17,'11679',5,14,1);
CALL add_detalle_pedido (17,'22225',5,12,3);
CALL add_detalle_pedido (17,'FR-37',5,9,2);
CALL add_detalle_pedido (17,'FR-64',5,22,4);
CALL add_detalle_pedido (17,'OR-136',5,18,5);
CALL add_detalle_pedido (18,'22225',4,12,2);
CALL add_detalle_pedido (18,'FR-22',2,4,1);
CALL add_detalle_pedido (18,'OR-159',10,6,3);
CALL add_detalle_pedido (19,'30310',9,12,5);
CALL add_detalle_pedido (19,'FR-23',6,8,4);
CALL add_detalle_pedido (19,'FR-75',1,32,2);
CALL add_detalle_pedido (19,'FR-84',5,13,1);
CALL add_detalle_pedido (19,'OR-208',20,4,3);
CALL add_detalle_pedido (20,'11679',14,14,1);
CALL add_detalle_pedido (20,'30310',8,12,2);
CALL add_detalle_pedido (21,'21636',5,14,3);
CALL add_detalle_pedido (21,'FR-18',22,4,1);
CALL add_detalle_pedido (21,'FR-53',3,8,2);
CALL add_detalle_pedido (22,'OR-240',1,6,1);
CALL add_detalle_pedido (23,'AR-002',110,1,4);
CALL add_detalle_pedido (23,'FR-107',50,22,3);
CALL add_detalle_pedido (23,'FR-85',4,70,2);
CALL add_detalle_pedido (23,'OR-249',30,5,1);
CALL add_detalle_pedido (24,'22225',3,15,1);
CALL add_detalle_pedido (24,'FR-1',4,7,4);
CALL add_detalle_pedido (24,'FR-23',2,7,2);
CALL add_detalle_pedido (24,'OR-241',10,20,3);
CALL add_detalle_pedido (25,'FR-77',15,69,1);
CALL add_detalle_pedido (25,'FR-9',4,30,3);
CALL add_detalle_pedido (25,'FR-94',10,30,2);
CALL add_detalle_pedido (26,'FR-15',9,25,3);
CALL add_detalle_pedido (26,'OR-188',4,25,1);
CALL add_detalle_pedido (26,'OR-218',14,25,2);
CALL add_detalle_pedido (27,'OR-101',22,6,2);
CALL add_detalle_pedido (27,'OR-102',22,6,3);
CALL add_detalle_pedido (27,'OR-186',40,6,1);
CALL add_detalle_pedido (28,'FR-11',8,99,3);
CALL add_detalle_pedido (28,'OR-213',3,266,2);
CALL add_detalle_pedido (28,'OR-247',1,462,1);
CALL add_detalle_pedido (29,'FR-82',4,70,4);
CALL add_detalle_pedido (29,'FR-9',4,28,1);
CALL add_detalle_pedido (29,'FR-94',20,31,5);
CALL add_detalle_pedido (29,'OR-129',2,111,2);
CALL add_detalle_pedido (29,'OR-160',10,9,3);
CALL add_detalle_pedido (30,'AR-004',10,1,6);
CALL add_detalle_pedido (30,'FR-108',2,32,2);
CALL add_detalle_pedido (30,'FR-12',2,19,3);
CALL add_detalle_pedido (30,'FR-72',4,31,5);
CALL add_detalle_pedido (30,'FR-89',10,45,1);
CALL add_detalle_pedido (30,'OR-120',5,5,4);
CALL add_detalle_pedido (31,'AR-009',25,2,3);
CALL add_detalle_pedido (31,'FR-102',1,20,1);
CALL add_detalle_pedido (31,'FR-4',6,29,2);
CALL add_detalle_pedido (32,'11679',1,14,4);
CALL add_detalle_pedido (32,'21636',4,15,5);
CALL add_detalle_pedido (32,'22225',1,15,3);
CALL add_detalle_pedido (32,'OR-128',29,100,2);
CALL add_detalle_pedido (32,'OR-193',5,20,1);
CALL add_detalle_pedido (33,'FR-17',423,2,4);
CALL add_detalle_pedido (33,'FR-29',120,8,3);
CALL add_detalle_pedido (33,'OR-214',212,10,2);
CALL add_detalle_pedido (33,'OR-247',150,462,1);
CALL add_detalle_pedido (34,'FR-3',56,7,4);
CALL add_detalle_pedido (34,'FR-7',12,29,3);
CALL add_detalle_pedido (34,'OR-172',20,18,1);
CALL add_detalle_pedido (34,'OR-174',24,18,2);
CALL add_detalle_pedido (35,'21636',12,14,4);
CALL add_detalle_pedido (35,'FR-47',55,8,3);
CALL add_detalle_pedido (35,'OR-165',3,10,2);
CALL add_detalle_pedido (35,'OR-181',36,10,1);
CALL add_detalle_pedido (35,'OR-225',72,10,5);
CALL add_detalle_pedido (36,'30310',4,12,2);
CALL add_detalle_pedido (36,'FR-1',2,7,3);
CALL add_detalle_pedido (36,'OR-147',6,7,4);
CALL add_detalle_pedido (36,'OR-203',1,12,5);
CALL add_detalle_pedido (36,'OR-99',15,13,1);
CALL add_detalle_pedido (37,'FR-105',4,70,1);
CALL add_detalle_pedido (37,'FR-57',203,8,2);
CALL add_detalle_pedido (37,'OR-176',38,10,3);
CALL add_detalle_pedido (38,'11679',5,14,1);
CALL add_detalle_pedido (38,'21636',2,14,2);
CALL add_detalle_pedido (39,'22225',3,12,1);
CALL add_detalle_pedido (39,'30310',6,12,2);
CALL add_detalle_pedido (40,'AR-001',4,1,1);
CALL add_detalle_pedido (40,'AR-002',8,1,2);
CALL add_detalle_pedido (41,'AR-003',5,1,1);
CALL add_detalle_pedido (41,'AR-004',5,1,2);
CALL add_detalle_pedido (42,'AR-005',3,1,1);
CALL add_detalle_pedido (42,'AR-006',1,1,2);
CALL add_detalle_pedido (43,'AR-007',9,1,1);
CALL add_detalle_pedido (44,'AR-008',5,1,1);
CALL add_detalle_pedido (45,'AR-009',6,1,1);
CALL add_detalle_pedido (45,'AR-010',4,1,2);
CALL add_detalle_pedido (46,'FR-1',4,7,1);
CALL add_detalle_pedido (46,'FR-10',8,7,2);
CALL add_detalle_pedido (47,'FR-100',9,11,1);
CALL add_detalle_pedido (47,'FR-101',5,13,2);
CALL add_detalle_pedido (48,'FR-102',1,18,1);
CALL add_detalle_pedido (48,'FR-103',1,25,2);
CALL add_detalle_pedido (48,'OR-234',50,64,1);
CALL add_detalle_pedido (48,'OR-236',45,49,2);
CALL add_detalle_pedido (48,'OR-237',50,19,3);
CALL add_detalle_pedido (49,'OR-204',50,10,1);
CALL add_detalle_pedido (49,'OR-205',10,10,2);
CALL add_detalle_pedido (49,'OR-206',5,5,3);
CALL add_detalle_pedido (50,'OR-225',12,10,1);
CALL add_detalle_pedido (50,'OR-226',15,38,2);
CALL add_detalle_pedido (50,'OR-227',44,64,3);
CALL add_detalle_pedido (51,'OR-209',50,10,1);
CALL add_detalle_pedido (51,'OR-210',80,39,2);
CALL add_detalle_pedido (51,'OR-211',70,59,3);
CALL add_detalle_pedido (53,'FR-2',1,7,1);
CALL add_detalle_pedido (53,'FR-85',1,70,3);
CALL add_detalle_pedido (53,'FR-86',2,11,2);
CALL add_detalle_pedido (53,'OR-116',6,7,4);
CALL add_detalle_pedido (54,'11679',3,14,3);
CALL add_detalle_pedido (54,'FR-100',45,10,2);
CALL add_detalle_pedido (54,'FR-18',5,4,1);
CALL add_detalle_pedido (54,'FR-79',3,22,4);
CALL add_detalle_pedido (54,'OR-116',8,7,6);
CALL add_detalle_pedido (54,'OR-123',3,5,5);
CALL add_detalle_pedido (54,'OR-168',2,10,7);
CALL add_detalle_pedido (55,'OR-115',9,7,1);
CALL add_detalle_pedido (55,'OR-213',2,266,2);
CALL add_detalle_pedido (55,'OR-227',6,64,5);
CALL add_detalle_pedido (55,'OR-243',2,64,4);
CALL add_detalle_pedido (55,'OR-247',1,462,3);
CALL add_detalle_pedido (56,'OR-129',1,115,5);
CALL add_detalle_pedido (56,'OR-130',10,18,6);
CALL add_detalle_pedido (56,'OR-179',1,6,3);
CALL add_detalle_pedido (56,'OR-196',3,10,4);
CALL add_detalle_pedido (56,'OR-207',4,4,2);
CALL add_detalle_pedido (56,'OR-250',3,10,1);
CALL add_detalle_pedido (57,'FR-69',6,91,4);
CALL add_detalle_pedido (57,'FR-81',3,49,3);
CALL add_detalle_pedido (57,'FR-84',2,13,1);
CALL add_detalle_pedido (57,'FR-94',6,9,2);
CALL add_detalle_pedido (58,'OR-102',65,18,3);
CALL add_detalle_pedido (58,'OR-139',80,4,1);
CALL add_detalle_pedido (58,'OR-172',69,15,2);
CALL add_detalle_pedido (58,'OR-177',150,15,4);
CALL add_detalle_pedido (74,'FR-67',15,70,1);
CALL add_detalle_pedido (74,'OR-227',34,64,2);
CALL add_detalle_pedido (74,'OR-247',42,8,3);
CALL add_detalle_pedido (75,'AR-006',60,1,2);
CALL add_detalle_pedido (75,'FR-87',24,22,3);
CALL add_detalle_pedido (75,'OR-157',46,10,1);
CALL add_detalle_pedido (76,'AR-009',250,1,5);
CALL add_detalle_pedido (76,'FR-79',40,22,3);
CALL add_detalle_pedido (76,'FR-87',24,22,4);
CALL add_detalle_pedido (76,'FR-94',35,9,1);
CALL add_detalle_pedido (76,'OR-196',25,10,2);
CALL add_detalle_pedido (77,'22225',34,12,2);
CALL add_detalle_pedido (77,'30310',15,12,1);
CALL add_detalle_pedido (78,'FR-53',25,8,2);
CALL add_detalle_pedido (78,'FR-85',56,70,3);
CALL add_detalle_pedido (78,'OR-157',42,10,4);
CALL add_detalle_pedido (78,'OR-208',30,4,1);
CALL add_detalle_pedido (79,'OR-240',50,6,1);
CALL add_detalle_pedido (80,'FR-11',40,100,3);
CALL add_detalle_pedido (80,'FR-36',47,9,2);
CALL add_detalle_pedido (80,'OR-136',75,18,1);
CALL add_detalle_pedido (81,'OR-208',30,4,1);
CALL add_detalle_pedido (82,'OR-227',34,64,1);
CALL add_detalle_pedido (83,'OR-208',30,4,1);
CALL add_detalle_pedido (89,'FR-108',3,32,2);
CALL add_detalle_pedido (89,'FR-3',15,7,6);
CALL add_detalle_pedido (89,'FR-42',12,8,4);
CALL add_detalle_pedido (89,'FR-66',5,49,1);
CALL add_detalle_pedido (89,'FR-87',4,22,3);
CALL add_detalle_pedido (89,'OR-157',8,10,5);
CALL add_detalle_pedido (90,'AR-001',19,1,1);
CALL add_detalle_pedido (90,'AR-002',10,1,2);
CALL add_detalle_pedido (90,'AR-003',12,1,3);
CALL add_detalle_pedido (91,'FR-100',52,11,1);
CALL add_detalle_pedido (91,'FR-101',14,13,2);
CALL add_detalle_pedido (91,'FR-102',35,18,3);
CALL add_detalle_pedido (92,'FR-108',12,23,1);
CALL add_detalle_pedido (92,'FR-11',20,100,2);
CALL add_detalle_pedido (92,'FR-12',30,21,3);
CALL add_detalle_pedido (93,'FR-54',25,9,1);
CALL add_detalle_pedido (93,'FR-58',51,11,2);
CALL add_detalle_pedido (93,'FR-60',3,32,3);
CALL add_detalle_pedido (94,'11679',12,14,1);
CALL add_detalle_pedido (94,'FR-11',33,100,3);
CALL add_detalle_pedido (94,'FR-4',79,29,2);
CALL add_detalle_pedido (95,'FR-10',9,7,2);
CALL add_detalle_pedido (95,'FR-75',6,32,1);
CALL add_detalle_pedido (95,'FR-82',5,70,3);
CALL add_detalle_pedido (96,'FR-43',6,8,1);
CALL add_detalle_pedido (96,'FR-6',16,7,4);
CALL add_detalle_pedido (96,'FR-71',10,22,3);
CALL add_detalle_pedido (96,'FR-90',4,70,2);
CALL add_detalle_pedido (97,'FR-41',12,8,1);
CALL add_detalle_pedido (97,'FR-54',14,9,2);
CALL add_detalle_pedido (97,'OR-156',10,10,3);
CALL add_detalle_pedido (98,'FR-33',14,8,4);
CALL add_detalle_pedido (98,'FR-56',16,8,3);
CALL add_detalle_pedido (98,'FR-60',8,32,1);
CALL add_detalle_pedido (98,'FR-8',18,6,5);
CALL add_detalle_pedido (98,'FR-85',6,70,2);
CALL add_detalle_pedido (99,'OR-157',15,10,2);
CALL add_detalle_pedido (99,'OR-227',30,64,1);
CALL add_detalle_pedido (100,'FR-87',20,22,1);
CALL add_detalle_pedido (100,'FR-94',40,9,2);
CALL add_detalle_pedido (101,'AR-006',50,1,1);
CALL add_detalle_pedido (101,'AR-009',159,1,2);
CALL add_detalle_pedido (102,'22225',32,12,2);
CALL add_detalle_pedido (102,'30310',23,12,1);
CALL add_detalle_pedido (103,'FR-53',12,8,2);
CALL add_detalle_pedido (103,'OR-208',52,4,1);
CALL add_detalle_pedido (104,'FR-85',9,70,1);
CALL add_detalle_pedido (104,'OR-157',113,10,2);
CALL add_detalle_pedido (105,'OR-227',21,64,2);
CALL add_detalle_pedido (105,'OR-240',27,6,1);
CALL add_detalle_pedido (106,'AR-009',231,1,1);
CALL add_detalle_pedido (106,'OR-136',47,18,2);
CALL add_detalle_pedido (107,'30310',143,12,2);
CALL add_detalle_pedido (107,'FR-11',15,100,1);
CALL add_detalle_pedido (108,'FR-53',53,8,1);
CALL add_detalle_pedido (108,'OR-208',59,4,2);
CALL add_detalle_pedido (109,'FR-22',8,4,5);
CALL add_detalle_pedido (109,'FR-36',12,9,3);
CALL add_detalle_pedido (109,'FR-45',14,8,4);
CALL add_detalle_pedido (109,'OR-104',20,10,1);
CALL add_detalle_pedido (109,'OR-119',10,5,2);
CALL add_detalle_pedido (109,'OR-125',3,5,6);
CALL add_detalle_pedido (109,'OR-130',2,18,7);
CALL add_detalle_pedido (110,'AR-010',6,1,3);
CALL add_detalle_pedido (110,'FR-1',14,7,1);
CALL add_detalle_pedido (110,'FR-16',1,45,2);
CALL add_detalle_pedido (116,'21636',5,14,1);
CALL add_detalle_pedido (116,'AR-001',32,1,2);
CALL add_detalle_pedido (116,'AR-005',18,1,5);
CALL add_detalle_pedido (116,'FR-33',13,8,3);
CALL add_detalle_pedido (116,'OR-200',10,4,4);
CALL add_detalle_pedido (117,'FR-78',2,15,1);
CALL add_detalle_pedido (117,'FR-80',1,32,3);
CALL add_detalle_pedido (117,'OR-146',17,4,2);
CALL add_detalle_pedido (117,'OR-179',4,6,4);
CALL add_detalle_pedido (128,'AR-004',15,1,1);
CALL add_detalle_pedido (128,'OR-150',18,2,2);
CALL add_detalle_pedido (52,'FR-67',10,70,1);
CALL add_detalle_pedido (59,'FR-67',10,70,1);
CALL add_detalle_pedido (60,'FR-67',10,70,1);
CALL add_detalle_pedido (61,'FR-67',10,70,1);
CALL add_detalle_pedido (62,'FR-67',10,70,1);
CALL add_detalle_pedido (63,'FR-67',10,70,1);
CALL add_detalle_pedido (64,'FR-67',10,70,1);
CALL add_detalle_pedido (65,'FR-67',10,70,1);
CALL add_detalle_pedido (66,'FR-67',10,70,1);
CALL add_detalle_pedido (67,'FR-67',10,70,1);
CALL add_detalle_pedido (68,'FR-67',10,70,1);
CALL add_detalle_pedido (111,'FR-67',10,70,1);
CALL add_detalle_pedido (112,'FR-67',10,70,1);
CALL add_detalle_pedido (113,'FR-67',10,70,1);
CALL add_detalle_pedido (114,'FR-67',10,70,1);
CALL add_detalle_pedido (115,'FR-67',10,70,1);
CALL add_detalle_pedido (118,'FR-67',10,70,1);
CALL add_detalle_pedido (119,'FR-67',10,70,1);
CALL add_detalle_pedido (120,'FR-67',10,70,1);
CALL add_detalle_pedido (121,'FR-67',10,70,1);
CALL add_detalle_pedido (122,'FR-67',10,70,1);
CALL add_detalle_pedido (123,'FR-67',10,70,1);
CALL add_detalle_pedido (124,'FR-67',10,70,1);
CALL add_detalle_pedido (125,'FR-67',10,70,1);
CALL add_detalle_pedido (126,'FR-67',10,70,1);
CALL add_detalle_pedido (127,'FR-67',10,70,1);

CALL add_pago (1,'PayPal','ak-std-000001','2008-11-10',2000);
CALL add_pago (1,'PayPal','ak-std-000002','2008-12-10',2000);
CALL add_pago (3,'PayPal','ak-std-000003','2009-01-16',5000);
CALL add_pago (3,'PayPal','ak-std-000004','2009-02-16',5000);
CALL add_pago (3,'PayPal','ak-std-000005','2009-02-19',926);
CALL add_pago (4,'PayPal','ak-std-000006','2007-01-08',20000);
CALL add_pago (4,'PayPal','ak-std-000007','2007-01-08',20000);
CALL add_pago (4,'PayPal','ak-std-000008','2007-01-08',20000);
CALL add_pago (4,'PayPal','ak-std-000009','2007-01-08',20000);
CALL add_pago (4,'PayPal','ak-std-000010','2007-01-08',1849);
CALL add_pago (5,'Transferencia','ak-std-000011','2006-01-18',23794);
CALL add_pago (7,'Cheque','ak-std-000012','2009-01-13',2390);
CALL add_pago (9,'PayPal','ak-std-000013','2009-01-06',929);
CALL add_pago (13,'PayPal','ak-std-000014','2008-08-04',2246);
CALL add_pago (14,'PayPal','ak-std-000015','2008-07-15',4160);
CALL add_pago (15,'PayPal','ak-std-000016','2009-01-15',2081);
CALL add_pago (15,'PayPal','ak-std-000035','2009-02-15',10000);
CALL add_pago (16,'PayPal','ak-std-000017','2009-02-16',4399);
CALL add_pago (19,'PayPal','ak-std-000018','2009-03-06',232);
CALL add_pago (23,'PayPal','ak-std-000019','2009-03-26',272);
CALL add_pago (26,'PayPal','ak-std-000020','2008-03-18',18846);
CALL add_pago (27,'PayPal','ak-std-000021','2009-02-08',10972);
CALL add_pago (28,'PayPal','ak-std-000022','2009-01-13',8489);
CALL add_pago (30,'PayPal','ak-std-000024','2009-01-16',7863);
CALL add_pago (35,'PayPal','ak-std-000025','2007-10-06',3321);
CALL add_pago (38,'PayPal','ak-std-000026','2006-05-26',1171);
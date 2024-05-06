# GARDEN DATA BASE 



#### Diagrama Entidad Relación

![diagrama]()



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
  `employee_employee_id` INT(11) NULL DEFAULT NULL,
  `provider_id` INT NULL DEFAULT NULL,
  `customer_contact_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`phone_number_id`),
  INDEX `fk_phone_number_office1_idx` (`office_id` ASC) VISIBLE,
  INDEX `fk_phone_number_employee1_idx` (`employee_employee_id` ASC) VISIBLE,
  INDEX `fk_phone_number_provider1_idx` (`provider_id` ASC) VISIBLE,
  INDEX `fk_phone_number_customer_contact1_idx` (`customer_contact_id` ASC) VISIBLE,
  CONSTRAINT `fk_phone_number_office1`
    FOREIGN KEY (`office_id`)
    REFERENCES `garden`.`office` (`office_id`),
  CONSTRAINT `fk_phone_number_employee1`
    FOREIGN KEY (`employee_employee_id`)
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

Datos Formateados [DATOS FORMATEADOS]([David-Albarracin/GARDEN_DB (github.com)](https://github.com/David-Albarracin/GARDEN_DB/calls_procedures.sql))

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
   		null,
   		null,
   		extension,
   		null,
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
		SET get_provider_id = LAST_INSERT_ID(); 
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

###### DESPUES DE CREAR LOS PROCEDIMIENTOS EJECUTAMOS EL ARCHIVO CALL_PROCEDURES PARA PODER AGREGAR DATOS DE PRUEBA

#### VISTAS PARA FACILITAR BÚSQUEDAS 

```sql

```



## Consultas sobre una tabla

1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.

   ```sql
   ```

2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.

   ```sql
   ```

3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo
   jefe tiene un código de jefe igual a 7.

   ```sql
   ```

4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la
   empresa.

   ```sql
   ```

5. Devuelve un listado con el nombre, apellidos y puesto de aquellos
   empleados que no sean representantes de ventas.

   ```sql
   ```

6. Devuelve un listado con el nombre de los todos los clientes españoles.

   ```sql
   ```

7. Devuelve un listado con los distintos estados por los que puede pasar un
   pedido.

   ```sql
   ```

8. Devuelve un listado con el código de cliente de aquellos clientes que
   realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar
   aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta:

   • Utilizando la función YEAR de MySQL.
   • Utilizando la función DATE_FORMAT de MySQL.
   • Sin utilizar ninguna de las funciones anteriores.

   ```sql
   ```

9. Devuelve un listado con el código de pedido, código de cliente, fecha
   esperada y fecha de entrega de los pedidos que no han sido entregados a
   tiempo.

   ```sql
   
   ```

10. Devuelve un listado con el código de pedido, código de cliente, fecha
    esperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al
    menos dos días antes de la fecha esperada.

    • Utilizando la función ADDDATE de MySQL.
    • Utilizando la función DATEDIFF de MySQL.
    • ¿Sería posible resolver esta consulta utilizando el operador de suma + o
    resta -?

    ```sql
    
    ```

11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.

    ```sql
    
    ```

12. Devuelve un listado de todos los pedidos que han sido entregados en el
    mes de enero de cualquier año.

    ```sql
    
    ```

13. Devuelve un listado con todos los pagos que se realizaron en el
    año 2008 mediante Paypal. Ordene el resultado de mayor a menor.

    ```sql
    
    ```

14. Devuelve un listado con todas las formas de pago que aparecen en la
    tabla pago. Tenga en cuenta que no deben aparecer formas de pago
    repetidas.

    ```sql
    
    ```

15. Devuelve un listado con todos los productos que pertenecen a la
    gama Ornamentales y que tienen más de 100 unidades en stock. El listado
    deberá estar ordenado por su precio de venta, mostrando en primer lugar
    los de mayor precio.

    ```sql
    
    ```

16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y
    cuyo representante de ventas tenga el código de empleado 11 o 30.

    ```sql
    
    ```

## Consultas multitabla (Composición interna)

Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2. Las consultas con
sintaxis de SQL2 se deben resolver con INNER JOIN y NATURAL JOIN.

1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su
   representante de ventas.

   ```sql
   ```

2. Muestra el nombre de los clientes que hayan realizado pagos junto con el
   nombre de sus representantes de ventas.

   ```sql
   ```

3. Muestra el nombre de los clientes que no hayan realizado pagos junto con
   el nombre de sus representantes de ventas.

   ```sql
   ```

4. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus
   representantes junto con la ciudad de la oficina a la que pertenece el
   representante.

   ```sql
   ```

5. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre
   de sus representantes junto con la ciudad de la oficina a la que pertenece el
   representante.

   ```sql
   ```

6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.

   ```sql
   ```

7. Devuelve el nombre de los clientes y el nombre de sus representantes junto
   con la ciudad de la oficina a la que pertenece el representante.

   ```sql
   ```

8. Devuelve un listado con el nombre de los empleados junto con el nombre
   de sus jefes.

   ```sql
   ```

9. Devuelve un listado que muestre el nombre de cada empleados, el nombre
   de su jefe y el nombre del jefe de sus jefe.

   ```sql
   ```

10. Devuelve el nombre de los clientes a los que no se les ha entregado a
    tiempo un pedido.

    ```sql
    ```

11. Devuelve un listado de las diferentes gamas de producto que ha comprado
    cada cliente.

    ```sql
    ```

    

## Consultas multitabla (Composición externa)

Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, NATURAL
LEFT JOIN y NATURAL RIGHT JOIN.

1. Devuelve un listado que muestre solamente los clientes que no han
   realizado ningún pago.

   ```sql
   ```

2. Devuelve un listado que muestre solamente los clientes que no han
   realizado ningún pedido.

   ```sql
   ```

3. Devuelve un listado que muestre los clientes que no han realizado ningún
   pago y los que no han realizado ningún pedido.

   ```sql
   ```

4. Devuelve un listado que muestre solamente los empleados que no tienen
   una oficina asociada.

   ```sql
   ```

5. Devuelve un listado que muestre solamente los empleados que no tienen un
   cliente asociado.

   ```sql
   ```

6. Devuelve un listado que muestre solamente los empleados que no tienen un
   cliente asociado junto con los datos de la oficina donde trabajan.

   ```sql
   ```

7. Devuelve un listado que muestre los empleados que no tienen una oficina
   asociada y los que no tienen un cliente asociado.

   ```sql
   ```

8. Devuelve un listado de los productos que nunca han aparecido en un
   pedido.

   ```sql
   ```

9. Devuelve un listado de los productos que nunca han aparecido en un
   pedido. El resultado debe mostrar el nombre, la descripción y la imagen del
   producto.

   ```sql
   ```

10. Devuelve las oficinas donde no trabajan ninguno de los empleados que
    hayan sido los representantes de ventas de algún cliente que haya realizado
    la compra de algún producto de la gama Frutales.

    ```sql
    ```

11. Devuelve un listado con los clientes que han realizado algún pedido pero no
    han realizado ningún pago.

    ```sql
    ```

12. Devuelve un listado con los datos de los empleados que no tienen clientes
    asociados y el nombre de su jefe asociado.

    ```sql
    ```



## Consultas resumen

1. ¿Cuántos empleados hay en la compañía?

   ```sql
   ```

2. ¿Cuántos clientes tiene cada país?

   ```sql
   ```

3. ¿Cuál fue el pago medio en 2009?

   ```sql
   ```

4. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma
   descendente por el número de pedidos.

   ```sql
   ```

5. Calcula el precio de venta del producto más caro y más barato en una
   misma consulta.

   ```sql
   ```

6. Calcula el número de clientes que tiene la empresa.

   ```sql
   ```

7. ¿Cuántos clientes existen con domicilio en la ciudad de Madrid?

   ```sql
   ```

8. ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan
   por M?

   ```sql
   ```

9. Devuelve el nombre de los representantes de ventas y el número de clientes
   al que atiende cada uno.

   ```sql
   ```

10. Calcula el número de clientes que no tiene asignado representante de
    ventas.

    ```sql
    ```

11. Calcula la fecha del primer y último pago realizado por cada uno de los
    clientes. El listado deberá mostrar el nombre y los apellidos de cada cliente.

    ```sql
    ```

12. Calcula el número de productos diferentes que hay en cada uno de los
    pedidos.

    ```sql
    ```

13. Calcula la suma de la cantidad total de todos los productos que aparecen en
    cada uno de los pedidos.

    ```sql
    ```

14. Devuelve un listado de los 20 productos más vendidos y el número total de
    unidades que se han vendido de cada uno. El listado deberá estar ordenado
    por el número total de unidades vendidas.

    ```sql
    ```

15. La facturación que ha tenido la empresa en toda la historia, indicando la
    base imponible, el IVA y el total facturado. La base imponible se calcula
    sumando el coste del producto por el número de unidades vendidas de la
    tabla detalle_pedido. El IVA es el 21 % de la base imponible, y el total la
    suma de los dos campos anteriores.

    ```sql
    ```

16. La misma información que en la pregunta anterior, pero agrupada por
    código de producto.

    ```sql
    ```

17. La misma información que en la pregunta anterior, pero agrupada por
    código de producto filtrada por los códigos que empiecen por OR.

    ```sql
    ```

18. Lista las ventas totales de los productos que hayan facturado más de 3000
    euros. Se mostrará el nombre, unidades vendidas, total facturado y total
    facturado con impuestos (21% IVA).

    ```sql
    ```

19. Muestre la suma total de todos los pagos que se realizaron para cada uno
    de los años que aparecen en la tabla pagos.

    ```sql
    ```



## Subconsultas

##### Con operadores básicos de comparación

1. Devuelve el nombre del cliente con mayor límite de crédito.

   ```sql
   ```

2. Devuelve el nombre del producto que tenga el precio de venta más caro.

   ```sql
   ```

3. Devuelve el nombre del producto del que se han vendido más unidades.
   (Tenga en cuenta que tendrá que calcular cuál es el número total de
   unidades que se han vendido de cada producto a partir de los datos de la
   tabla detalle_pedido)

   ```sql
   ```

4. Los clientes cuyo límite de crédito sea mayor que los pagos que haya
   realizado. (Sin utilizar INNER JOIN).

   ```sql
   ```

5. Devuelve el producto que más unidades tiene en stock.

   ```sql
   ```

6. Devuelve el producto que menos unidades tiene en stock.

   ```sql
   ```

7. Devuelve el nombre, los apellidos y el email de los empleados que están a
   cargo de Alberto Soria.

   ```sql
   ```

##### **Subconsultas con ALL y ANY**

8. Devuelve el nombre del cliente con mayor límite de crédito.

   ```sql
   ```

9. Devuelve el nombre del producto que tenga el precio de venta más caro.

   ```sql
   ```

10. Devuelve el producto que menos unidades tiene en stock.

    ```sql
    ```

##### Subconsultas con IN y NOT IN

11. Devuelve el nombre, apellido1 y cargo de los empleados que no
    representen a ningún cliente.

    ```sql
    ```

12. Devuelve un listado que muestre solamente los clientes que no han
    realizado ningún pago.

    ```sql
    ```

13. Devuelve un listado que muestre solamente los clientes que sí han realizado
    algún pago.

    ```sql
    ```

14. Devuelve un listado de los productos que nunca han aparecido en un
    pedido.

    ```sql
    ```

15. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos
    empleados que no sean representante de ventas de ningún cliente.

    ```sql
    ```

16. Devuelve las oficinas donde no trabajan ninguno de los empleados que
    hayan sido los representantes de ventas de algún cliente que haya realizado
    la compra de algún producto de la gama Frutales.

    ```sql
    ```

17. Devuelve un listado con los clientes que han realizado algún pedido pero no
    han realizado ningún pago.

    ```sql
    ```

##### **Subconsultas con EXISTS y NOT EXISTS**

18. Devuelve un listado que muestre solamente los clientes que no han
    realizado ningún pago.

    ```sql
    ```

19. Devuelve un listado que muestre solamente los clientes que sí han realizado
    algún pago.

    ```sql
    ```

20. Devuelve un listado de los productos que nunca han aparecido en un
    pedido.

    ```sql
    ```

21. Devuelve un listado de los productos que han aparecido en un pedido
    alguna vez.

    ```sql
    ```

##### Subconsultas correlacionadas

#### Consultas variadas

1. Devuelve el listado de clientes indicando el nombre del cliente y cuántos
   pedidos ha realizado. Tenga en cuenta que pueden existir clientes que no
   han realizado ningún pedido.

   ```sql
   ```

2. Devuelve un listado con los nombres de los clientes y el total pagado por
   cada uno de ellos. Tenga en cuenta que pueden existir clientes que no han
   realizado ningún pago.

   ```sql
   ```

3. Devuelve el nombre de los clientes que hayan hecho pedidos en 2008
   ordenados alfabéticamente de menor a mayor.

   ```sql
   ```

4. Devuelve el nombre del cliente, el nombre y primer apellido de su
   representante de ventas y el número de teléfono de la oficina del
   representante de ventas, de aquellos clientes que no hayan realizado ningún
   pago.

   ```sql
   ```

5. Devuelve el listado de clientes donde aparezca el nombre del cliente, el
   nombre y primer apellido de su representante de ventas y la ciudad donde
   está su oficina.

   ```sql
   ```

6. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos
   empleados que no sean representante de ventas de ningún cliente.

   ```sql
   ```

7. Devuelve un listado indicando todas las ciudades donde hay oficinas y el
   número de empleados que tiene.

   ```sql
   ```








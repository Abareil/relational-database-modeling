
/*TABLA DE AUDITORIA*/
CREATE TABLE auditoria_productos ( 
	id_auditoria int not null primary key auto_increment, 
	fecha DATETIME DEFAULT CURRENT_TIMESTAMP, 
	id_producto_copia INT,
	precio_copia DECIMAL(10,2) NULL,
	precio_actual DECIMAL(10,2) NULL,
	usuario varchar(50),
	transaccion varchar(50));
COMMIT;
  
  /*TRIGGER UPDATE PRODUCTO*/
  DELIMITER //
CREATE TRIGGER update_precio
AFTER UPDATE ON producto
FOR EACH ROW
BEGIN
    IF NEW.precio <> OLD.precio THEN
        INSERT INTO auditoria_productos (id_producto_copia, precio_copia, precio_actual, usuario, transaccion)
        VALUES (OLD.id_producto, OLD.precio, NEW.precio, user(), 'cambio precio producto');
    END IF;
END//
DELIMITER ;

  /*TRIGGER DELETE PRODUCTO*/
  DELIMITER //
CREATE TRIGGER delete_producto
BEFORE DELETE ON producto
FOR EACH ROW
BEGIN
        INSERT INTO auditoria_productos (id_producto_copia, precio_copia, precio_actual, usuario, transaccion)
        VALUES (OLD.id_producto, OLD.precio, NULL, user(), 'eliminacion del producto');
END//
DELIMITER ;

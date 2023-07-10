CREATE TEMPORARY TABLE temp_carrito(cantidad INT, producto VARCHAR(20), subtotal DECIMAL(10,2));

DELIMITER //
DROP PROCEDURE IF EXISTS add_carrito;
CREATE PROCEDURE add_carrito(IN p_id_prod INT, p_cantidad INT)
BEGIN
    DECLARE v_subtotal DECIMAL(10, 2);
    DECLARE v_nombre VARCHAR(20);
    
    SET v_subtotal = (SELECT precio * p_cantidad FROM producto WHERE id_producto = p_id_prod);
    SET v_nombre = (SELECT nombre FROM producto WHERE id_producto = p_id_prod);
    
    INSERT INTO temp_carrito VALUES (p_cantidad, v_nombre, v_subtotal);
    COMMIT;
END //
DELIMITER ;



call add_carrito(1, 4);
select * from temp_carrito;

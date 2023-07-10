DELIMITER //

DROP PROCEDURE IF EXISTS producto_mas_vendido_anio;

CREATE PROCEDURE producto_mas_vendido_anio(IN p_año INT)
BEGIN
    DECLARE v_nombre VARCHAR(50);
    DECLARE v_cantidad INT;
    DECLARE v_fin INT DEFAULT 0;

    DECLARE v_consulta CURSOR FOR
    SELECT pr.nombre, COUNT(pp.cantidad) AS cantidad
    FROM producto_has_pedido pp
    JOIN pedido pe ON pe.id_pedido = pp.id_pedido
    JOIN producto pr ON pr.id_producto = pp.id_producto
    WHERE YEAR(pe.fecha) = p_año
    GROUP BY pp.id_producto
    ORDER BY cantidad DESC
    LIMIT 1;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_fin = 1;

    OPEN v_consulta;
    recorrer: LOOP
        FETCH v_consulta INTO v_nombre, v_cantidad;
        IF v_fin = 1 THEN
            LEAVE recorrer;
        END IF;

        SELECT v_nombre, v_cantidad;

    END LOOP recorrer;
    CLOSE v_consulta;
END //

DELIMITER ;

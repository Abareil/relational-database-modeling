DELIMITER //
DROP FUNCTION IF EXISTS pat;

CREATE FUNCTION pat (p_id_producto INT)
RETURNS DECIMAL
DETERMINISTIC
BEGIN
    DECLARE v_porcentaje DECIMAL(10,2);
    DECLARE v_precio_final DECIMAL(10,2);
    DECLARE v_precio_inicial DECIMAL(10,2);
    DECLARE v_modificacion INT;

    SET v_modificacion = (SELECT COUNT(precio_actual) FROM auditoria_productos WHERE id_producto_copia = p_id_producto);
    
    SET v_precio_inicial = (
        SELECT precio_copia
        FROM auditoria_productos
        WHERE id_producto_copia = p_id_producto
            AND DATE(fecha) BETWEEN DATE_SUB(CURDATE(), INTERVAL 3 MONTH) AND CURDATE()
        ORDER BY fecha ASC
        LIMIT 1
    );

    
        SET v_precio_final = (
            SELECT precio_actual
            FROM auditoria_productos
            WHERE id_producto_copia = p_id_producto
                AND DATE(fecha) BETWEEN DATE_SUB(CURDATE(), INTERVAL 3 MONTH) AND CURDATE()
            ORDER BY fecha DESC
            LIMIT 1
        );

	IF v_modificacion > 0 THEN
    SET v_porcentaje = (SELECT (v_precio_final - v_precio_inicial) / v_precio_inicial * 100);
    ELSE
        SET v_porcentaje = 0;
    END IF;
    
    RETURN v_porcentaje;
END //


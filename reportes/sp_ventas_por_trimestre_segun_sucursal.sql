DELIMITER //

DROP PROCEDURE IF EXISTS ventas_trimestre_suc2;

CREATE PROCEDURE ventas_trimestre_suc2(IN p_sucursal VARCHAR(20))
BEGIN
    DECLARE v_año INT;
    DECLARE v_sucursal VARCHAR(20);
    DECLARE v_ene_mar DECIMAL(10, 2);
    DECLARE v_abr_jun DECIMAL(10, 2);
    DECLARE v_oct_dic DECIMAL(10, 2);
    DECLARE v_jul_sep DECIMAL(10, 2);
    DECLARE v_fin INT DEFAULT 0;

    DECLARE v_consulta CURSOR FOR
    
    SELECT
        YEAR(CURDATE()) AS Año,
        MAX(CASE WHEN QUARTER(p.fecha) = 1 THEN p.total ELSE 0 END) AS ene_mar,
        MAX(CASE WHEN QUARTER(p.fecha) = 2 THEN p.total ELSE 0 END) AS abr_jun,
        MAX(CASE WHEN QUARTER(p.fecha) = 3 THEN p.total ELSE 0 END) AS jul_sep,
        MAX(CASE WHEN QUARTER(p.fecha) = 4 THEN p.total ELSE 0 END) AS oct_dic
    FROM
        pedido AS p
    JOIN empleado AS e ON e.id_empleado = p.id_empleado
    JOIN sucursal AS s ON s.id_sucursal = e.id_sucursal
    WHERE YEAR(p.fecha) = YEAR(CURDATE()) AND s.nombre = p_sucursal
    GROUP BY s.nombre;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_fin = 1;

    OPEN v_consulta;
    recorrer:LOOP
    FETCH v_consulta INTO v_año, v_ene_mar, v_abr_jun, v_jul_sep, v_oct_dic;
    IF v_fin = 1 THEN LEAVE recorrer;
    END IF;

    SELECT v_año, p_sucursal, v_ene_mar, v_abr_jun, v_jul_sep, v_oct_dic;
    
    END LOOP recorrer;
    CLOSE v_consulta;
END //

DELIMITER ;



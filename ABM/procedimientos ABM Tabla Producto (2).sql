 /*ALTA PRODUCTO*/
 delimiter //
 drop procedure if exists AltaNuevoProducto;
 create procedure AltaNuevoProducto (
	in p_nombre varchar(45),
    in precio decimal(10,2),
    in descripcion varchar(200)
 )
 begin
 
	declare v_existente int;
    set v_existente = (select count(id_producto) from producto where nombre = p_nombre);
    
    if v_existente = 0 then
	insert into producto(
		producto.nombre,
        producto.precio,
        producto.descripcion
    ) 
    values(
		p_nombre,
        precio,
        descripcion
    )
 ;
 end if;
 commit;
 end //
 delimiter ;
 
 /*modificacion producto*/
 delimiter //
 drop procedure if exists modificarDescripcionProducto;
  create procedure modificarDescripcionProducto(
	in p_idproducto int,
    in nuevaDescripcion varchar(200)
 )
 
 begin
 declare v_existente int;
    set v_existente = (select count(id_producto) from producto where id_producto = p_idproducto);
 
     if v_existente > 0 then
	update producto
    set
    producto.descripcion = nuevaDescripcion
    where producto.id_producto = p_idproducto
    ;
	 commit;
	end if;
 end //
 delimiter ;
 
 /*ALTA MATERIA PRIMA*/

 DELIMITER //
DROP PROCEDURE IF EXISTS alta_mat_prima;
CREATE PROCEDURE alta_mat_prima(IN p_nombre VARCHAR(20), p_proveedor INT)
BEGIN
    DECLARE v_proveedor_existente INT;
    DECLARE v_mat_existente INT;
    SET v_proveedor_existente = (SELECT COUNT(id_proveedor) FROM proveedor WHERE id_proveedor = p_proveedor);
    SET v_mat_existente = (SELECT COUNT(id_materia_prima) FROM materia_prima WHERE nombre = p_nombre AND id_proveedor = p_proveedor);
    
    IF v_proveedor_existente > 0 AND v_mat_existente = 0 THEN
        INSERT INTO materia_prima(nombre, id_proveedor) VALUES (p_nombre, p_proveedor);
        SELECT 'Materia prima agregada correctamente.' AS mensaje;
    ELSE
        SELECT 'Error al agregar la materia prima. Verifica el proveedor y el nombre.' AS mensaje;
    END IF;
END //


 
 


 
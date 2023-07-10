

CREATE VIEW ranking_vendedor
AS SELECT e.nombre, e.apellido, SUM(pe.total) as total
FROM puesto AS p
JOIN empleado AS e
ON p.id_puesto = e.id_puesto
JOIN pedido AS pe 
ON e.id_empleado = pe.id_empleado
WHERE p.nombre_puesto = 'Vendedor'
GROUP BY e.id_empleado, e.nombre, e.apellido order by total DESC;


CREATE VIEW puesto_empleado
AS SELECT  p.nombre_puesto, e.apellido, e.nombre
FROM puesto AS p
JOIN empleado AS e
ON p.id_puesto = e.id_puesto;


CREATE VIEW entrega_pedidos
AS SELECT p.fecha ,c.nombre, c.apellido, c.telefono, d.calle, d.altura,   p.descuento, p.total
FROM cliente AS c
JOIN direccion AS d
ON c.id_direccion = d.id_direccion
JOIN pedido  AS p
ON p.id_cliente = c.id_cliente
ORDER BY p.fecha;

CREATE VIEW proveedor_material 
AS SELECT mp.nombre as producto, p.nombre as nombreProveedor, p.cuit
FROM proveedor AS p
JOIN materia_prima AS mp
ON p.id_proveedor = mp.id_proveedor
ORDER BY nombreProveedor;


CREATE VIEW empleado_sucursal AS SELECT s.nombre,e.apellido, e.dni, p.nombre_puesto, s.nombre as sucursal
FROM empleado AS e
JOIN sucursal AS s
ON e.id_sucursal = s.id_sucursal
JOIN puesto AS p
ON p.id_puesto = e.id_puesto
ORDER BY sucursal;
---------------------






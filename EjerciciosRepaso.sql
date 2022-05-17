--Ejercicio 12 A
DELIMITER $$

CREATE OR REPLACE FUNCTION CALCULCAR_PRECIO_TOTAL_PEDIDO(COD INT)
RETURNS FLOAT
FOR EACH ROW
BEGIN
	DECLARE RES FLOAT;
	SELECT SUM(detalle_pedido.precio_unidad * detalle_pedido.cantidad) INTO RES FROM 	 detalle_pedido WHERE detalle_pedido.codigo_pedido = COD;
    RETURN RES;
END;$$

DELIMITER ;

--Ejercicio 12 b

DELIMITER $$

CREATE FUNCTION CALCULAR_SUMA_PEDIDOS_CLIENTE(COD_CLIENTE INT)
RETURNS FLOAT
BEGIN
	DECLARE RES FLOAT;
	DECLARE C1 CURSOR FOR SELECT SUM(detalle_pedido.precio_unidad * 						detalle_pedido.cantidad) 
	FROM detalle_pedido 
	WHERE detalle_pedido.codigo_pedido = (SELECT codigo_pedido FROM pedido WHERE 			codigo_CLIENTE = 5);
    
    OPEN C1;
    
    CLOSE C1;
	RETURN RES;
END;

SELECT CODIGO_CLIENTE, detalle_pedido.CODIGO_PEDIDO,SUM(detalle_pedido.precio_unidad * detalle_pedido.cantidad) AS PRECIO_TOTAL FROM pedido
JOIN detalle_pedido
ON pedido.codigo_pedido = detalle_pedido.codigo_pedido 
GROUP BY CODIGO_CLIENTE
ORDER BY `CODIGO_PEDIDO` ASC;

DELIMITER ;
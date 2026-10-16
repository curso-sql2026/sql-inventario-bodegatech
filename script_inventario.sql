-- ── SECCIÓN DDL ──────────────────────────

-- Paso 1: Eliminar la tabla si ya existe para permitir la re-ejecución sin errores
DROP TABLE IF EXISTS inventario;
GO

-- Paso 2: Crear la estructura de la tabla
CREATE TABLE inventario (
    id_producto INT PRIMARY KEY,               -- INT: Identificador numérico entero único, definido como Clave Primaria (PK).
    nombre_producto VARCHAR(100) NOT NULL,    -- VARCHAR(100): Cadena de texto de longitud variable hasta 100 caracteres, ahorra espacio según la longitud real.
    categoria VARCHAR(50) NOT NULL,          -- VARCHAR(50): Categorización de productos en texto breve.
    precio_unitario DECIMAL(10,2) NOT NULL,  -- DECIMAL(10,2): Exactitud numérica requerida para montos monetarios (hasta 8 enteros y 2 decimales), evitando errores de redondeo de FLOAT.
    stock_actual INT NOT NULL,               -- INT: Cantidad de unidades en existencia (valores enteros).
    stock_minimo INT NOT NULL,               -- INT: Umbral numérico para control de reorden de stock.
    fecha_ingreso DATE NOT NULL,             -- DATE: Almacena exclusivamente la fecha (año-mes-día) sin registro de hora.
    activo BIT NOT NULL                      -- BIT: Tipo nativo de SQL Server para valores booleanos (1 = verdadero/disponible, 0 = falso/descontinuado).
);
GO

-- ── SECCIÓN DML ──────────────────────────

-- Paso 3: Carga inicial de datos de los 10 productos
INSERT INTO inventario (id_producto, nombre_producto, categoria, precio_unitario, stock_actual, stock_minimo, fecha_ingreso, activo)
VALUES 
    (1, 'Laptop Pro 15', 'Computación', 1200.00, 15, 3, '2024-01-10', 1),
    (2, 'Mouse Inalámbrico', 'Accesorios', 28.00, 80, 10, '2024-01-10', 1),
    (3, 'Monitor 4K 27"', 'Computación', 450.00, 12, 2, '2024-01-15', 1),
    (4, 'Teclado Mecánico', 'Accesorios', 95.00, 40, 5, '2024-01-15', 1),
    (5, 'Laptop Basic 14', 'Computación', 650.00, 20, 3, '2024-02-01', 1),
    (6, 'Auriculares BT Pro', 'Audio', 120.00, 35, 5, '2024-02-01', 1),
    (7, 'Hub USB-C 7 puertos', 'Accesorios', 45.00, 60, 10, '2024-02-10', 1),
    (8, 'Webcam HD 1080p', 'Accesorios', 85.00, 25, 5, '2024-02-10', 1),
    (9, 'SSD Externo 1TB', 'Almacenamiento', 130.00, 18, 3, '2024-03-01', 1),
    (10, 'Parlante Bluetooth', 'Audio', 60.00, 45, 8, '2024-03-01', 1);
GO

-- Paso 4: Registro de ventas del día actualizando stock_actual

-- Venta de Laptop Pro 15 (3 unidades vendidas: 15 - 3 = 12)
UPDATE inventario
SET stock_actual = stock_actual - 3
WHERE id_producto = 1;

-- Venta de Mouse Inalámbrico (12 unidades vendidas: 80 - 12 = 68)
UPDATE inventario
SET stock_actual = stock_actual - 12
WHERE id_producto = 2;

-- Venta de Auriculares BT Pro (5 unidades vendidas: 35 - 5 = 30)
UPDATE inventario
SET stock_actual = stock_actual - 5
WHERE id_producto = 6;
GO

-- Paso 5: Descontinuar producto
-- Descontinuar Webcam HD 1080p (id: 8)
UPDATE inventario
SET activo = 0
WHERE id_producto = 8;
GO

-- Paso 6: Consulta de validación
SELECT * FROM inventario;
GO
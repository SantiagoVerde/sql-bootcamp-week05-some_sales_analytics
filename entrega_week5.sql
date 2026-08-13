-- SET UP de la base de datos
DROP DATABASE IF EXISTS techmart_analytics;
CREATE DATABASE techmart_analytics;
USE techmart_analytics;

SELECT DATABASE();  -- 

CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    category_id INT NOT NULL,
    price DECIMAL(10,2) NOT NULL CHECK (price > 0),
    cost DECIMAL(10,2) NOT NULL CHECK (cost > 0),
    stock INT DEFAULT 0 CHECK (stock >= 0),
    added_date DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    city VARCHAR(100),
    country VARCHAR(50),
    registered_at DATE DEFAULT (CURRENT_DATE)
);

CREATE TABLE sales (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL,
    discount DECIMAL(5,2) DEFAULT 0 CHECK (discount BETWEEN 0 AND 100),
    sale_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);


-- 5 categorías
INSERT INTO categories (name) VALUES
    ('Electronics'), ('Clothing'), ('Sports'), ('Home'), ('Books');

-- 24 productos
INSERT INTO products (name, category_id, price, cost, stock) VALUES
    ('HP Laptop 15',          1,  799.99, 600.00,  25),
    ('Logitech Mouse',        1,   25.99,  15.00, 150),
    ('Mechanical Keyboard',   1,   89.99,  50.00,  80),
    ('LG 27" Monitor',        1,  299.99, 200.00,  30),
    ('HD Webcam',             1,   79.99,  45.00,  60),
    ('Sony Headphones',       1,  149.99,  90.00,  45),
    ('Nike T-Shirt',          2,   29.99,  12.00, 200),
    ('Levi Jeans',            2,   59.99,  30.00, 120),
    ('Adidas Sneakers',       2,   89.99,  45.00,  90),
    ('North Face Jacket',     2,  149.99,  80.00,  50),
    ('Nike Cap',              2,   19.99,   8.00, 180),
    ('Soccer Ball',           3,   24.99,  10.00, 100),
    ('Tennis Racket',         3,  119.99,  60.00,  35),
    ('Mountain Bike',         3,  499.99, 300.00,  15),
    ('20kg Weights',          3,   79.99,  40.00,  45),
    ('Yoga Mat',              3,   29.99,  12.00,  80),
    ('Oster Blender',         4,   59.99,  30.00,  70),
    ('Nespresso Coffee Maker',4,  199.99, 120.00,  40),
    ('Dyson Vacuum',          4,  399.99, 250.00,  20),
    ('LED Lamp',              4,   34.99,  15.00, 100),
    ('Clean Code',            5,   39.99,  20.00,  60),
    ('Design Patterns',       5,   49.99,  25.00,  45),
    ('The Pragmatic Programmer', 5, 44.99, 22.00,  50),
    ('Refactoring',           5,   42.99,  21.00,  55);

-- 20 clientes
INSERT INTO customers (name, email, city, country, registered_at) VALUES
    ('Alice Garcia',     'alice@email.com',     'Madrid',         'Spain',     '2023-01-15'),
    ('Charles Lopez',    'charles@email.com',   'Barcelona',      'Spain',     '2023-02-20'),
    ('Mary Torres',      'mary@email.com',      'Mexico City',    'Mexico',    '2023-03-10'),
    ('John Perez',       'john@email.com',      'Buenos Aires',   'Argentina', '2023-04-05'),
    ('Lucy Martinez',    'lucy@email.com',      'Bogota',         'Colombia',  '2023-05-12'),
    ('Diego Fernandez',  'diego@email.com',     'Lima',           'Peru',      '2023-06-08'),
    ('Sophie Rodriguez', 'sophie@email.com',    'Santiago',       'Chile',     '2023-07-14'),
    ('Peter Sanchez',    'peter@email.com',     'Montevideo',     'Uruguay',   '2023-08-22'),
    ('Laura Ramirez',    'laura@email.com',     'Quito',          'Ecuador',   '2023-09-03'),
    ('Michael Angel',    'michael@email.com',   'Madrid',         'Spain',     '2023-10-17'),
    ('Carmen Diaz',      'carmen@email.com',    'Valencia',       'Spain',     '2023-11-09'),
    ('Robert Silva',     'robert@email.com',    'São Paulo',      'Brazil',    '2023-12-01'),
    ('Isabel Morales',   'isabel@email.com',    'Guadalajara',    'Mexico',    '2024-01-05'),
    ('Francis Ruiz',     'francis@email.com',   'Cordoba',        'Argentina', '2024-01-18'),
    ('Elena Castro',     'elena@email.com',     'Medellin',       'Colombia',  '2024-02-02'),
    ('Anthony Jimenez',  'anthony@email.com',   'Seville',        'Spain',     '2024-02-14'),
    ('Rose Vargas',      'rose@email.com',      'Monterrey',      'Mexico',    '2024-02-28'),
    ('Xavier Ortiz',     'xavier@email.com',    'Rosario',        'Argentina', '2024-03-12'),
    ('Patricia Herrera', 'patricia@email.com',  'Cali',           'Colombia',  '2024-03-25'),
    ('Manuel Navarro',   'manuel@email.com',    'Bilbao',         'Spain',     '2024-04-08');

-- 45 ventas (4 meses, mezcla de descuentos y categorías)
INSERT INTO sales (customer_id, product_id, quantity, unit_price, discount, sale_date) VALUES
    -- Enero 2024
    (1,  1,  1, 799.99,  0, '2024-01-05'),  (2,  2, 2,  25.99,  5, '2024-01-06'),
    (3,  7,  3,  29.99,  0, '2024-01-08'),  (4, 12, 2,  24.99, 10, '2024-01-10'),
    (5,  3,  1,  89.99,  0, '2024-01-12'),  (6, 21, 2,  39.99,  5, '2024-01-15'),
    (7,  8,  1,  59.99,  0, '2024-01-18'),  (8,  4, 1, 299.99, 10, '2024-01-20'),
    (9, 14,  1, 499.99, 15, '2024-01-22'),  (10, 6, 1, 149.99,  5, '2024-01-25'),
    -- Febrero
    (11, 9,  2,  89.99, 10, '2024-02-02'),  (12, 17, 1, 59.99,  0, '2024-02-05'),
    (13, 13, 1, 119.99,  5, '2024-02-08'),  (14, 10, 1, 149.99, 10, '2024-02-10'),
    (15, 18, 1, 199.99,  0, '2024-02-12'),  (16,  2, 5,  25.99, 15, '2024-02-15'),
    (17, 7,  4,  29.99,  5, '2024-02-18'),  (18, 22, 1,  49.99,  0, '2024-02-20'),
    (19, 15, 2,  79.99, 10, '2024-02-22'),  (20, 11, 3,  19.99,  5, '2024-02-25'),
    -- Marzo
    (1, 19,  1, 399.99, 20, '2024-03-02'),  (3,  5, 2,  79.99, 10, '2024-03-05'),
    (5, 23,  1,  44.99,  0, '2024-03-08'),  (7, 16, 1,  29.99,  5, '2024-03-10'),
    (9, 20,  3,  34.99,  0, '2024-03-12'),  (2,  3, 1,  89.99, 10, '2024-03-15'),
    (4,  8,  2,  59.99,  5, '2024-03-18'),  (6, 12, 3,  24.99,  0, '2024-03-20'),
    (8,  1,  1, 799.99,  5, '2024-03-22'),  (10, 4, 1, 299.99, 15, '2024-03-25'),
    -- Abril
    (12, 6,  1, 149.99, 10, '2024-04-02'),  (14, 13, 1, 119.99,  5, '2024-04-05'),
    (16, 9,  1,  89.99,  0, '2024-04-08'),  (18, 17, 1,  59.99, 10, '2024-04-10'),
    (20, 21, 3,  39.99,  5, '2024-04-12'),  (1,   2, 10, 25.99, 20, '2024-04-15'),
    (3,  7,  5,  29.99, 10, '2024-04-18'),  (5,  14, 1, 499.99, 10, '2024-04-20'),
    (7, 10,  1, 149.99,  5, '2024-04-22'),  (9,  18, 1, 199.99, 15, '2024-04-25'),
    (11, 15, 3,  79.99, 10, '2024-04-26'),  (13, 22, 2,  49.99,  5, '2024-04-27'),
    (15, 11, 4,  19.99,  0, '2024-04-28'),  (17, 16, 2,  29.99,  5, '2024-04-29'),
    (19, 23, 1,  44.99,  0, '2024-04-30');

-- KPI básicas
SELECT
    COUNT(*) AS total_sales,
    COUNT(DISTINCT customer_id) AS unique_customers,
     COUNT(DISTINCT product_id) AS distinc_products,
    SUM(quantity) AS units_sold,
    CONCAT('$',FORMAT(SUM(quantity*unit_price *(1 - discount/100)),2))AS revenue_total,
	CONCAT('$',FORMAT(AVG(quantity*unit_price*(1 - discount/100)),2)) AS ticket_promedio
FROM sales;
-- kpis por categoria
SELECT
	c.name as categories,
    COUNT(s.id) AS total_sales,
    COUNT(DISTINCT s.customer_id) AS unique_customers,
	COUNT(DISTINCT s.product_id) AS distinc_products,
    SUM(s.quantity) AS units_sold,
    CONCAT('$',FORMAT(SUM(s.quantity*s.unit_price *(1 - s.discount/100)),2))AS revenue_total,
	CONCAT('$',FORMAT(AVG(s.quantity*s.unit_price*(1 - s.discount/100)),2)) AS ticket_promedio
FROM sales s
LEFT JOIN  products p on s.product_id=p.id  
LEFT JOIN categories c on p.category_id= c.id
GROUP BY c.name
ORDER BY SUM(s.quantity*s.unit_price *(1 - s.discount/100)) desc;
-- TOP 10 productos con más ventas con categorias.
SELECT p.name as product, SUM(s.quantity) as units_sold 
from sales s
INNER JOIN products p on s.product_id=p.id
group by p.id, p.name
ORDER BY units_sold desc
LIMIT 10;
-- TOP 10 productos con más ventas
SELECT p.name as product,c.name as category , SUM(s.quantity) as units_sold 
from sales s
INNER JOIN products p on s.product_id=p.id
INNER JOIN categories c on p.category_id=c.id
group by p.id, p.name, c.name
ORDER BY units_sold desc
LIMIT 10;
-- Top 10 clientes que más gastaron
SELECT
	cus.name AS customer,
    COUNT(s.id) AS total_sales_per_client,
    SUM(s.quantity) AS total_units_for_client,
	CONCAT('$',FORMAT(SUM(s.quantity*s.unit_price *(1 - s.discount/100)),2))AS client_revenue
FROM customers cus
JOIN sales s ON cus.id=s.customer_id
GROUP BY cus.name, cus.id
ORDER BY SUM(s.quantity*s.unit_price *(1 - s.discount/100)) DESC
LIMIT 10;
-- Ingresos mensuales
SELECT 
	date_format(sale_date, '%Y-%m') as period, 
    CONCAT('$',	FORMAT(SUM(quantity*unit_price *(1 - discount/100)),2))AS monthly_revenue
FROM sales
GROUP BY date_format(sale_date, '%Y-%m')
ORDER BY date_format(sale_date, '%Y-%m');

/*Margen de Ganacia por Categoria*/

SELECT
	c.name as categories,
    SUM(s.quantity) AS units_sold,
    CONCAT('$',FORMAT(SUM(s.quantity*s.unit_price *(1 - s.discount/100)),2))AS revenue_total,
    CONCAT('$',FORMAT(SUM(s.quantity*p.cost),2)) AS costs,
	CONCAT('$',FORMAT(AVG(s.quantity*s.unit_price*(1 - s.discount/100)),2)) AS average_ticket,
    CONCAT('$',FORMAT(SUM((s.quantity*s.unit_price *(1 - s.discount/100)-(s.quantity*p.cost))),2))AS profit,
    CONCAT(ROUND(100*(
		(SUM(s.quantity*s.unit_price *(1 - s.discount/100))
        -SUM(s.quantity*p.cost))
        /SUM(s.quantity*p.cost))
        ,2),'%') AS markup,
	CONCAT(ROUND(100*
		(SUM(s.quantity*s.unit_price *(1 - s.discount/100))
        -SUM(s.quantity*p.cost))
        /SUM(s.quantity*s.unit_price *(1 - s.discount/100))
        ,2),'%') AS gross_margin
FROM sales s
LEFT JOIN products p on s.product_id=p.id  
LEFT JOIN categories c on p.category_id= c.id
GROUP BY c.name
ORDER BY SUM((s.quantity*s.unit_price *(1 - s.discount/100)-(s.quantity*p.cost))) desc;


-- KPIs por país
SELECT 
	cus.country as country, 
    COUNT(DISTINCT cus.id) AS clients ,
    COUNT(DISTINCT s.id) AS sales,
	CONCAT('$',FORMAT(SUM(s.quantity*s.unit_price *(1 - s.discount/100)),2))AS revenue,
    CONCAT('$',FORMAT(AVG(s.quantity*s.unit_price*(1 - s.discount/100)),2)) AS average_ticket,
    CONCAT('$',FORMAT(SUM((s.quantity*s.unit_price *(1 - s.discount/100)-(s.quantity*p.cost))),2))AS profit,
    CONCAT(ROUND(100*
		(SUM(s.quantity*s.unit_price *(1 - s.discount/100))
        -SUM(s.quantity*p.cost))
        /SUM(s.quantity*s.unit_price *(1 - s.discount/100))
        ,2),'%') AS gross_margin
FROM customers cus
LEFT JOIN sales s ON cus.id=s.customer_id
LEFT JOIN products p on s.product_id=p.id
GROUP BY cus.country
ORDER BY SUM(s.quantity*s.unit_price *(1 - s.discount/100)) desc;

SELECT  -- Productos con stock por debajo del promedio. LO que pide la consigna
	name AS products,
    stock as stock
FROM products
WHERE stock < (SELECT AVG(stock) FROM products)
ORDER by stock desc;

SELECT  -- Más datos, obliga a un JOIN
	p.name AS products,
    p.stock as stock,
    FORMAT((SELECT AVG(stock) FROM products),0) AS avg_stock,
    COALESCE(FORMAT(SUM(s.quantity),0),0) as units_sold
FROM products p
LEFT JOIN sales s on p.id=s.product_id
WHERE stock < (SELECT AVG(stock) FROM products)
GROUP BY p.name, p.stock
order by stock desc;


SELECT -- Análisis de descuentos, hice buckets dinámicos.
	CONCAT(f.rango * 10, "-", f.rango * 10 +(9)) as discount_range,
	COUNT(DISTINCT f.id) as number_products,
    SUM(quantity) as items_sold,
    CONCAT('$',FORMAT(AVG(f.unit_price),2)) as avg_pric,
    CONCAT('$',FORMAT(SUM(f.quantity*f.unit_price *(1 - f.discount/100)),2))AS revenue,
    CONCAT('$',FORMAT(SUM(f.quantity *f.unit_price *f.discount/100),2)) AS discount_given,
    CONCAT(ROUND(100*
		(SUM(f.quantity*f.unit_price *(1 - f.discount/100))
        -SUM(f.quantity*p.cost))
        /SUM(f.quantity*f.unit_price *(1 - f.discount/100))
        ,2),'%') AS gross_margin_with_discounts,
	CONCAT(ROUND(100*
		(SUM(f.quantity*f.unit_price )
        -SUM(f.quantity*p.cost))
        /SUM(f.quantity*f.unit_price )
        ,2),'%') AS gross_margin_without_discounts
    FROM
	(SELECT *, FLOOR(discount/10) as rango FROM sales WHERE discount>0) f
	LEFT JOIN products p on f.product_id= p.id
    GROUP by rango
    ORDER by rango;
    
    
    
-- orders and revenue by client
SELECT 
c.name as Customers, 
count(s.id) as number_of_orders, 
CONCAT('$',FORMAT(SUM(s.quantity*s.unit_price *(1 - s.discount/100)),2))AS total_revenue
FROM customers c
INNER JOIN sales s ON c.id=s.customer_id
GROUP BY c.name,c.id
HAVING number_of_orders >=2
ORDER BY number_of_orders desc, SUM(s.quantity*s.unit_price *(1 - s.discount/100)) desc;


-- Pareto % de revenue por categoria

SELECT 
	c.name as Category,
    CONCAT('$',FORMAT(SUM(s.quantity*s.unit_price *(1 - s.discount/100)),2))AS revenue,
    CONCAT(FORMAT((SUM(s.quantity*s.unit_price *(1 - s.discount/100)))
    /(SELECT SUM(quantity*unit_price *(1 - discount/100)) as revenue from sales)*100,2),"%")   as "% of total revenue"
    FROM categories c
    LEFT JOIN products p on c.id=p.category_id
    LEFT JOIN sales s on p.id=s.product_id
    GROUP BY c.name, c.id
    ORDER BY (SELECT SUM(quantity*unit_price *(1 - discount/100)) as revenue from sales)
    /(SUM(s.quantity*s.unit_price *(1 - s.discount/100)))*100;
    
-- Conversion de inventario, ¿Qué tan rapido rota el inventaario por categoria?
-- Variable a usar % de venta de stock por mes por categoria.
SELECT 
	c.name as Category, 
    CASE (m.mes)
		WHEN 1 THEN 'Jan'
        WHEN 2 THEN  'Feb'
        WHEN 3 THEN 'Mar'
        WHEN 4 THEN 'Apr'
        END as Month,
    CONCAT(FORMAT(COALESCE((ventas.sales_month_cat/stock.stock_by_cat),0)*100,2),"%") as "%stocksold by month by category"
FROM categories c
CROSS JOIN (SELECT DISTINCT MONTH(sale_date) as mes FROM sales) m
LEFT JOIN 
	(SELECT 
		NULLIF(SUM(stock),0) as stock_by_cat, 
		category_id 
        FROM products 
        GROUP BY category_id
	)stock on c.id=stock.category_id
LEFT JOIN 
	(SELECT 
    p.category_id, 
    SUM(s.quantity) as sales_month_cat, 
    MONTH(s.sale_date) as mes
	FROM sales s LEFT JOIN products p on s.product_id=p.id  
    GROUP BY p.category_id, MONTH(s.sale_date)
    ) ventas
ON ventas.category_id=stock.category_id and ventas.mes=m.mes
ORDER BY (ventas.sales_month_cat/stock.stock_by_cat)*100 desc,c.name, Month,c.id;

-- Crecimiento Mensual Comparar revenue por mes y % de crecimiento.
SELECT 
	CASE current.mes
		WHEN 1 THEN 'Jan'
        WHEN 2 THEN  'Feb'
        WHEN 3 THEN 'Mar'
        WHEN 4 THEN 'Apr'
        END as Month,
		
	CONCAT('$',FORMAT(current.revenue,2)) AS revenue,
	COALESCE(CONCAT(FORMAT((current.revenue - previous.revenue)/(previous.revenue)*100,2),"%"),"No hay mes de comparacion") as grown_to_last_month
FROM 
	(SELECT 
			MONTH( sale_date) as mes, 
			            SUM(quantity*unit_price *(1 - discount/100)) as revenue
            FROM sales
            GROUP BY mes
			) current
LEFT JOIN (SELECT 
			MONTH( sale_date) as mes, 
			SUM(quantity*unit_price *(1 - discount/100)) as revenue
            FROM sales
            GROUP BY mes
			) previous ON current.mes	= previous.mes+1
ORDER by current.mes;
-- Resumen ejecutivo
SELECT
    'Executive Summary' AS report,
    COUNT(DISTINCT v.id) AS total_sales,
    COUNT(DISTINCT v.customer_id) AS unique_customers,
    CONCAT('$', FORMAT(SUM(v.quantity * v.unit_price * (1 - v.discount/100)), 2)) AS revenue,
    CONCAT('$', FORMAT(SUM(v.quantity * p.cost), 2)) AS cost,
    CONCAT('$', FORMAT(
        SUM(v.quantity * v.unit_price * (1 - v.discount/100))
        - SUM(v.quantity * p.cost), 2
    )) AS profit,
    CONCAT(ROUND(
        100.0 *
        (SUM(v.quantity * v.unit_price * (1 - v.discount/100))
         - SUM(v.quantity * p.cost))
        / SUM(v.quantity * v.unit_price * (1 - v.discount/100)),
        2
    ), '%') AS margin_pct,
    CONCAT('$', FORMAT(AVG(v.quantity * v.unit_price * (1 - v.discount/100)), 2)) AS avg_ticket
FROM sales v
JOIN products p ON v.product_id = p.id;

-- ¿Qué día de la semana vende más?

SELECT 
	DAYNAME(sale_date) as "Day of the week",
    COUNT(id) as sales,
    CONCAT('$', FORMAT(SUM(quantity * unit_price * (1 - discount/100)), 2)) AS revenue,
    CONCAT(FORMAT(SUM(quantity * unit_price * (1 - discount/100))
    /(SELECT SUM(quantity * unit_price * (1 - discount/100)) FROM sales)*100,2),"%") AS "%revenue"
FROM sales
GROUP by DAYNAME(sale_date)
ORDER BY SUM(quantity * unit_price * (1 - discount/100)) desc;

-- "¿Cuál es el ticket promedio por categoría?"
SELECT 
	c.name as categoria,
    CONCAT('$', FORMAT(AVG(s.quantity * s.unit_price * (1 - s.discount/100)), 2)) AS avg_ticket
FROM categories c
    LEFT JOIN products p on c.id=p.category_id
    LEFT JOIN sales s on p.id=s.product_id
    GROUP BY c.name, c.id
    ORDER BY AVG(s.quantity * s.unit_price * (1 - s.discount/100)) desc;
    
-- "¿Productos que nunca se han vendido?" 

SELECT 
	p.name "0 sales products"
FROM products p
LEFT JOIN sales s on p.id= s.product_id
WHERE s.id IS NULL;

    

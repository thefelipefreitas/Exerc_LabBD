CREATE DATABASE teste_DazRoupaz
GO
USE teste_DazRoupaz

CREATE TABLE user_table (
comprador_id		INT		NOT NULL		PRIMARY KEY,
ativo				INT		NOT NULL
)
GO
CREATE TABLE sales_table (
id						INT				NOT NULL		PRIMARY KEY,
data_de_pagamento		DATETIME		NOT NULL,
vendedor_id				INT				NOT NULL,
comprador_id			INT				NOT NULL,
total_pago				DECIMAL(7,2)	NOT NULL
FOREIGN KEY (comprador_id) REFERENCES user_table(comprador_id)
)

SELECT * FROM user_table
SELECT * FROM sales_table

-- Quantos compradores ativos realizaram algum pagamento durante todo o periodo?
SELECT COUNT(ut.comprador_id) AS quantidade
FROM user_table ut, sales_table st
WHERE ut.comprador_id = st.comprador_id
		AND ut.ativo = 1
		AND st.total_pago > 0

-- Qual o valor total pago, pelos compradores ativos, em Maio de 2018?
SELECT SUM(st.total_pago) AS valor_total_pago
FROM sales_table st, user_table ut
WHERE st.comprador_id = ut.comprador_id
		AND ut.ativo = 1
		AND SUBSTRING(CONVERT(CHAR(8), st.data_de_pagamento, 112), 1, 6) = '201805'

--Qual o valor total pago, pelos compradores ativos, no ano de 2019? 
SELECT SUM(st.total_pago) AS valor_total_pago
FROM sales_table st, user_table ut
WHERE st.comprador_id = ut.comprador_id
		AND ut.ativo = 1
		AND SUBSTRING(CONVERT(CHAR(8), st.data_de_pagamento, 112), 1, 4) = '2019'

--Qual o valor total pago, pelos compradores inativos, durante todo período? 
SELECT SUM(st.total_pago) AS valor_total_pago
FROM sales_table st, user_table ut
WHERE st.comprador_id = ut.comprador_id
		AND ut.ativo = 0
		AND st.total_pago > 0

SELECT ut.comprador_id
FROM user_table ut
WHERE ut.comprador_id IN (01)
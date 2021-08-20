CREATE DATABASE exFuncAg
GO
USE exFuncAg

CREATE TABLE peca (
cod			CHAR(2)			NOT NULL		PRIMARY KEY,
nome		VARCHAR(25)		NOT NULL,
cor			VARCHAR(25)		NOT NULL,
peso		INT				NOT NULL,
cidade		VARCHAR(25)		NOT NULL
)
GO
CREATE TABLE fornecedor (
cod				CHAR(2)			NOT NULL		PRIMARY KEY,
nome			VARCHAR(25)		NOT NULL,
status_forn		INT				NOT NULL,
cidade			VARCHAR(25)		NOT NULL
)
GO
CREATE TABLE embarque (
cod_peca			CHAR(2)			NOT NULL,
cod_fornecedor		CHAR(2)			NOT NULL,
quantidade			INT				NOT NULL
PRIMARY KEY(cod_peca, cod_fornecedor)
FOREIGN KEY (cod_peca) REFERENCES peca(cod),
FOREIGN KEY (cod_fornecedor) REFERENCES fornecedor(cod)
)

-- OS DADOS FORAM INSERIDOS DIRETO NO SQL SERVER MANAGEMENT STUDIO!!!

--1) Obter o número de fornecedores da base de dados.
SELECT COUNT(forn.cod) AS num_fornecedores
FROM fornecedor forn

--2) Obter o número de cidades em que há fornecedores.
SELECT COUNT(forn.cidade) AS num
FROM fornecedor forn
WHERE forn.cidade IS NOT NULL
GROUP BY forn.cidade

--3) Obter o número de fornecedores com cidade informada.
SELECT COUNT(forn.cod) AS n_fornecedores, forn.cidade AS cidade
FROM fornecedor forn
GROUP BY cidade

--4) Obter a quantidade máxima embarcada.
SELECT MAX(emb.quantidade) AS qtde_maxima_embarcada
FROM embarque emb

--5) Obter o número de embarques de cada fornecedor.
SELECT COUNT(emb.cod_fornecedor) AS num_embarque_fornecedor
FROM embarque emb, fornecedor forn
WHERE emb.cod_fornecedor = forn.cod
GROUP BY emb.cod_fornecedor

--6) Obter o número de embarques de quantidade maior que 300 de cada fornecedor.
SELECT COUNT(emb.cod_fornecedor) AS n_qtde_embarque_m300
FROM embarque emb, fornecedor forn
WHERE emb.cod_fornecedor = forn.cod
		AND emb.quantidade > 300
GROUP BY emb.cod_fornecedor

--7)Obter a quantidade total embarcada de peças de cor cinza para cada fornecedor.
SELECT SUM(emb.quantidade) AS qtde_embarque_corcinza
FROM embarque emb, fornecedor forn, peca
WHERE emb.cod_fornecedor = forn.cod
		AND emb.cod_peca = peca.cod
		AND peca.cor = 'Cinza'
GROUP BY emb.cod_fornecedor

--8) Obter a quantidade total embarcada de peças para cada fornecedor.
--Exibir o resultado por ordem descendente de quantidade total embarcada. 
SELECT SUM(emb.quantidade) AS qtde_embarque_fornecedor
FROM embarque emb, fornecedor forn
WHERE emb.cod_fornecedor = forn.cod
GROUP BY emb.quantidade
ORDER BY qtde_embarque_fornecedor DESC

--9) Obter os códigos de fornecedores que tenham embarques de mais de 500 un
--de peças cinzas, junto com a quantidade de embarques de peças cinzas
SELECT forn.cod AS cod_fornecedor, SUM(emb.quantidade) AS qtde_embarques_cinza
FROM fornecedor forn, embarque emb, peca
WHERE forn.cod = emb.cod_fornecedor
		AND emb.cod_peca = peca.cod
		AND peca.cor = 'Cinza'
GROUP BY forn.cod
--NAO EXISTE NENHUM FORNECEDOR NA BASE QUE TENHA EMBARCADO MAIS DE 500 UN
--DE PEÇAS CINZAS

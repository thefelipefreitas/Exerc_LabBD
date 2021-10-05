use escola
--FELIPE FREITAS DA SILVA
--1110481922037

CREATE TABLE depto (
codigo		CHAR(5)			NOT NULL	PRIMARY KEY,
nome		VARCHAR(40)		NULL
)

CREATE TABLE disciplina (
codDepto		CHAR(5)			NOT NULL,
numero			INT				NOT NULL,
nome			VARCHAR(10)		NULL,
credito			INT				NULL
PRIMARY KEY (numero, codDepto)
FOREIGN KEY (codDepto) REFERENCES depto(codigo)
)

INSERT INTO depto (codigo, nome) VALUES
('EXATA', 'Setor de Ciências Exatas'),
('TECNO', 'Setor de Tecnologia')

INSERT INTO disciplina (codDepto, numero, nome, credito) VALUES
('TECNO', 5001, 'Algoritmos', 100),
('TECNO', 5002, 'Banco', 100),
('EXATA', 5003, 'Cálculo I', 100)


delimiter //  
CREATE PROCEDURE ATV_P1()  
BEGIN  
DECLARE @nomeDisc  VARCHAR(10)
DECLARE @creditoDisc INT
DECLARE @nomeMaior VARCHAR(10)
DECLARE @creditoMaior INT
DECLARE @done INT
  
DECLARE C1 CURSOR FOR 
SELECT dis.nome, dis.credito 
FROM depto
INNER JOIN disciplina dis ON depto.codigo = dis.codDepto
WHERE depto.nome = 'Setor de Tecnologia' 
ORDER BY dis.credito DESC

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1
OPEN C1
cursor_loop:LOOP
		FETCH C1 INTO @nomeDisc, @creditoDisc    
        IF (@creditoDisc >= @creditoMaior) THEN			
            SELECT @nomeDisc
			SET @creditoMaior := @creditoDisc
        END IF
        IF  @done =1 THEN
			leave cursor_loop
        END IF			
END LOOP cursor_loop
CLOSE C1
END
// 

CALL ATVP1()

-- A - FUNCIONOU


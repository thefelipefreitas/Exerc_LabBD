--FELIPE FREITAS DA SILVA
--1110481922037

use escola

CREATE TABLE professor_historico (
codigo		INT				NOT NULL	PRIMARY KEY,
codDepto	CHAR(5)			NOT NULL,
codTit		INT				NOT NULL,
nome		VARCHAR(40)		NULL,
ACAO		VARCHAR(20)		NULL,
DATA_MODIFICACAO	DATETIME	NULL
)

CREATE TRIGGER Trigger_Historico_Professor
ON dbo.professor
AFTER 
INSERT, UPDATE, DELETE
AS
BEGIN
	INSERT INTO dbo.professor_historico
	(codigo, codDepto, codTit, nome, ACAO, DATA_MODIFICACAO)
	SELECT codigo, codDepto, codTit, nome, 'INSERT', GETDATE()
	from inserted

	INSERT INTO dbo.professor_historico
	(codigo, codDepto, codTit, nome, ACAO, DATA_MODIFICACAO)
	SELECT codigo, codDepto, codTit, nome, 'UPDATE', GETDATE()
	from deleted

	INSERT INTO dbo.professor_historico
	(codigo, codDepto, codTit, nome, ACAO, DATA_MODIFICACAO)
	SELECT codigo, codDepto, codTit, nome, 'DELETE', GETDATE()
	from deleted
END

SELECT * FROM professor

INSERT INTO dbo.professor (codigo, codDepto, codTit, nome)
		VALUES (1004, 'EXATA', 2, 'Fabio Assunção')

UPDATE prof SET prof.codDepto = 'TECNO'
FROM professor prof
WHERE prof.codigo = 1004

DELETE FROM professor prof
WHERE prof.codigo = 1004

SELECT * FROM professor_historico




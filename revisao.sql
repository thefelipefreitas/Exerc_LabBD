CREATE DATABASE revisao
GO
USE revisao

CREATE TABLE professor (
id		CHAR(3)			NOT NULL,
nome	VARCHAR(25)		NOT NULL
PRIMARY KEY (id)
)
GO
CREATE TABLE classe (
id			SMALLINT	NOT NULL,
id_andar	SMALLINT	NOT NULL
PRIMARY KEY (id)
)
GO
CREATE TABLE estado (
sigla	CHAR(2)			NOT NULL,
nome	VARCHAR(40)		NOT NULL
PRIMARY KEY (sigla)
)
GO
CREATE TABLE aluno (
codigo			SMALLINT		NOT NULL,
nome			VARCHAR(45)		NOT NULL,
endereco		VARCHAR(100)	NOT NULL,
sigla_estado	CHAR(2)			NOT NULL,
id_classe		SMALLINT		NOT NULL
PRIMARY KEY (codigo)
FOREIGN KEY (id_classe) REFERENCES classe(id),
FOREIGN KEY (sigla_estado) REFERENCES estado(sigla)
)
GO
CREATE TABLE disciplina (
id		CHAR(3)			NOT NULL,
nome	VARCHAR(15)		NOT NULL,
professor_disciplina	CHAR(3)		NOT NULL,
nota_min_disciplina		SMALLINT	NOT NULL
PRIMARY KEY (id)
FOREIGN KEY (professor_disciplina) REFERENCES professor(id)
)
GO
CREATE TABLE aluno_disciplina (
cod_aluno			SMALLINT		NOT NULL,
id_disciplina		CHAR(3)			NOT NULL,
nota_aluno			SMALLINT		NOT NULL
PRIMARY KEY (cod_aluno, id_disciplina)
FOREIGN KEY(cod_aluno) REFERENCES aluno(codigo),
FOREIGN KEY(id_disciplina) REFERENCES disciplina(id)
)

INSERT INTO professor (id, nome) VALUES (
'JOI', 'JOILSON CARDOSO',
'OSE', 'OSEAS SANTANA',
'VIT', 'VITOR VASCONSELOS',
'FER', 'JOSE ROBERTO FERROLI',
'LIM', 'VALMIR LIMA',
'EDS', 'EDSON SILVA',
'WAG', 'WAGNER OKIDA'
)
GO
INSERT INTO estado (sigla, nome) VALUES (
'SP', 'SAO PAULO'
)
GO
INSERT INTO classe (id, id_andar) VALUES (
1, 1,
2, 2,
3, 3
)
GO
INSERT INTO disciplina (id, nome, professor_disciplina, nota_min_disciplina) VALUES (
'MAT', 'MATEMATICA', 'JOI', 7,
'POR', 'PORTUGUES', 'VIT', 5,
'FIS', 'FISICA', 'OSE', 3,
'HIS', 'HISTORIA', 'EDS', 2,
'GEO', 'GEOGRAFIA', 'WAG', 4,
'ING', 'INGLES', 'LIM', 2
)
GO
INSERT INTO aluno (codigo, nome, endereco, sigla_estado, id_classe) VALUES (
1, 'ANTONIO CARLOS PENTEADO', 'RUA X', 'SP', 1
2, 'AUROMIR DA SILVA', 'RUA W', 'SP', 1
3, 'ANDRE COSTA', 'RUA T', 'SP', 1
4, 'ROBERTO SOARES', 'RUA BW', 'SP', 2
5, 'DANIA', 'RUA CCC', 'SP', 2
6, 'CARLOS MAGALHAES', 'AV SP', 'SP', 2
7, 'MARCELO RAUBA', 'AV SAO LUIZ', 'SP', 3
8, 'FERNANDO', 'AV COUTYR', 'SP', 3
9, 'WALMIR BURIN', 'RUA ASSIS', 'SP', 3
)
GO
INSERT INTO aluno_disciplina (cod_aluno, id_disciplina, nota_aluno) VALUES (
1, 'MAT', 0,
2, 'MAT', 0,
3, 'MAT', 1,
4, 'POR', 2,
5, 'POR', 2,
6, 'POR', 2,
7, 'FIS', 3,
8, 'FIS', 3,
9, 'FIS', 3,
1, 'POR', 2,
2, 'POR', 2,
7, 'POR', 2,
1, 'FIS', 3
)

--A
--1
SELECT * FROM aluno

--2
SELECT dis.nome AS nome
FROM disciplina dis
WHERE dis.nota_min_disciplina < 5

--3
SELECT * FROM disciplina
WHERE disciplina.nota_min_disciplina >= 3 AND disciplina.nota_min_disciplina <= 5

--B
--1
SELECT * FROM aluno al
ORDER BY al.nome, al.id_classe

--2
SELECT * FROM aluno al
ORDER BY al.nome DESC

--3
SELECT DISTINCT al.nome AS nome_aluno
FROM aluno al, aluno_disciplina ad, disciplina dis
WHERE al.codigo = ad.cod_aluno
    AND dis.id = ad.id_disciplina
    AND dis.nome LIKE 'POR%'
	AND al.nome IN
	(
		SELECT DISTINCT al.nome AS nome_aluno
		FROM aluno al, aluno_disciplina ad, disciplina dis
		WHERE al.codigo = ad.cod_aluno
		AND dis.id = ad.id_disciplina
		AND dis.nome LIKE 'MAT%'
	)
GROUP BY al.nome

--C
--1
SELECT al.nome
FROM aluno al

--2
SELECT al.nome AS nome_aluno, al.endereco AS endereco_aluno
FROM aluno al, aluno_disciplina ad, disciplina dis
WHERE al.codigo = ad.cod_aluno
	AND dis.id = ad.id_disciplina
	AND dis.nome LIKE 'FIS%'

--3
SELECT al.nome AS nome_aluno, dis.nome AS nome_disciplina,
	'nº ' + CAST(cla.id AS VARCHAR(3)) + '. andar: ' + CAST(cla.id_andar AS VARCHAR(6)) AS classe
FROM aluno al, aluno_disciplina ad, disciplina dis, classe cla
WHERE al.codigo = ad.cod_aluno
	AND dis.id = ad.id_disciplina
	AND al.id_classe = cla.id
	AND dis.nome LIKE 'FIS%'

--D
--1
SELECT prof.nome AS nome_professor, dis.nome AS nome_disciplina
FROM professor prof, disciplina dis
WHERE prof.id = dis.professor_disciplina

SELECT prof.nome AS nome_professor
FROM professor prof
LEFT OUTER JOIN disciplina dis
ON prof.id = dis.professor_disciplina
WHERE dis.professor_disciplina IS NULL

--E
--1
INSERT INTO estado (sigla, nome) VALUES ('PI', 'PIAUI')
SELECT * FROM estado

INSERT INTO aluno (codigo, nome, endereco, sigla_estado, id_classe) VALUES
(10, 'ZE DO PIAUI', 'RUA DAS PALMEIRAS', 'PI', 3)
SELECT * FROM aluno

INSERT INTO aluno_disciplina (cod_aluno, id_disciplina, nota_aluno) VALUES 
(10, 'MAT', 7)
SELECT * FROM aluno_disciplina

SELECT DISTINCT prof.nome
FROM professor prof
WHERE prof.id IN (
                SELECT dis.professor_disciplina
				FROM disciplina dis
                WHERE dis.id IN (
                        SELECT ad.id_disciplina
						FROM aluno_disciplina ad
                        WHERE ad.cod_aluno IN (
                                    SELECT al.codigo 
									FROM aluno al
                                    WHERE al.sigla_estado IN (
                                                SELECT e.sigla
												FROM estado e
                                                WHERE e.nome = 'PIAUI'
                                            )
                                            AND al.id_classe IN (
                                                SELECT cla.id
												FROM classe cla
                                                WHERE cla.id_andar = 3
                                            )
                            )         
                    )
                )
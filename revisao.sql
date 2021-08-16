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
INSERT INTO aluno_disciplina (cod_aluno, id_disciplina, nota_aluno) (
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
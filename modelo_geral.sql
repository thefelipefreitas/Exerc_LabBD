CREATE DATABASE escola
GO
USE escola
GO
CREATE TABLE depto (
codDepto	CHAR(5)			NOT NULL	PRIMARY KEY,
nomeDepto	VARCHAR(40)		NULL
)
GO
CREATE TABLE disciplina (
codDepto		CHAR(5)			NOT NULL,
numDisc			INT				NOT NULL,
nomeDisc		VARCHAR(10)		NULL,
creditoDisc		INT				NULL
PRIMARY KEY (numDisc, codDepto)
FOREIGN KEY (codDepto) REFERENCES depto(codDepto)
)
GO
CREATE TABLE titulacao (
codTit		INT				NOT NULL	PRIMARY KEY,
nomeTit		VARCHAR(40)		NULL
)
GO
CREATE TABLE professor (
codProf		INT				NOT NULL	PRIMARY KEY,
codDepto	CHAR(5)			NOT NULL,
codTit		INT				NOT NULL,
nomeProf	VARCHAR(40)		NULL
FOREIGN KEY (codDepto) REFERENCES depto(codDepto),
FOREIGN KEY (codTit) REFERENCES titulacao(codTit)
)
GO
CREATE TABLE turma (
anoSem		INT			NOT NULL,
codDepto	CHAR(5)		NOT NULL,
numDisc		INT			NOT NULL,
siglaTur	CHAR(2)		NOT NULL,
capacTur	INT			NULL
PRIMARY KEY (anoSem, codDepto, numDisc, siglaTur)
FOREIGN KEY (codDepto, numDisc) REFERENCES disciplina(codDepto, numDisc)
)
GO
CREATE TABLE profturma (
anoSem		INT			NOT NULL,
codDepto	CHAR(5)		NOT NULL,
numDisc		INT			NOT NULL,
siglaTur	CHAR(2)		NOT NULL,
codProf		INT			NOT NULL
PRIMARY KEY(anoSem, codDepto, numDisc, siglaTur, codProf)
FOREIGN KEY (anoSem, codDepto, numDisc, siglaTur) REFERENCES turma(anoSem, codDepto, numDisc, siglaTur),
FOREIGN KEY (codProf) REFERENCES professor(codProf)
)
GO
CREATE TABLE prereq (
codDeptoPreReq		CHAR(5),
numDiscPreReq		INT,
codDepto			CHAR(5),
numDisc				INT
PRIMARY KEY (codDeptoPreReq, numDiscPreReq, codDepto, numDisc)
FOREIGN KEY (codDepto, numDisc)	REFERENCES disciplina(codDepto, numDisc),
FOREIGN KEY (codDeptoPreReq, numDiscPreReq) REFERENCES disciplina(codDepto, numDisc)
)
GO
CREATE TABLE predio (
codPred		INT				NOT NULL	PRIMARY KEY,
nomePred	VARCHAR(40)		NOT NULL
)
GO
CREATE TABLE sala (
codPred				INT				NOT NULL,
numSala				INT				NOT NULL,
descricaoSala		VARCHAR(40)		NULL,
capacSala			INT				NULL
PRIMARY KEY (codPred, numSala)
FOREIGN KEY (codPred)	REFERENCES	predio(codPred)
)
GO
CREATE TABLE horario (
anoSem			INT			NOT NULL,
codDepto		CHAR(5)		NOT NULL,
numDisc			INT			NOT NULL,
siglaTur		CHAR(2)		NOT NULL,
diaSem			INT			NOT NULL,
horaInicio		INT			NOT NULL,
numSala			INT			NOT NULL,
codPred			INT			NOT NULL,
numHoras		INT			NOT NULL
PRIMARY KEY (anoSem, codDepto, numDisc, siglaTur, diaSem, horaInicio)
FOREIGN KEY (anoSem, codDepto, numDisc, siglaTur) REFERENCES turma(anoSem, codDepto, numDisc, siglaTur),
FOREIGN KEY (numSala, codPred) REFERENCES sala(numSala, codPred)
)


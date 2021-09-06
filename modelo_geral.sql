CREATE DATABASE escola
GO
USE escola
GO
CREATE TABLE depto (
codigo		CHAR(5)			NOT NULL	PRIMARY KEY,
nome		VARCHAR(40)		NULL
)
GO
CREATE TABLE disciplina (
codDepto		CHAR(5)			NOT NULL,
numero			INT				NOT NULL,
nome			VARCHAR(10)		NULL,
credito			INT				NULL
PRIMARY KEY (numero, codDepto)
FOREIGN KEY (codDepto) REFERENCES depto(codigo)
)
GO
CREATE TABLE titulacao (
codigo		INT				NOT NULL	PRIMARY KEY,
nome		VARCHAR(40)		NULL
)
GO
CREATE TABLE professor (
codigo		INT				NOT NULL	PRIMARY KEY,
codDepto	CHAR(5)			NOT NULL,
codTit		INT				NOT NULL,
nome    	VARCHAR(40)		NULL
FOREIGN KEY (codDepto) REFERENCES depto(codigo),
FOREIGN KEY (codTit) REFERENCES titulacao(codigo)
)
GO
CREATE TABLE turma (
anoSem			INT			NOT NULL,
codDepto		CHAR(5)		NOT NULL,
numDisc			INT			NOT NULL,
sigla   		CHAR(2)		NOT NULL,
capacidade		INT			NULL
,PRIMARY KEY (anoSem, codDepto, numDisc, sigla)
,FOREIGN KEY (numDisc, codDepto) REFERENCES disciplina(numero, codDepto)
)
GO
CREATE TABLE profturma (
anoSem		INT			NOT NULL,
codDepto	CHAR(5)		NOT NULL,
numDisc		INT			NOT NULL,
siglaTur	CHAR(2)		NOT NULL,
codProf		INT			NOT NULL
PRIMARY KEY(anoSem, codDepto, numDisc, siglaTur, codProf)
,FOREIGN KEY (anoSem, codDepto, numDisc, siglaTur) REFERENCES turma(anoSem, codDepto, numDisc, sigla),
FOREIGN KEY (codProf) REFERENCES professor(codigo)
)
GO
CREATE TABLE prereq (
codDeptoPreReq		CHAR(5)		NOT NULL,
numDiscPreReq		INT			NOT NULL,
codDepto			CHAR(5)		NOT NULL,
numDisc				INT			NOT NULL
PRIMARY KEY (codDeptoPreReq, numDiscPreReq, codDepto, numDisc)
,FOREIGN KEY (numDisc, codDepto)	REFERENCES disciplina(numero, codDepto),
FOREIGN KEY (numDiscPreReq, codDeptoPreReq) REFERENCES disciplina(numero, codDepto)
)
GO
CREATE TABLE predio (
codigo		INT				NOT NULL	PRIMARY KEY,
nome		VARCHAR(40)		NOT NULL
)
GO
CREATE TABLE sala (
codPred				INT				NOT NULL,
numero				INT				NOT NULL,
descricao			VARCHAR(40)		NULL,
capacidade			INT				NULL
PRIMARY KEY (codPred, numero)
FOREIGN KEY (codPred)	REFERENCES	predio(codigo)
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
,FOREIGN KEY (anoSem, codDepto, numDisc, siglaTur) REFERENCES turma(anoSem, codDepto, numDisc, sigla),
FOREIGN KEY (codPred, numSala) REFERENCES sala(codPred, numero)
)


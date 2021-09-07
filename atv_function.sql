CREATE TABLE aluno ( 
cod		INT				NOT NULL		PRIMARY KEY, 
nome	VARCHAR(50)		NOT NULL
)

CREATE TABLE aluno_turma ( 
codAluno		INT,
statusAluno		VARCHAR(20),   
anoSemTurma		INT,
codDepto		CHAR(5),
numDisc			INT,
siglaTur		CHAR(2)
PRIMARY KEY (codAluno, anoSemTurma, codDepto, numDisc, siglaTur)
,FOREIGN KEY (anoSemTurma, codDepto, numDisc, siglaTur) REFERENCES turma(anoSem, codDepto, numDisc, sigla),
FOREIGN KEY (codAluno) REFERENCES aluno(cod)
)

INSERT INTO predio (codigo, nome) VALUES
(1, 'Exatas'),
(2, 'Humanas'),
(3, 'Biológicas')

INSERT INTO sala (codPred, numero, descricao, capacidade) VALUES
(1, 101, 'Sala 101', 40),
(1, 102, 'Sala 102', 40),
(2, 201, 'Sala 201', 40),
(3, 301, 'Lab. 301', 30)

INSERT INTO depto (codigo, nome) VALUES
('EXATA', 'Setor de Ciências Exatas'),
('TECNO', 'Setor de Tecnologia')

INSERT INTO titulacao (codigo, nome) VALUES
(1, 'Mestre'),
(2, 'Doutor')

INSERT INTO professor (codigo, codDepto, codTit, nome) VALUES
(1001, 'TECNO', 1, 'Leandro Colevati'),
(1002, 'TECNO', 2, 'Marcos Alonso'),
(1003, 'EXATA', 1, 'Robson Soares')

INSERT INTO disciplina (codDepto, numero, nome, credito) VALUES
('TECNO', 5001, 'Algoritmos', 100),
('TECNO', 5002, 'Banco', 100),
('EXATA', 5003, 'Cálculo I', 100)

INSERT INTO turma (anoSem, codDepto, numDisc, sigla, capacidade) VALUES
(20201, 'TECNO', 5001, 'A1', 40),
(20191, 'EXATA', 5003, 'B1', 40),
(20192, 'TECNO', 5002, 'A2', 40)

INSERT INTO profturma (anoSem, codDepto, numDisc, siglaTur, codProf) VALUES
(20201, 'TECNO', 5001, 'A1', 1002),
(20192, 'TECNO', 5002, 'A2', 1001),
(20191, 'EXATA', 5003, 'B1', 1003)

INSERT INTO aluno (cod, nome) VALUES
(7001, 'Cássio Ramos'),
(7002, 'Roger Guedes'),
(7003, 'Renato Augusto'),
(7004, 'Marcelinho Carioca'),
(7005, 'José Ferreira Neto'),
(7006, 'Fagner Lemos'),
(7007, 'Emerson Sheik')

CREATE FUNCTION aprovacao(@cred VARCHAR(20))
RETURNS VARCHAR(20)
BEGIN
	DECLARE @total_creditos INT;
	DECLARE @ano_semestre INT;
	DECLARE @num_disciplina INT;
	DECLARE @situacao VARCHAR(40);

	IF @cred >= 50
		BEGIN
			SET @situacao = 'APROVADO';	 
		END 
	ELSE 
		BEGIN
			IF @cred > 20 AND @cred < 50
				BEGIN
					SET @situacao = 'EM AVALIAÇÃO';
				END
			ELSE
				BEGIN
					SET @situacao = 'REPROVADO';
				END
		END
RETURN @situacao;
END

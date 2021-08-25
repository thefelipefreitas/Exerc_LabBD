CREATE PROCEDURE AddNovaPeca
	@Nome VARCHAR(25),
	@Cor VARCHAR(25),
	@Peso INT,
	@Cidade VARCHAR(25)
AS
BEGIN
	DECLARE @vIdPeca INT;

	SELECT @vIdPeca = max(cod) + 1 from peca;

	INSERT INTO peca (cod, nome, cor, peso, cidade)
	VALUES (@vIdPeca, @Nome, @Cor, @Peso, @Cidade);

END;
GO

exec AddNovaPeca 'teste', 'preto', '1', 'Ali';

CREATE PROCEDURE Add5000
	@Nome VARCHAR(25),
	@Cor VARCHAR(25),
	@Peso INT,
	@Cidade VARCHAR(25)
AS
	DECLARE @vIdPeca INT;
	DECLARE @count INT;

	SET @count =1;

	WHILE @count <= 5000
BEGIN
	SELECT @vIdPeca = max(cod) + 1 from peca;

	INSERT INTO peca (cod, nome, cor, peso, cidade)
	VALUES (@vIdPeca, @Nome+CAST(@count AS VARCHAR), @Cor+CAST(@count AS VARCHAR), @Peso+CAST(@count AS VARCHAR), @Cidade);

	SET @count = @count +1;

END;
GO

exec Add5000 'Martelo', 'Cinza', '1', 'SP';

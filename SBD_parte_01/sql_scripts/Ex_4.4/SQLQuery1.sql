-- Rafael Santos - 118336 - Ex. 4.4

-- Selecionar a base de dados onde vamos trabalhar
USE sbd24_118336;
GO
--------------------------------------------------------------------------------
-- AJUSTES NA TABELA disease2class
--------------------------------------------------------------------------------

-- 1. Remover a chave primária temporariamente
ALTER TABLE diseaseClass
DROP CONSTRAINT PK_diseaseClass;

-- 2. Alterar o tipo da coluna
ALTER TABLE diseaseClass
ALTER COLUMN diseaseClassNID SMALLINT NOT NULL;

-- 3. Recriar a chave primária
ALTER TABLE diseaseClass
ADD CONSTRAINT PK_diseaseClass PRIMARY KEY (diseaseClassNID);

-- 4. Adicionar foreign key: diseaseNID → diseaseAttributes
ALTER TABLE dbo.disease2class
ADD CONSTRAINT FK_disease2class_diseaseNID
FOREIGN KEY (diseaseNID)
REFERENCES dbo.diseaseAttributes(diseaseNID);

-- 5. Adicionar foreign key: diseaseClassNID → diseaseClass
ALTER TABLE dbo.disease2class
ADD CONSTRAINT FK_disease2class_diseaseClassNID
FOREIGN KEY (diseaseClassNID)
REFERENCES dbo.diseaseClass(diseaseClassNID);


--------------------------------------------------------------------------------
-- AJUSTES NA TABELA geneAttributes
--------------------------------------------------------------------------------

-- 1. Ajustar tipo da coluna geneDescription
ALTER TABLE geneAttributes
ALTER COLUMN geneDescription VARCHAR(255) NOT NULL;

-- 2. Ajustar colunas pLI, DSI e DPI de varchar(50) para FLOAT
ALTER TABLE geneAttributes
ALTER COLUMN pLI FLOAT NULL;

ALTER TABLE geneAttributes
ALTER COLUMN DSI FLOAT NULL;

ALTER TABLE geneAttributes
ALTER COLUMN DPI FLOAT NULL;


--------------------------------------------------------------------------------
-- AJUSTES NA TABELA geneDiseaseNetwork
--------------------------------------------------------------------------------

-- 1. Alterar a coluna 'score' para FLOAT
ALTER TABLE geneDiseaseNetwork
ALTER COLUMN score FLOAT NULL;

-- 2. Alterar a coluna 'EL' para NVARCHAR(50)
-- Obs: Mantém EL como texto para preservar classificações como "definitive", etc.
ALTER TABLE geneDiseaseNetwork
ALTER COLUMN EL NVARCHAR(50) NULL;

-- 3. Alterar a coluna 'EI' para FLOAT
ALTER TABLE geneDiseaseNetwork
ALTER COLUMN EI FLOAT NULL;

-- 4. Adicionar foreign key: diseaseNID → diseaseAttributes
ALTER TABLE geneDiseaseNetwork
ADD CONSTRAINT FK_geneDiseaseNetwork_diseaseNID
FOREIGN KEY (diseaseNID)
REFERENCES diseaseAttributes(diseaseNID);

-- 5. Adicionar foreign key: geneNID → geneAttributes
ALTER TABLE geneDiseaseNetwork
ADD CONSTRAINT FK_geneDiseaseNetwork_geneNID
FOREIGN KEY (geneNID)
REFERENCES geneAttributes(geneNID);


--------------------------------------------------------------------------------
-- AJUSTES NA TABELA variantAttributes
--------------------------------------------------------------------------------

-- 1. Remover a chave primária temporariamente
ALTER TABLE dbo.variantAttributes
DROP CONSTRAINT PK_variantAttributes;

-- 2. Alterar o tipo da coluna variantNID para INT
ALTER TABLE dbo.variantAttributes
ALTER COLUMN variantNID INT NOT NULL;

-- 3. Recriar a chave primária
ALTER TABLE dbo.variantAttributes
ADD CONSTRAINT PK_variantAttributes PRIMARY KEY (variantNID);

-- 4. Corrigir valores '\N' nas colunas DSI e DPI
UPDATE dbo.variantAttributes
SET DSI = NULL
WHERE DSI = '\N';

UPDATE dbo.variantAttributes
SET DPI = NULL
WHERE DPI = '\N';

-- 5. Alterar colunas DSI e DPI para FLOAT
ALTER TABLE dbo.variantAttributes
ALTER COLUMN DSI FLOAT NULL;

ALTER TABLE dbo.variantAttributes
ALTER COLUMN DPI FLOAT NULL;


--------------------------------------------------------------------------------
-- AJUSTES NA TABELA variantDiseaseNetwork
--------------------------------------------------------------------------------

-- 1. Verificar valores não convertíveis em score e EI
SELECT * FROM dbo.variantDiseaseNetwork
WHERE TRY_CAST(score AS FLOAT) IS NULL AND score IS NOT NULL;

SELECT * FROM dbo.variantDiseaseNetwork
WHERE TRY_CAST(EI AS FLOAT) IS NULL AND EI IS NOT NULL;

-- 2. Alterar colunas score e EI para FLOAT
ALTER TABLE dbo.variantDiseaseNetwork
ALTER COLUMN score FLOAT NULL;

ALTER TABLE dbo.variantDiseaseNetwork
ALTER COLUMN EI FLOAT NULL;


--------------------------------------------------------------------------------
-- AJUSTES NA TABELA variantGene
--------------------------------------------------------------------------------

-- 1. Remover registros com geneNID inválidos (não existentes em geneAttributes)
DELETE FROM variantGene
WHERE geneNID NOT IN (
    SELECT geneNID FROM geneAttributes
);

-- 2. Adicionar foreign key: geneNID → geneAttributes
ALTER TABLE dbo.variantGene
ADD CONSTRAINT FK_variantGene_geneNID
FOREIGN KEY (geneNID)
REFERENCES dbo.geneAttributes(geneNID);

-- 3. Adicionar foreign key: variantNID → variantAttributes
ALTER TABLE dbo.variantGene
ADD CONSTRAINT FK_variantGene_variantNID
FOREIGN KEY (variantNID)
REFERENCES dbo.variantAttributes(variantNID);


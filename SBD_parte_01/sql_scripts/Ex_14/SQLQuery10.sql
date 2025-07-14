-- Rafael Santos - 118336 - Ex. 14

-- Selecionar a base de dados
USE sbd24_118336;
GO

-- Criar tabela com os tipos de doença únicos
CREATE TABLE dbo.diseaseTypes (
    type VARCHAR(50) PRIMARY KEY
);

-- Preencher com tipos distintos da tabela original
INSERT INTO dbo.diseaseTypes(type)
SELECT DISTINCT type
FROM dbo.diseaseAttributes
WHERE type IS NOT NULL;

-- Criar nova versão da tabela diseaseAttributes com FK
CREATE TABLE dbo.diseaseAttributes_v2 (
    diseaseNID SMALLINT PRIMARY KEY,
    diseaseId VARCHAR(255) NOT NULL,
    diseaseName VARCHAR(255) NOT NULL,
    type VARCHAR(50) NOT NULL FOREIGN KEY REFERENCES dbo.diseaseTypes(type)
);

-- Copiar os dados da tabela original para a nova (apenas tipos válidos)
INSERT INTO dbo.diseaseAttributes_v2 (diseaseNID, diseaseId, diseaseName, type)
SELECT diseaseNID, diseaseId, diseaseName, type
FROM dbo.diseaseAttributes
WHERE type IN (SELECT type FROM dbo.diseaseTypes);

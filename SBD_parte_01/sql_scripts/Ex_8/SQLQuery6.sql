-- Rafael Santos - 118336 - Ex. 8
-- Demonstração de melhoria de performance com índices

-- Selecionar a base de dados
USE sbd24_118336;
GO

-- Exemplo 1: Criar índice em diseaseName para acelerar filtros simples
CREATE INDEX IX_diseaseAttributes_diseaseName 
ON dbo.diseaseAttributes(diseaseName);
GO

-- Consulta que se beneficia do índice criado
SELECT * 
FROM dbo.diseaseAttributes
WHERE diseaseName = 'Diabetes mellitus';
GO

-- Exemplo 2: Criar índice em geneName para acelerar joins com filtro

-- Consulta antes da criação do índice (sem otimização)
SELECT * 
FROM dbo.geneDiseaseNetwork gdn
JOIN dbo.geneAttributes g ON gdn.geneNID = g.geneNID
WHERE g.geneName = 'BRCA1';
GO

-- Criar índice sobre geneName para otimizar a pesquisa
CREATE INDEX IX_geneAttributes_geneName 
ON dbo.geneAttributes(geneName);
GO

-- Consulta após a criação do índice (otimizada)
SELECT * 
FROM dbo.geneDiseaseNetwork gdn
JOIN dbo.geneAttributes g ON gdn.geneNID = g.geneNID
WHERE g.geneName = 'BRCA1';
GO
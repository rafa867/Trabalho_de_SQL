-- Rafael Santos - 118336 - Ex. 8
-- Demonstra��o de melhoria de performance com �ndices

-- Selecionar a base de dados
USE sbd24_118336;
GO

-- Exemplo 1: Criar �ndice em diseaseName para acelerar filtros simples
CREATE INDEX IX_diseaseAttributes_diseaseName 
ON dbo.diseaseAttributes(diseaseName);
GO

-- Consulta que se beneficia do �ndice criado
SELECT * 
FROM dbo.diseaseAttributes
WHERE diseaseName = 'Diabetes mellitus';
GO

-- Exemplo 2: Criar �ndice em geneName para acelerar joins com filtro

-- Consulta antes da cria��o do �ndice (sem otimiza��o)
SELECT * 
FROM dbo.geneDiseaseNetwork gdn
JOIN dbo.geneAttributes g ON gdn.geneNID = g.geneNID
WHERE g.geneName = 'BRCA1';
GO

-- Criar �ndice sobre geneName para otimizar a pesquisa
CREATE INDEX IX_geneAttributes_geneName 
ON dbo.geneAttributes(geneName);
GO

-- Consulta ap�s a cria��o do �ndice (otimizada)
SELECT * 
FROM dbo.geneDiseaseNetwork gdn
JOIN dbo.geneAttributes g ON gdn.geneNID = g.geneNID
WHERE g.geneName = 'BRCA1';
GO
-- Rafael Santos - 118336 - Ex. 6

-- Selecionar a base de dados onde vamos trabalhar
USE sbd24_118336;
GO

-- Criar a view para doenças do tipo 'phenotype'
CREATE VIEW dbo.vw_PhenotypeDiseases AS
SELECT 
    da.diseaseId,           
    da.diseaseName,         
    dc.diseaseClassName     
FROM dbo.diseaseAttributes da
JOIN dbo.disease2class d2c ON da.diseaseNID = d2c.diseaseNID
JOIN dbo.diseaseClass dc ON d2c.diseaseClassNID = dc.diseaseClassNID
WHERE da.type = 'phenotype';

-- Consultar os dados diretamente da view criada
SELECT * FROM dbo.vw_PhenotypeDiseases;

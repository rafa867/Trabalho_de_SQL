-- Rafael Santos - 118336 - Ex. 7

-- Selecionar a base de dados usada nos acessos remotos
USE sbd24_118336;
GO

-- O utilizador atual ('sbd24_118336') j� � o dono da base de dados (dbo), pelo que tem automaticamente todas as permiss�es necess�rias.
-- N�o � necess�rio criar novos utilizadores nem fazer GRANT de permiss�es.

-- No entanto, os comandos abaixo demonstram como seriam atribu�dos os privil�gios caso fosse necess�rio partilhar o acesso com outro utilizador SQL.

-- Exemplos de GRANT (comentados, pois n�o se aplicam neste contexto):

/*
GRANT SELECT ON dbo.diseaseAttributes TO outro_utilizador;
GRANT SELECT ON dbo.disease2class TO outro_utilizador;
GRANT SELECT ON dbo.diseaseClass TO outro_utilizador;
GRANT SELECT ON dbo.geneAttributes TO outro_utilizador;
GRANT SELECT ON dbo.geneDiseaseNetwork TO outro_utilizador;
GRANT SELECT ON dbo.variantAttributes TO outro_utilizador;
GRANT SELECT ON dbo.variantDiseaseNetwork TO outro_utilizador;
GRANT SELECT ON dbo.variantGene TO outro_utilizador;
GRANT SELECT ON dbo.vw_PhenotypeDiseases TO outro_utilizador;
*/


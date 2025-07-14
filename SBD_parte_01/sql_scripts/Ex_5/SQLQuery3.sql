-- Rafael Santos - 118336 - Ex. 5

-- Selecionar a base de dados onde vamos trabalhar
USE sbd24_118336;
GO

-- Comandos SQL para listar o número de registos e os primeiros 50 registos de cada tabela

-- Tabela 1: diseaseAttributes
SELECT COUNT(*) AS total_registos_diseaseAttributes FROM diseaseAttributes;
SELECT TOP 50 * FROM diseaseAttributes;

-- Tabela 2: diseaseClass
SELECT COUNT(*) AS total_registos_diseaseClass FROM diseaseClass;
SELECT TOP 50 * FROM diseaseClass;

-- Tabela 3: disease2class
SELECT COUNT(*) AS total_registos_disease2class FROM disease2class;
SELECT TOP 50 * FROM disease2class;

-- Tabela 4: geneAttributes
SELECT COUNT(*) AS total_registos_geneAttributes FROM geneAttributes;
SELECT TOP 50 * FROM geneAttributes;

-- Tabela 5: geneDiseaseNetwork
SELECT COUNT(*) AS total_registos_geneDiseaseNetwork FROM geneDiseaseNetwork;
SELECT TOP 50 * FROM geneDiseaseNetwork;

-- Tabela 6: variantAttributes
SELECT COUNT(*) AS total_registos_variantAttributes FROM variantAttributes;
SELECT TOP 50 * FROM variantAttributes;

-- Tabela 7: variantDiseaseNetwork
SELECT COUNT(*) AS total_registos_variantDiseaseNetwork FROM variantDiseaseNetwork;
SELECT TOP 50 * FROM variantDiseaseNetwork;

-- Tabela 8: variantGene
SELECT COUNT(*) AS total_registos_variantGene FROM variantGene;
SELECT TOP 50 * FROM variantGene;

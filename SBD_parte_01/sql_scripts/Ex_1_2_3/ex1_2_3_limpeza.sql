-- Rafael Santos___ex: 1,2 e 3 da parte 1


--REMOVER FONTES DESNECESSÁRIAS
DELETE FROM geneDiseaseNetwork WHERE source IN ('CLINVAR', 'UNIPROT', 'HPO');
DELETE FROM variantDiseaseNetwork WHERE source IN ('CLINVAR', 'UNIPROT', 'HPO');

-- Verificar contagens após remoção de fontes irrelevantes
SELECT COUNT(*) FROM geneDiseaseNetwork;     -- Esperado: 280679
SELECT COUNT(*) FROM variantDiseaseNetwork;  -- Esperado: 157786

-- Compactar espaço 
VACUUM;

-- Verificação manual do ficheiro: ~134 MB


-- AVALIAR O TAMANHO DAS TABELAS

-- Verificar o número de registos por tabela
SELECT COUNT(*) FROM disease2class;             -- 38.324
SELECT COUNT(*) FROM diseaseAttributes;         -- 30.293
SELECT COUNT(*) FROM diseaseClass;              -- 26
SELECT COUNT(*) FROM geneAttributes;            -- 26.137
SELECT COUNT(*) FROM geneDiseaseNetwork;        -- 280.679
SELECT COUNT(*) FROM variantAttributes;         -- 194.515
SELECT COUNT(*) FROM variantDiseaseNetwork;     -- 157.786
SELECT COUNT(*) FROM variantGene;               -- 172.427

-- Analisar estrutura de tabelas com mais de 100.000 registos
PRAGMA table_info(geneDiseaseNetwork);
PRAGMA table_info(variantAttributes);
PRAGMA table_info(variantDiseaseNetwork);
PRAGMA table_info(variantGene);


-- LIMPEZA INICIAL POR CRITÉRIOS LEVES
-- geneDiseaseNetwork: score fraco (< 0.1)
DELETE FROM geneDiseaseNetwork
WHERE score < 0.1;

-- variantAttributes: DSI < 0.1
DELETE FROM variantAttributes
WHERE DSI < 0.1;

-- Apagar registos dependentes com DPI < 0.1
DELETE FROM variantDiseaseNetwork
WHERE variantNID IN (
    SELECT variantNID FROM variantAttributes WHERE DPI < 0.1
);

DELETE FROM variantGene
WHERE variantNID IN (
    SELECT variantNID FROM variantAttributes WHERE DPI < 0.1
);

DELETE FROM variantAttributes
WHERE DPI < 0.1;

-- variantDiseaseNetwork: score < 0.1 ou EI < 0.1
DELETE FROM variantDiseaseNetwork
WHERE score < 0.1;

DELETE FROM variantDiseaseNetwork
WHERE EI < 0.1;

-- Compactar após esta fase
VACUUM;

-- Verificar totais
SELECT COUNT(*) FROM geneDiseaseNetwork;
SELECT COUNT(*) FROM variantDiseaseNetwork;
SELECT COUNT(*) FROM variantAttributes;
SELECT COUNT(*) FROM variantGene;


-- LIMPEZA PROFUNDA PARA ATINGIR ≤ 50 MB (dado que na após a fase acima aplicada o ficheiro ainda apresenta um tamanho de 88.2 mb
-- Apagar ligações gene-doença de fraca/média relevância (< 0.4)
DELETE FROM geneDiseaseNetwork
WHERE score < 0.4;

-- Reduzir drásticamente a variantGene
DELETE FROM variantGene WHERE geneNID % 2 = 0;
DELETE FROM variantGene WHERE variantNID % 2 = 0;

-- Compactar 
VACUUM;

-- Verificar reduções
SELECT COUNT(*) FROM geneDiseaseNetwork;
SELECT COUNT(*) FROM variantGene;


-- ELIMINAR VARIANTES DE BAIXA QUALIDADE (DSI / DPI < 0.4)
-- Apagar dependentes com variantes pouco específicas
DELETE FROM variantDiseaseNetwork
WHERE variantNID IN (
    SELECT variantNID FROM variantAttributes WHERE DSI < 0.4 OR DPI < 0.4
);

DELETE FROM variantGene
WHERE variantNID IN (
    SELECT variantNID FROM variantAttributes WHERE DSI < 0.4 OR DPI < 0.4
);

-- Apagar variantes com DSI ou DPI baixos
DELETE FROM variantAttributes
WHERE DSI < 0.4 OR DPI < 0.4;

-- Compactar 
VACUUM;

-- Verificação 
SELECT COUNT(*) FROM geneDiseaseNetwork;
SELECT COUNT(*) FROM variantDiseaseNetwork;
SELECT COUNT(*) FROM variantAttributes;
SELECT COUNT(*) FROM variantGene;

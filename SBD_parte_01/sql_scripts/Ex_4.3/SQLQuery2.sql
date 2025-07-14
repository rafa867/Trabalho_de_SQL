-- Rafael Santos - 118336

USE sbd24_118336;
GO

-- Tabela: diseaseClass
CREATE TABLE diseaseClass (
    diseaseClassNID TINYINT NOT NULL PRIMARY KEY,
    vocabulary VARCHAR(255) NOT NULL,
    diseaseClass VARCHAR(255) NOT NULL,
    diseaseClassName VARCHAR(255) NOT NULL
);

-- Tabela: diseaseAttributes
CREATE TABLE diseaseAttributes (
    diseaseNID SMALLINT NOT NULL PRIMARY KEY,
    diseaseId VARCHAR(255) NOT NULL,
    diseaseName VARCHAR(255) NOT NULL,
    type VARCHAR(255) NOT NULL
);

-- Tabela: disease2class
CREATE TABLE disease2class (
    diseaseNID SMALLINT NOT NULL,
    diseaseClassNID TINYINT NOT NULL,
    PRIMARY KEY (diseaseNID, diseaseClassNID),
    FOREIGN KEY (diseaseNID) REFERENCES diseaseAttributes(diseaseNID),
    FOREIGN KEY (diseaseClassNID) REFERENCES diseaseClass(diseaseClassNID)
);

-- Tabela: geneAttributes
CREATE TABLE geneAttributes (
    geneNID SMALLINT NOT NULL PRIMARY KEY,
    geneId INT,
    geneName VARCHAR(255),
    geneDescription VARCHAR(255),
    pLI FLOAT,
    DSI FLOAT,
    DPI FLOAT
);

-- Tabela: geneDiseaseNetwork
CREATE TABLE geneDiseaseNetwork (
    NID INT NOT NULL PRIMARY KEY,
    diseaseNID SMALLINT NOT NULL,
    geneNID SMALLINT NOT NULL,
    source VARCHAR(255),
    association VARCHAR(255),
    associationType VARCHAR(MAX),
    sentence VARCHAR(MAX),
    pmid INT,
    score FLOAT,
    EL VARCHAR(255),
    EI FLOAT,
    year INT,
    FOREIGN KEY (diseaseNID) REFERENCES diseaseAttributes(diseaseNID),
    FOREIGN KEY (geneNID) REFERENCES geneAttributes(geneNID)
);

-- Tabela: variantAttributes
CREATE TABLE variantAttributes (
    variantNID SMALLINT NOT NULL PRIMARY KEY,
    variantId VARCHAR(255) NOT NULL,
    s VARCHAR(255),
    chromosome VARCHAR(255),
    coord VARCHAR(255),
    most_severe_consequence VARCHAR(255),
    DSI FLOAT,
    DPI FLOAT
);

-- Tabela: variantDiseaseNetwork
CREATE TABLE variantDiseaseNetwork (
    NID INT NOT NULL PRIMARY KEY,
    diseaseNID SMALLINT NOT NULL,
    variantNID SMALLINT NOT NULL,
    source VARCHAR(255),
    association VARCHAR(255),
    associationType VARCHAR(MAX),
    sentence VARCHAR(MAX),
    pmid INT,
    score FLOAT,
    EI FLOAT,
    year INT,
    FOREIGN KEY (diseaseNID) REFERENCES diseaseAttributes(diseaseNID),
    FOREIGN KEY (variantNID) REFERENCES variantAttributes(variantNID)
);

-- Tabela: variantGene
CREATE TABLE variantGene (
    geneNID SMALLINT NOT NULL,
    variantNID SMALLINT NOT NULL,
    PRIMARY KEY (geneNID, variantNID),
    FOREIGN KEY (variantNID) REFERENCES variantAttributes(variantNID)
    -- Podes ativar a linha seguinte se quiseres incluir esta relação
    -- FOREIGN KEY (geneNID) REFERENCES geneAttributes(geneNID)
);

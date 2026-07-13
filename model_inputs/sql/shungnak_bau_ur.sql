PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE MetaData
(
    element TEXT,
    value   INT,
    notes   TEXT,
    PRIMARY KEY (element)
);
INSERT INTO MetaData VALUES('myopic_base_year',2025,'Base Year for Myopic Analysis');
INSERT INTO MetaData VALUES('DB_MAJOR',3,'DB major version number');
INSERT INTO MetaData VALUES('DB_MINOR',0,'DB minor version number');
CREATE TABLE MetaDataReal
(
    element TEXT,
    value   REAL,
    notes   TEXT,

    PRIMARY KEY (element)
);
INSERT INTO MetaDataReal VALUES('default_loan_rate',0.05,'Default Loan Rate if not specified in LoanRate table');
INSERT INTO MetaDataReal VALUES('global_discount_rate',0.1,'');
CREATE TABLE OutputDualVariable
(
    scenario        TEXT,
    constraint_name TEXT,
    dual            REAL,
    PRIMARY KEY (constraint_name, scenario)
);
CREATE TABLE OutputObjective
(
    scenario          TEXT,
    objective_name    TEXT,
    total_system_cost REAL
);
CREATE TABLE SectorLabel
(
    sector TEXT,
    PRIMARY KEY (sector)
);
INSERT INTO SectorLabel VALUES('supply');
INSERT INTO SectorLabel VALUES('electric');
INSERT INTO SectorLabel VALUES('transport');
INSERT INTO SectorLabel VALUES('commercial');
INSERT INTO SectorLabel VALUES('residential');
INSERT INTO SectorLabel VALUES('industrial');
CREATE TABLE CapacityCredit
(
    region  TEXT,
    period  INTEGER,
    tech    TEXT,
    vintage INTEGER,
    credit  REAL,
    notes   TEXT,
    PRIMARY KEY (region, period, tech, vintage),
    CHECK (credit >= 0 AND credit <= 1)
);
CREATE TABLE CapacityFactorProcess
(
    region  TEXT,
    season  TEXT
        REFERENCES TimeSeason (season),
    tod     TEXT
        REFERENCES TimeOfDay (tod),
    tech    TEXT
        REFERENCES Technology (tech),
    vintage INTEGER,
    factor  REAL,
    notes   TEXT,
    PRIMARY KEY (region, season, tod, tech, vintage),
    CHECK (factor >= 0 AND factor <= 1)
);
CREATE TABLE CapacityFactorTech
(
    region TEXT,
    season TEXT
        REFERENCES TimeSeason (season),
    tod    TEXT
        REFERENCES TimeOfDay (tod),
    tech   TEXT
        REFERENCES Technology (tech),
    factor REAL,
    notes  TEXT,
    PRIMARY KEY (region, season, tod, tech),
    CHECK (factor >= 0 AND factor <= 1)
);
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','0','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','1','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','2','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','3','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','4','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','5','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','6','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','7','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','8','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','9','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','10','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','11','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','12','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','13','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','14','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','15','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','16','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','17','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','18','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','19','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','20','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','21','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','22','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','23','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','0','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','1','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','2','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','3','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','4','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','5','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','6','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','7','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','8','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','9','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','10','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','11','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','12','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','13','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','14','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','15','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','16','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','17','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','18','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','19','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','20','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','21','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','22','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','23','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','0','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','1','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','2','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','3','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','4','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','5','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','6','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','7','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','8','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','9','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','10','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','11','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','12','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','13','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','14','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','15','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','16','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','17','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','18','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','19','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','20','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','21','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','22','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','23','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','0','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','1','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','2','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','3','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','4','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','5','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','6','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','7','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','8','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','9','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','10','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','11','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','12','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','13','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','14','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','15','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','16','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','17','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','18','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','19','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','20','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','21','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','22','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','23','GDSL_01',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','0','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','1','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','2','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','3','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','4','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','5','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','6','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','7','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','8','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','9','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','10','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','11','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','12','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','13','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','14','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','15','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','16','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','17','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','18','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','19','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','20','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','21','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','22','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','23','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','0','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','1','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','2','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','3','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','4','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','5','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','6','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','7','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','8','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','9','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','10','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','11','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','12','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','13','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','14','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','15','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','16','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','17','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','18','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','19','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','20','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','21','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','22','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','23','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','0','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','1','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','2','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','3','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','4','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','5','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','6','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','7','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','8','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','9','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','10','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','11','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','12','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','13','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','14','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','15','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','16','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','17','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','18','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','19','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','20','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','21','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','22','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','23','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','0','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','1','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','2','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','3','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','4','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','5','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','6','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','7','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','8','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','9','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','10','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','11','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','12','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','13','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','14','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','15','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','16','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','17','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','18','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','19','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','20','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','21','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','22','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','23','GDSL_02',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','0','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','1','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','2','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','3','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','4','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','5','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','6','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','7','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','8','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','9','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','10','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','11','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','12','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','13','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','14','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','15','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','16','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','17','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','18','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','19','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','20','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','21','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','22','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','23','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','0','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','1','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','2','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','3','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','4','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','5','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','6','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','7','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','8','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','9','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','10','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','11','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','12','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','13','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','14','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','15','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','16','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','17','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','18','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','19','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','20','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','21','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','22','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','23','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','0','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','1','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','2','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','3','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','4','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','5','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','6','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','7','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','8','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','9','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','10','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','11','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','12','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','13','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','14','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','15','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','16','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','17','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','18','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','19','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','20','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','21','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','22','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','23','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','0','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','1','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','2','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','3','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','4','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','5','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','6','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','7','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','8','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','9','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','10','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','11','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','12','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','13','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','14','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','15','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','16','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','17','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','18','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','19','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','20','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','21','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','22','GDSL_03',1.0,'Dispatchable diesel gen');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','23','GDSL_03',1.0,'Dispatchable diesel gen');
-- SOLAR (Bifacial, Fixed Open Rack, Shungnak PVWatts)
-- Source: Shungnak PVWatts Hourly PV Performance Data
-- SPRING
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','0','GSOL_01',0.0000,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','1','GSOL_01',0.0000,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','2','GSOL_01',0.0000,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','3','GSOL_01',0.0000,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','4','GSOL_01',0.0012,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','5','GSOL_01',0.0053,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','6','GSOL_01',0.0178,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','7','GSOL_01',0.0572,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','8','GSOL_01',0.1332,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','9','GSOL_01',0.2464,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','10','GSOL_01',0.3550,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','11','GSOL_01',0.4416,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','12','GSOL_01',0.4825,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','13','GSOL_01',0.5072,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','14','GSOL_01',0.5052,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','15','GSOL_01',0.4758,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','16','GSOL_01',0.4132,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','17','GSOL_01',0.3079,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','18','GSOL_01',0.1866,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','19','GSOL_01',0.0812,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','20','GSOL_01',0.0296,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','21','GSOL_01',0.0129,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','22','GSOL_01',0.0050,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','23','GSOL_01',0.0008,'Shungnak PVWatts Hourly PV Performance Data');
-- SUMMER
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','0','GSOL_01',0.0010,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','1','GSOL_01',0.0000,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','2','GSOL_01',0.0000,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','3','GSOL_01',0.0012,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','4','GSOL_01',0.0077,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','5','GSOL_01',0.0149,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','6','GSOL_01',0.0378,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','7','GSOL_01',0.0905,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','8','GSOL_01',0.1773,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','9','GSOL_01',0.2422,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','10','GSOL_01',0.3177,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','11','GSOL_01',0.3793,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','12','GSOL_01',0.4247,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','13','GSOL_01',0.4467,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','14','GSOL_01',0.4591,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','15','GSOL_01',0.4136,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','16','GSOL_01',0.3812,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','17','GSOL_01',0.3162,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','18','GSOL_01',0.2255,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','19','GSOL_01',0.1314,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','20','GSOL_01',0.0681,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','21','GSOL_01',0.0310,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','22','GSOL_01',0.0187,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','23','GSOL_01',0.0055,'Shungnak PVWatts Hourly PV Performance Data');
-- FALL
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','0','GSOL_01',0.0000,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','1','GSOL_01',0.0000,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','2','GSOL_01',0.0000,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','3','GSOL_01',0.0000,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','4','GSOL_01',0.0000,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','5','GSOL_01',0.0000,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','6','GSOL_01',0.0000,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','7','GSOL_01',0.0018,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','8','GSOL_01',0.0174,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','9','GSOL_01',0.0371,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','10','GSOL_01',0.0787,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','11','GSOL_01',0.1426,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','12','GSOL_01',0.1760,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','13','GSOL_01',0.1937,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','14','GSOL_01',0.1829,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','15','GSOL_01',0.1526,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','16','GSOL_01',0.1053,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','17','GSOL_01',0.0532,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','18','GSOL_01',0.0187,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','19','GSOL_01',0.0046,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','20','GSOL_01',0.0003,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','21','GSOL_01',0.0000,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','22','GSOL_01',0.0000,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','23','GSOL_01',0.0000,'Shungnak PVWatts Hourly PV Performance Data');
-- WINTER
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','0','GSOL_01',0.0000,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','1','GSOL_01',0.0000,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','2','GSOL_01',0.0000,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','3','GSOL_01',0.0000,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','4','GSOL_01',0.0000,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','5','GSOL_01',0.0000,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','6','GSOL_01',0.0000,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','7','GSOL_01',0.0000,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','8','GSOL_01',0.0000,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','9','GSOL_01',0.0000,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','10','GSOL_01',0.0114,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','11','GSOL_01',0.0387,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','12','GSOL_01',0.0685,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','13','GSOL_01',0.0881,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','14','GSOL_01',0.0881,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','15','GSOL_01',0.0651,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','16','GSOL_01',0.0353,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','17','GSOL_01',0.0092,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','18','GSOL_01',0.0002,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','19','GSOL_01',0.0000,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','20','GSOL_01',0.0000,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','21','GSOL_01',0.0000,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','22','GSOL_01',0.0000,'Shungnak PVWatts Hourly PV Performance Data');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','23','GSOL_01',0.0000,'Shungnak PVWatts Hourly PV Performance Data');
-- Calculated Capacity Factors from WTK-LED AK (40 m, 100 kW turbine)
-- SPRING
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','0','GWND_01',0.2764,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','1','GWND_01',0.2754,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','2','GWND_01',0.2690,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','3','GWND_01',0.2824,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','4','GWND_01',0.2963,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','5','GWND_01',0.3094,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','6','GWND_01',0.3124,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','7','GWND_01',0.2997,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','8','GWND_01',0.3121,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','9','GWND_01',0.2787,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','10','GWND_01',0.2742,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','11','GWND_01',0.2592,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','12','GWND_01',0.2438,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','13','GWND_01',0.2137,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','14','GWND_01',0.1979,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','15','GWND_01',0.2023,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','16','GWND_01',0.2186,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','17','GWND_01',0.2216,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','18','GWND_01',0.2284,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','19','GWND_01',0.2352,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','20','GWND_01',0.2492,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','21','GWND_01',0.2430,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','22','GWND_01',0.2712,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','23','GWND_01',0.2767,'Shungnak WTK-LED 40m, 100 kW turbine');
-- SUMMER
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','0','GWND_01',0.0707,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','1','GWND_01',0.0559,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','2','GWND_01',0.0512,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','3','GWND_01',0.0585,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','4','GWND_01',0.0598,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','5','GWND_01',0.0620,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','6','GWND_01',0.0556,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','7','GWND_01',0.0462,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','8','GWND_01',0.0475,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','9','GWND_01',0.0445,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','10','GWND_01',0.0480,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','11','GWND_01',0.0418,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','12','GWND_01',0.0412,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','13','GWND_01',0.0437,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','14','GWND_01',0.0474,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','15','GWND_01',0.0420,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','16','GWND_01',0.0343,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','17','GWND_01',0.0382,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','18','GWND_01',0.0507,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','19','GWND_01',0.0438,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','20','GWND_01',0.0540,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','21','GWND_01',0.0778,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','22','GWND_01',0.0759,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','23','GWND_01',0.0833,'Shungnak WTK-LED 40m, 100 kW turbine');
-- FALL
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','0','GWND_01',0.2958,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','1','GWND_01',0.3026,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','2','GWND_01',0.3047,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','3','GWND_01',0.3006,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','4','GWND_01',0.2921,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','5','GWND_01',0.3023,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','6','GWND_01',0.2969,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','7','GWND_01',0.2960,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','8','GWND_01',0.3024,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','9','GWND_01',0.2910,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','10','GWND_01',0.2871,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','11','GWND_01',0.2844,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','12','GWND_01',0.2859,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','13','GWND_01',0.2843,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','14','GWND_01',0.2882,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','15','GWND_01',0.2815,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','16','GWND_01',0.2972,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','17','GWND_01',0.2998,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','18','GWND_01',0.2853,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','19','GWND_01',0.2820,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','20','GWND_01',0.2855,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','21','GWND_01',0.2730,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','22','GWND_01',0.2907,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','23','GWND_01',0.2851,'Shungnak WTK-LED 40m, 100 kW turbine');
-- WINTER
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','0','GWND_01',0.3021,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','1','GWND_01',0.3080,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','2','GWND_01',0.2971,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','3','GWND_01',0.2817,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','4','GWND_01',0.2762,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','5','GWND_01',0.2824,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','6','GWND_01',0.2846,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','7','GWND_01',0.2879,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','8','GWND_01',0.2928,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','9','GWND_01',0.3127,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','10','GWND_01',0.2986,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','11','GWND_01',0.2982,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','12','GWND_01',0.3103,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','13','GWND_01',0.3234,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','14','GWND_01',0.3157,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','15','GWND_01',0.3224,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','16','GWND_01',0.3177,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','17','GWND_01',0.3103,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','18','GWND_01',0.3070,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','19','GWND_01',0.3112,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','20','GWND_01',0.3145,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','21','GWND_01',0.3296,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','22','GWND_01',0.3314,'Shungnak WTK-LED 40m, 100 kW turbine');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','23','GWND_01',0.3134,'Shungnak WTK-LED 40m, 100 kW turbine');
-- RUN-OF-RIVER HYDRO (USGS Dahl Creek normalized seasonal CFs)
-- Source: USGS Dahl Creek monthly mean discharge, normalized by max historical monthly mean flow
-- SPRING
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','0','GHYD_01',0.325,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','1','GHYD_01',0.325,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','2','GHYD_01',0.325,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','3','GHYD_01',0.325,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','4','GHYD_01',0.325,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','5','GHYD_01',0.325,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','6','GHYD_01',0.325,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','7','GHYD_01',0.325,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','8','GHYD_01',0.325,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','9','GHYD_01',0.325,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','10','GHYD_01',0.325,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','11','GHYD_01',0.325,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','12','GHYD_01',0.325,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','13','GHYD_01',0.325,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','14','GHYD_01',0.325,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','15','GHYD_01',0.325,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','16','GHYD_01',0.325,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','17','GHYD_01',0.325,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','18','GHYD_01',0.325,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','19','GHYD_01',0.325,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','20','GHYD_01',0.325,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','21','GHYD_01',0.325,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','22','GHYD_01',0.325,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','23','GHYD_01',0.325,'USGS Dahl Creek normalized seasonal CF');
-- SUMMER
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','0','GHYD_01',0.826,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','1','GHYD_01',0.826,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','2','GHYD_01',0.826,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','3','GHYD_01',0.826,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','4','GHYD_01',0.826,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','5','GHYD_01',0.826,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','6','GHYD_01',0.826,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','7','GHYD_01',0.826,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','8','GHYD_01',0.826,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','9','GHYD_01',0.826,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','10','GHYD_01',0.826,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','11','GHYD_01',0.826,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','12','GHYD_01',0.826,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','13','GHYD_01',0.826,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','14','GHYD_01',0.826,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','15','GHYD_01',0.826,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','16','GHYD_01',0.826,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','17','GHYD_01',0.826,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','18','GHYD_01',0.826,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','19','GHYD_01',0.826,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','20','GHYD_01',0.826,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','21','GHYD_01',0.826,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','22','GHYD_01',0.826,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','23','GHYD_01',0.826,'USGS Dahl Creek normalized seasonal CF');
-- FALL
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','0','GHYD_01',0.461,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','1','GHYD_01',0.461,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','2','GHYD_01',0.461,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','3','GHYD_01',0.461,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','4','GHYD_01',0.461,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','5','GHYD_01',0.461,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','6','GHYD_01',0.461,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','7','GHYD_01',0.461,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','8','GHYD_01',0.461,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','9','GHYD_01',0.461,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','10','GHYD_01',0.461,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','11','GHYD_01',0.461,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','12','GHYD_01',0.461,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','13','GHYD_01',0.461,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','14','GHYD_01',0.461,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','15','GHYD_01',0.461,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','16','GHYD_01',0.461,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','17','GHYD_01',0.461,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','18','GHYD_01',0.461,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','19','GHYD_01',0.461,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','20','GHYD_01',0.461,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','21','GHYD_01',0.461,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','22','GHYD_01',0.461,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','23','GHYD_01',0.461,'USGS Dahl Creek normalized seasonal CF');
-- WINTER
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','0','GHYD_01',0.077,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','1','GHYD_01',0.077,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','2','GHYD_01',0.077,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','3','GHYD_01',0.077,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','4','GHYD_01',0.077,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','5','GHYD_01',0.077,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','6','GHYD_01',0.077,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','7','GHYD_01',0.077,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','8','GHYD_01',0.077,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','9','GHYD_01',0.077,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','10','GHYD_01',0.077,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','11','GHYD_01',0.077,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','12','GHYD_01',0.077,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','13','GHYD_01',0.077,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','14','GHYD_01',0.077,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','15','GHYD_01',0.077,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','16','GHYD_01',0.077,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','17','GHYD_01',0.077,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','18','GHYD_01',0.077,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','19','GHYD_01',0.077,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','20','GHYD_01',0.077,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','21','GHYD_01',0.077,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','22','GHYD_01',0.077,'USGS Dahl Creek normalized seasonal CF');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','23','GHYD_01',0.077,'USGS Dahl Creek normalized seasonal CF');
-- Battery, fully dispatchable
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','0','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','1','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','2','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','3','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','4','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','5','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','6','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','7','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','8','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','9','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','10','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','11','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','12','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','13','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','14','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','15','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','16','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','17','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','18','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','19','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','20','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','21','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','22','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','spring','23','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','0','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','1','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','2','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','3','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','4','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','5','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','6','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','7','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','8','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','9','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','10','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','11','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','12','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','13','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','14','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','15','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','16','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','17','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','18','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','19','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','20','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','21','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','22','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','summer','23','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','0','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','1','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','2','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','3','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','4','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','5','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','6','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','7','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','8','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','9','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','10','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','11','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','12','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','13','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','14','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','15','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','16','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','17','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','18','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','19','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','20','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','21','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','22','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','fall','23','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','0','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','1','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','2','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','3','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','4','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','5','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','6','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','7','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','8','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','9','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','10','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','11','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','12','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','13','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','14','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','15','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','16','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','17','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','18','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','19','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','20','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','21','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','22','EBATT_01',1.0,'');
INSERT INTO CapacityFactorTech VALUES ('shungnak','winter','23','EBATT_01',1.0,'');
CREATE TABLE CapacityToActivity
(
    region TEXT,
    tech   TEXT
        REFERENCES Technology (tech),
    c2a    REAL,
    notes  TEXT,
    PRIMARY KEY (region, tech)
);
-- Power, Grid, and Storage Techs: 1 kW * 8760 hr/yr = 8760 kWh/yr
INSERT INTO CapacityToActivity VALUES ('shungnak','ELECT',8760,'');
INSERT INTO CapacityToActivity VALUES ('shungnak','GDSL_01',8760,'diesel gen #1');
INSERT INTO CapacityToActivity VALUES ('shungnak','GDSL_02',8760,'diesel gen #2');
INSERT INTO CapacityToActivity VALUES ('shungnak','GDSL_03',8760,'diesel gen #3');
INSERT INTO CapacityToActivity VALUES ('shungnak','GSOL_01',8760,'PV array');
INSERT INTO CapacityToActivity VALUES ('shungnak','GHYD_01',8760,'mini-hydro (hypothetical)');
INSERT INTO CapacityToActivity VALUES ('shungnak','GWND_01',8760,'wind (hypothetical)');
INSERT INTO CapacityToActivity VALUES ('shungnak','EBATT_01',8760,'battery storage power block');
INSERT INTO CapacityToActivity VALUES ('shungnak','IMP_DSL',1,'import diesel');
INSERT INTO CapacityToActivity VALUES ('shungnak','IMP_SOL',1,'import solar resource');
INSERT INTO CapacityToActivity VALUES ('shungnak','IMP_WND',1,'import wind resource');
INSERT INTO CapacityToActivity VALUES ('shungnak','IMP_HYD',1,'import water');
CREATE TABLE Commodity
(
    name        TEXT
        PRIMARY KEY,
    flag        TEXT
        REFERENCES CommodityType (label),
    description TEXT
);
INSERT INTO Commodity VALUES('ethos','s','# dummy commodity to supply inputs (makes graph easier to read)');
INSERT INTO Commodity VALUES('DSL','p','# diesel');
INSERT INTO Commodity VALUES('HYD','p','# water');
INSERT INTO Commodity VALUES('SOL','p','# solar resource');
INSERT INTO Commodity VALUES('WND','p','# wind resource');
INSERT INTO Commodity VALUES('ELC','p','# electricity');
INSERT INTO Commodity VALUES('ELECD','d','# delivered electricity demand');
INSERT INTO Commodity VALUES('co2','e','#CO2 emissions');
CREATE TABLE CommodityType
(
    label       TEXT
        PRIMARY KEY,
    description TEXT
);
INSERT INTO CommodityType VALUES('s','source commodity');
INSERT INTO CommodityType VALUES('p','physical commodity');
INSERT INTO CommodityType VALUES('e','emissions commodity');
INSERT INTO CommodityType VALUES('d','demand commodity');
CREATE TABLE CostEmission
(
    region    TEXT
        REFERENCES Region (region),
    period    INTEGER
        REFERENCES TimePeriod (period),
    emis_comm TEXT NOT NULL
        REFERENCES Commodity (name),
    cost      REAL NOT NULL,
    units     TEXT,
    notes     TEXT,
    PRIMARY KEY (region, period, emis_comm)
);
INSERT INTO CostEmission VALUES ('shungnak',2030,'co2',0,'$/ton','');
INSERT INTO CostEmission VALUES ('shungnak',2035,'co2',0,'$/ton','');
INSERT INTO CostEmission VALUES ('shungnak',2040,'co2',0,'$/ton','');
INSERT INTO CostEmission VALUES ('shungnak',2045,'co2',0,'$/ton','');
CREATE TABLE CostFixed
(
    region  TEXT    NOT NULL,
    period  INTEGER NOT NULL
        REFERENCES TimePeriod (period),
    tech    TEXT    NOT NULL
        REFERENCES Technology (tech),
    vintage INTEGER NOT NULL
        REFERENCES TimePeriod (period),
    cost    REAL,
    units   TEXT,
    notes   TEXT,
    PRIMARY KEY (region, period, tech, vintage)
);
-- TECHNOLOGY: GDSL (Diesel)
-- MIT CEEPR Alaska Study (2021) lists remote diesel Fixed O&M at ~$82/kWyr. 
-- TECHNOLOGY: GDSL_01 (Diesel Gen 1)
INSERT INTO CostFixed VALUES('shungnak',2030,'GDSL_01',2025,82.0,'$/kWyr','');
INSERT INTO CostFixed VALUES('shungnak',2030,'GDSL_01',2030,82.0,'$/kWyr','');

INSERT INTO CostFixed VALUES('shungnak',2035,'GDSL_01',2025,82.0,'$/kWyr','');
INSERT INTO CostFixed VALUES('shungnak',2035,'GDSL_01',2030,82.0,'$/kWyr','');
INSERT INTO CostFixed VALUES('shungnak',2035,'GDSL_01',2035,82.0,'$/kWyr','');

INSERT INTO CostFixed VALUES('shungnak',2040,'GDSL_01',2025,82.0,'$/kWyr','');
INSERT INTO CostFixed VALUES('shungnak',2040,'GDSL_01',2030,82.0,'$/kWyr','');
INSERT INTO CostFixed VALUES('shungnak',2040,'GDSL_01',2035,82.0,'$/kWyr','');
INSERT INTO CostFixed VALUES('shungnak',2040,'GDSL_01',2040,82.0,'$/kWyr','');

INSERT INTO CostFixed VALUES('shungnak',2045,'GDSL_01',2030,82.0,'$/kWyr','');
INSERT INTO CostFixed VALUES('shungnak',2045,'GDSL_01',2035,82.0,'$/kWyr','');
INSERT INTO CostFixed VALUES('shungnak',2045,'GDSL_01',2040,82.0,'$/kWyr','');
INSERT INTO CostFixed VALUES('shungnak',2045,'GDSL_01',2045,82.0,'$/kWyr','');
-- TECHNOLOGY: GDSL_02 (Diesel Gen 2)
INSERT INTO CostFixed VALUES('shungnak',2030,'GDSL_02',2025,82.0,'$/kWyr','');
INSERT INTO CostFixed VALUES('shungnak',2030,'GDSL_02',2030,82.0,'$/kWyr','');

INSERT INTO CostFixed VALUES('shungnak',2035,'GDSL_02',2025,82.0,'$/kWyr','');
INSERT INTO CostFixed VALUES('shungnak',2035,'GDSL_02',2030,82.0,'$/kWyr','');
INSERT INTO CostFixed VALUES('shungnak',2035,'GDSL_02',2035,82.0,'$/kWyr','');

INSERT INTO CostFixed VALUES('shungnak',2040,'GDSL_02',2025,82.0,'$/kWyr','');
INSERT INTO CostFixed VALUES('shungnak',2040,'GDSL_02',2030,82.0,'$/kWyr','');
INSERT INTO CostFixed VALUES('shungnak',2040,'GDSL_02',2035,82.0,'$/kWyr','');
INSERT INTO CostFixed VALUES('shungnak',2040,'GDSL_02',2040,82.0,'$/kWyr','');

INSERT INTO CostFixed VALUES('shungnak',2045,'GDSL_02',2030,82.0,'$/kWyr','');
INSERT INTO CostFixed VALUES('shungnak',2045,'GDSL_02',2035,82.0,'$/kWyr','');
INSERT INTO CostFixed VALUES('shungnak',2045,'GDSL_02',2040,82.0,'$/kWyr','');
INSERT INTO CostFixed VALUES('shungnak',2045,'GDSL_02',2045,82.0,'$/kWyr','');
-- TECHNOLOGY: GDSL_03 (Diesel Gen 3)
INSERT INTO CostFixed VALUES('shungnak',2030,'GDSL_03',2025,82.0,'$/kWyr','');
INSERT INTO CostFixed VALUES('shungnak',2030,'GDSL_03',2030,82.0,'$/kWyr','');

INSERT INTO CostFixed VALUES('shungnak',2035,'GDSL_03',2025,82.0,'$/kWyr','');
INSERT INTO CostFixed VALUES('shungnak',2035,'GDSL_03',2030,82.0,'$/kWyr','');
INSERT INTO CostFixed VALUES('shungnak',2035,'GDSL_03',2035,82.0,'$/kWyr','');

INSERT INTO CostFixed VALUES('shungnak',2040,'GDSL_03',2025,82.0,'$/kWyr','');
INSERT INTO CostFixed VALUES('shungnak',2040,'GDSL_03',2030,82.0,'$/kWyr','');
INSERT INTO CostFixed VALUES('shungnak',2040,'GDSL_03',2035,82.0,'$/kWyr','');
INSERT INTO CostFixed VALUES('shungnak',2040,'GDSL_03',2040,82.0,'$/kWyr','');

INSERT INTO CostFixed VALUES('shungnak',2045,'GDSL_03',2030,82.0,'$/kWyr','');
INSERT INTO CostFixed VALUES('shungnak',2045,'GDSL_03',2035,82.0,'$/kWyr','');
INSERT INTO CostFixed VALUES('shungnak',2045,'GDSL_03',2040,82.0,'$/kWyr','');
INSERT INTO CostFixed VALUES('shungnak',2045,'GDSL_03',2045,82.0,'$/kWyr','');
-- TECHNOLOGY: GSOL (Solar PV)
-- ATB Utility PV Class 5 with Arctic uplift.
INSERT INTO CostFixed VALUES('shungnak',2030,'GSOL_01',2025,46.2,'$/kWyr','ATB Utility PV Class 5 with Arctic uplift.');
INSERT INTO CostFixed VALUES('shungnak',2030,'GSOL_01',2030,39.6,'$/kWyr','ATB Utility PV Class 5 with Arctic uplift.');

INSERT INTO CostFixed VALUES('shungnak',2035,'GSOL_01',2025,46.2,'$/kWyr','ATB Utility PV Class 5 with Arctic uplift.');
INSERT INTO CostFixed VALUES('shungnak',2035,'GSOL_01',2030,39.6,'$/kWyr','ATB Utility PV Class 5 with Arctic uplift.');
INSERT INTO CostFixed VALUES('shungnak',2035,'GSOL_01',2035,33.0,'$/kWyr','ATB Utility PV Class 5 with Arctic uplift.');

INSERT INTO CostFixed VALUES('shungnak',2040,'GSOL_01',2025,46.2,'$/kWyr','ATB Utility PV Class 5 with Arctic uplift.');
INSERT INTO CostFixed VALUES('shungnak',2040,'GSOL_01',2030,39.6,'$/kWyr','ATB Utility PV Class 5 with Arctic uplift.');
INSERT INTO CostFixed VALUES('shungnak',2040,'GSOL_01',2035,33.0,'$/kWyr','ATB Utility PV Class 5 with Arctic uplift.');
INSERT INTO CostFixed VALUES('shungnak',2040,'GSOL_01',2040,31.4,'$/kWyr','ATB Utility PV Class 5 with Arctic uplift.');

INSERT INTO CostFixed VALUES('shungnak',2045,'GSOL_01',2025,46.2,'$/kWyr','ATB Utility PV Class 5 with Arctic uplift.');
INSERT INTO CostFixed VALUES('shungnak',2045,'GSOL_01',2030,39.6,'$/kWyr','ATB Utility PV Class 5 with Arctic uplift.');
INSERT INTO CostFixed VALUES('shungnak',2045,'GSOL_01',2035,33.0,'$/kWyr','ATB Utility PV Class 5 with Arctic uplift.');
INSERT INTO CostFixed VALUES('shungnak',2045,'GSOL_01',2040,31.4,'$/kWyr','ATB Utility PV Class 5 with Arctic uplift.');
INSERT INTO CostFixed VALUES('shungnak',2045,'GSOL_01',2045,29.7,'$/kWyr','ATB Utility PV Class 5 with Arctic uplift.');
-- TECHNOLOGY: GWND (Wind)
-- ATB Commercial DW - Class 1 with Arctic uplift. 
INSERT INTO CostFixed VALUES('shungnak',2030,'GWND_01',2025,69.81,'$/kWyr','ATB Commercial DW - Class 1 with Arctic uplift.');
INSERT INTO CostFixed VALUES('shungnak',2030,'GWND_01',2030,68.4,'$/kWyr','ATB Commercial DW - Class 1 with Arctic uplift.');

INSERT INTO CostFixed VALUES('shungnak',2035,'GWND_01',2025,69.81,'$/kWyr','ATB Commercial DW - Class 1 with Arctic uplift.');
INSERT INTO CostFixed VALUES('shungnak',2035,'GWND_01',2030,68.4,'$/kWyr','ATB Commercial DW - Class 1 with Arctic uplift.');
INSERT INTO CostFixed VALUES('shungnak',2035,'GWND_01',2035,67.3,'$/kWyr','ATB Commercial DW - Class 1 with Arctic uplift.');

INSERT INTO CostFixed VALUES('shungnak',2040,'GWND_01',2025,69.81,'$/kWyr','ATB Commercial DW - Class 1 with Arctic uplift.');
INSERT INTO CostFixed VALUES('shungnak',2040,'GWND_01',2030,68.4,'$/kWyr','ATB Commercial DW - Class 1 with Arctic uplift.');
INSERT INTO CostFixed VALUES('shungnak',2040,'GWND_01',2035,67.3,'$/kWyr','ATB Commercial DW - Class 1 with Arctic uplift.');
INSERT INTO CostFixed VALUES('shungnak',2040,'GWND_01',2040,66.3,'$/kWyr','ATB Commercial DW - Class 1 with Arctic uplift.');

INSERT INTO CostFixed VALUES('shungnak',2045,'GWND_01',2025,69.81,'$/kWyr','ATB Commercial DW - Class 1 with Arctic uplift.');
INSERT INTO CostFixed VALUES('shungnak',2045,'GWND_01',2030,68.4,'$/kWyr','ATB Commercial DW - Class 1 with Arctic uplift.');
INSERT INTO CostFixed VALUES('shungnak',2045,'GWND_01',2035,67.3,'$/kWyr','ATB Commercial DW - Class 1 with Arctic uplift.');
INSERT INTO CostFixed VALUES('shungnak',2045,'GWND_01',2040,66.3,'$/kWyr','ATB Commercial DW - Class 1 with Arctic uplift.');
INSERT INTO CostFixed VALUES('shungnak',2045,'GWND_01',2045,65.2,'$/kWyr','ATB Commercial DW - Class 1 with Arctic uplift.');
-- TECHNOLOGY: GHYD (Hydro)
-- ATB Hydropower NSD 2 with Arctic uplift.
INSERT INTO CostFixed VALUES('shungnak',2030,'GHYD_01',2025,75.0,'$/kWyr','ATB Hydropower NSD 2 with Arctic uplift.');
INSERT INTO CostFixed VALUES('shungnak',2030,'GHYD_01',2030,75.0,'$/kWyr','ATB Hydropower NSD 2 with Arctic uplift.');

INSERT INTO CostFixed VALUES('shungnak',2035,'GHYD_01',2025,75.0,'$/kWyr','ATB Hydropower NSD 2 with Arctic uplift.');
INSERT INTO CostFixed VALUES('shungnak',2035,'GHYD_01',2030,75.0,'$/kWyr','ATB Hydropower NSD 2 with Arctic uplift.');
INSERT INTO CostFixed VALUES('shungnak',2035,'GHYD_01',2035,75.0,'$/kWyr','ATB Hydropower NSD 2 with Arctic uplift.');

INSERT INTO CostFixed VALUES('shungnak',2040,'GHYD_01',2025,75.0,'$/kWyr','ATB Hydropower NSD 2 with Arctic uplift.');
INSERT INTO CostFixed VALUES('shungnak',2040,'GHYD_01',2030,75.0,'$/kWyr','ATB Hydropower NSD 2 with Arctic uplift.');
INSERT INTO CostFixed VALUES('shungnak',2040,'GHYD_01',2035,75.0,'$/kWyr','ATB Hydropower NSD 2 with Arctic uplift.');
INSERT INTO CostFixed VALUES('shungnak',2040,'GHYD_01',2040,75.0,'$/kWyr','ATB Hydropower NSD 2 with Arctic uplift.');

INSERT INTO CostFixed VALUES('shungnak',2045,'GHYD_01',2025,75.0,'$/kWyr','ATB Hydropower NSD 2 with Arctic uplift.');
INSERT INTO CostFixed VALUES('shungnak',2045,'GHYD_01',2030,75.0,'$/kWyr','ATB Hydropower NSD 2 with Arctic uplift.');
INSERT INTO CostFixed VALUES('shungnak',2045,'GHYD_01',2035,75.0,'$/kWyr','ATB Hydropower NSD 2 with Arctic uplift.');
INSERT INTO CostFixed VALUES('shungnak',2045,'GHYD_01',2040,75.0,'$/kWyr','ATB Hydropower NSD 2 with Arctic uplift.');
INSERT INTO CostFixed VALUES('shungnak',2045,'GHYD_01',2045,75.0,'$/kWyr','ATB Hydropower NSD 2 with Arctic uplift.');
-- TECHNOLOGY: EBATT (Battery)
-- ATB Utility-Scale Battery Storage - 4Hr 
INSERT INTO CostFixed VALUES('shungnak',2030,'EBATT_01',2025,46.5,'$/kWyr','ATB Utility-Scale Battery Storage - 4Hr');
INSERT INTO CostFixed VALUES('shungnak',2030,'EBATT_01',2030,39.0,'$/kWyr','ATB Utility-Scale Battery Storage - 4Hr');

INSERT INTO CostFixed VALUES('shungnak',2035,'EBATT_01',2025,46.5,'$/kWyr','ATB Utility-Scale Battery Storage - 4Hr');
INSERT INTO CostFixed VALUES('shungnak',2035,'EBATT_01',2030,39.0,'$/kWyr','ATB Utility-Scale Battery Storage - 4Hr');
INSERT INTO CostFixed VALUES('shungnak',2035,'EBATT_01',2035,36.0,'$/kWyr','ATB Utility-Scale Battery Storage - 4Hr');

INSERT INTO CostFixed VALUES('shungnak',2040,'EBATT_01',2030,39.0,'$/kWyr','ATB Utility-Scale Battery Storage - 4Hr');
INSERT INTO CostFixed VALUES('shungnak',2040,'EBATT_01',2035,36.0,'$/kWyr','ATB Utility-Scale Battery Storage - 4Hr');
INSERT INTO CostFixed VALUES('shungnak',2040,'EBATT_01',2040,33.0,'$/kWyr','ATB Utility-Scale Battery Storage - 4Hr');

INSERT INTO CostFixed VALUES('shungnak',2045,'EBATT_01',2035,36.0,'$/kWyr','ATB Utility-Scale Battery Storage - 4Hr');
INSERT INTO CostFixed VALUES('shungnak',2045,'EBATT_01',2040,33.0,'$/kWyr','ATB Utility-Scale Battery Storage - 4Hr');
INSERT INTO CostFixed VALUES('shungnak',2045,'EBATT_01',2045,30.0,'$/kWyr','ATB Utility-Scale Battery Storage - 4Hr');
-- TECHNOLOGY: ELECT (Grid)
-- Cost: 0.0
INSERT INTO CostFixed VALUES('shungnak',2030,'ELECT',2025,0.0,'$/kWyr','');
INSERT INTO CostFixed VALUES('shungnak',2030,'ELECT',2030,0.0,'$/kWyr','');

INSERT INTO CostFixed VALUES('shungnak',2035,'ELECT',2025,0.0,'$/kWyr','');
INSERT INTO CostFixed VALUES('shungnak',2035,'ELECT',2030,0.0,'$/kWyr','');
INSERT INTO CostFixed VALUES('shungnak',2035,'ELECT',2035,0.0,'$/kWyr','');

INSERT INTO CostFixed VALUES('shungnak',2040,'ELECT',2025,0.0,'$/kWyr','');
INSERT INTO CostFixed VALUES('shungnak',2040,'ELECT',2030,0.0,'$/kWyr','');
INSERT INTO CostFixed VALUES('shungnak',2040,'ELECT',2035,0.0,'$/kWyr','');
INSERT INTO CostFixed VALUES('shungnak',2040,'ELECT',2040,0.0,'$/kWyr','');

INSERT INTO CostFixed VALUES('shungnak',2045,'ELECT',2025,0.0,'$/kWyr','');
INSERT INTO CostFixed VALUES('shungnak',2045,'ELECT',2030,0.0,'$/kWyr','');
INSERT INTO CostFixed VALUES('shungnak',2045,'ELECT',2035,0.0,'$/kWyr','');
INSERT INTO CostFixed VALUES('shungnak',2045,'ELECT',2040,0.0,'$/kWyr','');
INSERT INTO CostFixed VALUES('shungnak',2045,'ELECT',2045,0.0,'$/kWyr','');
CREATE TABLE CostInvest
(
    region  TEXT,
    tech    TEXT
        REFERENCES Technology (tech),
    vintage INTEGER
        REFERENCES TimePeriod (period),
    cost    REAL,
    units   TEXT,
    notes   TEXT,
    PRIMARY KEY (region, tech, vintage)
);
-- DIESEL GENERATION (GDSL)
-- Source: Alaska Energy Authority (AEA) rural installed cost benchmark adjusted for inflation
INSERT INTO CostInvest VALUES ('shungnak','GDSL_01',2030,4100,'$/kW','AEA');
INSERT INTO CostInvest VALUES ('shungnak','GDSL_01',2035,4100,'$/kW','AEA');
INSERT INTO CostInvest VALUES ('shungnak','GDSL_01',2040,4100,'$/kW','AEA');
INSERT INTO CostInvest VALUES ('shungnak','GDSL_01',2045,4100,'$/kW','AEA');

INSERT INTO CostInvest VALUES ('shungnak','GDSL_02',2030,4100,'$/kW','AEA');
INSERT INTO CostInvest VALUES ('shungnak','GDSL_02',2035,4100,'$/kW','AEA');
INSERT INTO CostInvest VALUES ('shungnak','GDSL_02',2040,4100,'$/kW','AEA');
INSERT INTO CostInvest VALUES ('shungnak','GDSL_02',2045,4100,'$/kW','AEA');

INSERT INTO CostInvest VALUES ('shungnak','GDSL_03',2030,4100,'$/kW','AEA');
INSERT INTO CostInvest VALUES ('shungnak','GDSL_03',2035,4100,'$/kW','AEA');
INSERT INTO CostInvest VALUES ('shungnak','GDSL_03',2040,4100,'$/kW','AEA');
INSERT INTO CostInvest VALUES ('shungnak','GDSL_03',2045,4100,'$/kW','AEA');
-- SOLAR PV (GSOL)
-- Source: NREL ATB Utility PV Class 5
INSERT INTO CostInvest VALUES ('shungnak','GSOL_01',2030,2864.4,'$/kW','NREL ATB Utility PV Class 5');
INSERT INTO CostInvest VALUES ('shungnak','GSOL_01',2035,2089.1,'$/kW','NREL ATB Utility PV Class 5');
INSERT INTO CostInvest VALUES ('shungnak','GSOL_01',2040,1868.9,'$/kW','NREL ATB Utility PV Class 5');
INSERT INTO CostInvest VALUES ('shungnak','GSOL_01',2045,1658.2,'$/kW','NREL ATB Utility PV Class 5');
-- WIND (GWND)
-- Source: NREL ATB Commercial DW Class 1
INSERT INTO CostInvest VALUES ('shungnak','GWND_01',2030,5912.8,'$/kW','NREL ATB Commercial DW Class 1');
INSERT INTO CostInvest VALUES ('shungnak','GWND_01',2035,4863.4,'$/kW','NREL ATB Commercial DW Class 1');
INSERT INTO CostInvest VALUES ('shungnak','GWND_01',2040,3872.3,'$/kW','NREL ATB Commercial DW Class 1');
INSERT INTO CostInvest VALUES ('shungnak','GWND_01',2045,3381.2,'$/kW','NREL ATB Commercial DW Class 1');
-- HYDRO (GHYD)
-- Source: NREL ATB Hydropower NSD 2
INSERT INTO CostInvest VALUES ('shungnak','GHYD_01',2030,12210.1,'$/kW','NREL ATB Hydropower NSD 2');
INSERT INTO CostInvest VALUES ('shungnak','GHYD_01',2035,11938.8,'$/kW','NREL ATB Hydropower NSD 2');
INSERT INTO CostInvest VALUES ('shungnak','GHYD_01',2040,11667.4,'$/kW','NREL ATB Hydropower NSD 2');
INSERT INTO CostInvest VALUES ('shungnak','GHYD_01',2045,11396.1,'$/kW','NREL ATB Hydropower NSD 2');
-- BATTERY (EBATT) - 4 Hour Duration
-- Source: NREL ATB Utility-Scale Battery Storage - 4Hr
INSERT INTO CostInvest VALUES ('shungnak','EBATT_01',2030,2322.1,'$/kW','NREL ATB Utility-Scale Battery Storage - 4Hr');
INSERT INTO CostInvest VALUES ('shungnak','EBATT_01',2035,2066.0,'$/kW','NREL ATB Utility-Scale Battery Storage - 4Hr');
INSERT INTO CostInvest VALUES ('shungnak','EBATT_01',2040,1823.8,'$/kW','NREL ATB Utility-Scale Battery Storage - 4Hr');
INSERT INTO CostInvest VALUES ('shungnak','EBATT_01',2045,1595.5,'$/kW','NREL ATB Utility-Scale Battery Storage - 4Hr');
-- ELECT (Grid Bookkeeping)
INSERT INTO CostInvest VALUES ('shungnak','ELECT',2025,0.0,'$/kW','bookkeeping');
INSERT INTO CostInvest VALUES ('shungnak','ELECT',2030,0.0,'$/kW','bookkeeping');
INSERT INTO CostInvest VALUES ('shungnak','ELECT',2035,0.0,'$/kW','bookkeeping');
INSERT INTO CostInvest VALUES ('shungnak','ELECT',2040,0.0,'$/kW','bookkeeping');
INSERT INTO CostInvest VALUES ('shungnak','ELECT',2045,0.0,'$/kW','bookkeeping');
CREATE TABLE CostVariable
(
    region  TEXT    NOT NULL,
    period  INTEGER NOT NULL
        REFERENCES TimePeriod (period),
    tech    TEXT    NOT NULL
        REFERENCES Technology (tech),
    vintage INTEGER NOT NULL
        REFERENCES TimePeriod (period),
    cost    REAL,
    units   TEXT,
    notes   TEXT,
    PRIMARY KEY (region, period, tech, vintage)
);
-- 1. DIESEL IMPORT (IMP_DSL)
-- Source: (Shungnak Profile)
-- Base Calculation: $8.50/gal / ~13.5 kWh/gal = $0.63/kWh (Real Unsubsidized Cost)
-- VINTAGE 2025 (Base Year)
INSERT INTO CostVariable VALUES('shungnak',2030,'IMP_DSL',2025,0.6300,'$/kWh','Ref: Shungnak 2021 Data ($8.50/gal)');
INSERT INTO CostVariable VALUES('shungnak',2035,'IMP_DSL',2025,0.6426,'$/kWh','Escalated 2%');
INSERT INTO CostVariable VALUES('shungnak',2040,'IMP_DSL',2025,0.6554,'$/kWh','Escalated 2%');
INSERT INTO CostVariable VALUES('shungnak',2045,'IMP_DSL',2025,0.6685,'$/kWh','Escalated 2%');
-- VINTAGE 2030
INSERT INTO CostVariable VALUES('shungnak',2030,'IMP_DSL',2030,0.6300,'$/kWh','Ref: Shungnak 2021 Data ($8.50/gal)');
INSERT INTO CostVariable VALUES('shungnak',2035,'IMP_DSL',2030,0.6426,'$/kWh','Escalated 2%');
INSERT INTO CostVariable VALUES('shungnak',2040,'IMP_DSL',2030,0.6554,'$/kWh','Escalated 2%');
INSERT INTO CostVariable VALUES('shungnak',2045,'IMP_DSL',2030,0.6685,'$/kWh','Escalated 2%');
-- VINTAGE 2035
INSERT INTO CostVariable VALUES('shungnak',2035,'IMP_DSL',2035,0.6426,'$/kWh','Escalated 2%');
INSERT INTO CostVariable VALUES('shungnak',2040,'IMP_DSL',2035,0.6554,'$/kWh','Escalated 2%');
INSERT INTO CostVariable VALUES('shungnak',2045,'IMP_DSL',2035,0.6685,'$/kWh','Escalated 2%');
-- VINTAGE 2040
INSERT INTO CostVariable VALUES('shungnak',2040,'IMP_DSL',2040,0.6554,'$/kWh','Escalated 2%');
INSERT INTO CostVariable VALUES('shungnak',2045,'IMP_DSL',2040,0.6685,'$/kWh','Escalated 2%');
-- VINTAGE 2045
INSERT INTO CostVariable VALUES('shungnak',2045,'IMP_DSL',2045,0.6685,'$/kWh','Escalated 2%');
-- 2. RENEWABLES (Zero Cost)
-- HYDRO
INSERT INTO CostVariable VALUES ('shungnak',2030,'IMP_HYD',2025,0.00,'$/kWh','');
INSERT INTO CostVariable VALUES ('shungnak',2030,'IMP_HYD',2030,0.00,'$/kWh','');
INSERT INTO CostVariable VALUES ('shungnak',2035,'IMP_HYD',2025,0.00,'$/kWh','');
INSERT INTO CostVariable VALUES ('shungnak',2035,'IMP_HYD',2030,0.00,'$/kWh','');
INSERT INTO CostVariable VALUES ('shungnak',2035,'IMP_HYD',2035,0.00,'$/kWh','');
INSERT INTO CostVariable VALUES ('shungnak',2040,'IMP_HYD',2025,0.00,'$/kWh','');
INSERT INTO CostVariable VALUES ('shungnak',2040,'IMP_HYD',2030,0.00,'$/kWh','');
INSERT INTO CostVariable VALUES ('shungnak',2040,'IMP_HYD',2035,0.00,'$/kWh','');
INSERT INTO CostVariable VALUES ('shungnak',2040,'IMP_HYD',2040,0.00,'$/kWh','');
INSERT INTO CostVariable VALUES ('shungnak',2045,'IMP_HYD',2025,0.00,'$/kWh','');
INSERT INTO CostVariable VALUES ('shungnak',2045,'IMP_HYD',2030,0.00,'$/kWh','');
INSERT INTO CostVariable VALUES ('shungnak',2045,'IMP_HYD',2035,0.00,'$/kWh','');
INSERT INTO CostVariable VALUES ('shungnak',2045,'IMP_HYD',2040,0.00,'$/kWh','');
INSERT INTO CostVariable VALUES ('shungnak',2045,'IMP_HYD',2045,0.00,'$/kWh','');
-- SOLAR
INSERT INTO CostVariable VALUES ('shungnak',2030,'IMP_SOL',2025,0.00,'$/kWh','');
INSERT INTO CostVariable VALUES ('shungnak',2030,'IMP_SOL',2030,0.00,'$/kWh','');
INSERT INTO CostVariable VALUES ('shungnak',2035,'IMP_SOL',2025,0.00,'$/kWh','');
INSERT INTO CostVariable VALUES ('shungnak',2035,'IMP_SOL',2030,0.00,'$/kWh','');
INSERT INTO CostVariable VALUES ('shungnak',2035,'IMP_SOL',2035,0.00,'$/kWh','');
INSERT INTO CostVariable VALUES ('shungnak',2040,'IMP_SOL',2025,0.00,'$/kWh','');
INSERT INTO CostVariable VALUES ('shungnak',2040,'IMP_SOL',2030,0.00,'$/kWh','');
INSERT INTO CostVariable VALUES ('shungnak',2040,'IMP_SOL',2035,0.00,'$/kWh','');
INSERT INTO CostVariable VALUES ('shungnak',2040,'IMP_SOL',2040,0.00,'$/kWh','');
INSERT INTO CostVariable VALUES ('shungnak',2045,'IMP_SOL',2025,0.00,'$/kWh','');
INSERT INTO CostVariable VALUES ('shungnak',2045,'IMP_SOL',2030,0.00,'$/kWh','');
INSERT INTO CostVariable VALUES ('shungnak',2045,'IMP_SOL',2035,0.00,'$/kWh','');
INSERT INTO CostVariable VALUES ('shungnak',2045,'IMP_SOL',2040,0.00,'$/kWh','');
INSERT INTO CostVariable VALUES ('shungnak',2045,'IMP_SOL',2045,0.00,'$/kWh','');
-- WIND
INSERT INTO CostVariable VALUES ('shungnak',2030,'IMP_WND',2025,0.00,'$/kWh','');
INSERT INTO CostVariable VALUES ('shungnak',2030,'IMP_WND',2030,0.00,'$/kWh','');
INSERT INTO CostVariable VALUES ('shungnak',2035,'IMP_WND',2025,0.00,'$/kWh','');
INSERT INTO CostVariable VALUES ('shungnak',2035,'IMP_WND',2030,0.00,'$/kWh','');
INSERT INTO CostVariable VALUES ('shungnak',2035,'IMP_WND',2035,0.00,'$/kWh','');
INSERT INTO CostVariable VALUES ('shungnak',2040,'IMP_WND',2025,0.00,'$/kWh','');
INSERT INTO CostVariable VALUES ('shungnak',2040,'IMP_WND',2030,0.00,'$/kWh','');
INSERT INTO CostVariable VALUES ('shungnak',2040,'IMP_WND',2035,0.00,'$/kWh','');
INSERT INTO CostVariable VALUES ('shungnak',2040,'IMP_WND',2040,0.00,'$/kWh','');
INSERT INTO CostVariable VALUES ('shungnak',2045,'IMP_WND',2025,0.00,'$/kWh','');
INSERT INTO CostVariable VALUES ('shungnak',2045,'IMP_WND',2030,0.00,'$/kWh','');
INSERT INTO CostVariable VALUES ('shungnak',2045,'IMP_WND',2035,0.00,'$/kWh','');
INSERT INTO CostVariable VALUES ('shungnak',2045,'IMP_WND',2040,0.00,'$/kWh','');
INSERT INTO CostVariable VALUES ('shungnak',2045,'IMP_WND',2045,0.00,'$/kWh','');
CREATE TABLE Demand
(
    region    TEXT,
    period    INTEGER
        REFERENCES TimePeriod (period),
    commodity TEXT
        REFERENCES Commodity (name),
    demand    REAL,
    units     TEXT,
    notes     TEXT,
    PRIMARY KEY (region, period, commodity)
);
INSERT INTO Demand VALUES ('shungnak',2030,'ELECD',1741984.94,'kWh per year','ANTHC and AVEC data, 1% increase per year');
INSERT INTO Demand VALUES ('shungnak',2035,'ELECD',1830843.67,'kWh per year','ANTHC and AVEC data, 1% increase per year');
INSERT INTO Demand VALUES ('shungnak',2040,'ELECD',1924235.10,'kWh per year','ANTHC and AVEC data, 1% increase per year');
INSERT INTO Demand VALUES ('shungnak',2045,'ELECD',2022390.43,'kWh per year','ANTHC and AVEC data, 1% increase per year');
CREATE TABLE DemandSpecificDistribution
(
    region      TEXT,
    season      TEXT
        REFERENCES TimeSeason (season),
    tod         TEXT
        REFERENCES TimeOfDay (tod),
    demand_name TEXT
        REFERENCES Commodity (name),
    dds         REAL,
    dds_notes   TEXT,
    PRIMARY KEY (region, season, tod, demand_name),
    CHECK (dds >= 0 AND dds <= 1)
);
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','winter','0','ELECD',0.0114,'Rep day 2023_01_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','winter','1','ELECD',0.0113,'Rep day 2023_01_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','winter','2','ELECD',0.0114,'Rep day 2023_01_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','winter','3','ELECD',0.0108,'Rep day 2023_01_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','winter','4','ELECD',0.0104,'Rep day 2023_01_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','winter','5','ELECD',0.0105,'Rep day 2023_01_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','winter','6','ELECD',0.0107,'Rep day 2023_01_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','winter','7','ELECD',0.0105,'Rep day 2023_01_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','winter','8','ELECD',0.0115,'Rep day 2023_01_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','winter','9','ELECD',0.0136,'Rep day 2023_01_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','winter','10','ELECD',0.0145,'Rep day 2023_01_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','winter','11','ELECD',0.0150,'Rep day 2023_01_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','winter','12','ELECD',0.0148,'Rep day 2023_01_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','winter','13','ELECD',0.0144,'Rep day 2023_01_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','winter','14','ELECD',0.0143,'Rep day 2023_01_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','winter','15','ELECD',0.0136,'Rep day 2023_01_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','winter','16','ELECD',0.0143,'Rep day 2023_01_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','winter','17','ELECD',0.0154,'Rep day 2023_01_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','winter','18','ELECD',0.0155,'Rep day 2023_01_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','winter','19','ELECD',0.0135,'Rep day 2023_01_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','winter','20','ELECD',0.0136,'Rep day 2023_01_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','winter','21','ELECD',0.0129,'Rep day 2023_01_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','winter','22','ELECD',0.0124,'Rep day 2023_01_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','winter','23','ELECD',0.0112,'Rep day 2023_01_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','spring','0','ELECD',0.0091,'Rep day 2023_03_24');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','spring','1','ELECD',0.0091,'Rep day 2023_03_24');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','spring','2','ELECD',0.0087,'Rep day 2023_03_24');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','spring','3','ELECD',0.0087,'Rep day 2023_03_24');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','spring','4','ELECD',0.0088,'Rep day 2023_03_24');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','spring','5','ELECD',0.0090,'Rep day 2023_03_24');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','spring','6','ELECD',0.0092,'Rep day 2023_03_24');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','spring','7','ELECD',0.0101,'Rep day 2023_03_24');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','spring','8','ELECD',0.0120,'Rep day 2023_03_24');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','spring','9','ELECD',0.0123,'Rep day 2023_03_24');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','spring','10','ELECD',0.0133,'Rep day 2023_03_24');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','spring','11','ELECD',0.0136,'Rep day 2023_03_24');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','spring','12','ELECD',0.0129,'Rep day 2023_03_24');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','spring','13','ELECD',0.0124,'Rep day 2023_03_24');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','spring','14','ELECD',0.0126,'Rep day 2023_03_24');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','spring','15','ELECD',0.0125,'Rep day 2023_03_24');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','spring','16','ELECD',0.0131,'Rep day 2023_03_24');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','spring','17','ELECD',0.0131,'Rep day 2023_03_24');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','spring','18','ELECD',0.0124,'Rep day 2023_03_24');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','spring','19','ELECD',0.0120,'Rep day 2023_03_24');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','spring','20','ELECD',0.0124,'Rep day 2023_03_24');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','spring','21','ELECD',0.0117,'Rep day 2023_03_24');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','spring','22','ELECD',0.0114,'Rep day 2023_03_24');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','spring','23','ELECD',0.0106,'Rep day 2023_03_24');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','summer','0','ELECD',0.0068,'Rep day 2023_07_20');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','summer','1','ELECD',0.0062,'Rep day 2023_07_20');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','summer','2','ELECD',0.0061,'Rep day 2023_07_20');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','summer','3','ELECD',0.0057,'Rep day 2023_07_20');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','summer','4','ELECD',0.0056,'Rep day 2023_07_20');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','summer','5','ELECD',0.0056,'Rep day 2023_07_20');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','summer','6','ELECD',0.0060,'Rep day 2023_07_20');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','summer','7','ELECD',0.0061,'Rep day 2023_07_20');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','summer','8','ELECD',0.0063,'Rep day 2023_07_20');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','summer','9','ELECD',0.0065,'Rep day 2023_07_20');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','summer','10','ELECD',0.0076,'Rep day 2023_07_20');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','summer','11','ELECD',0.0078,'Rep day 2023_07_20');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','summer','12','ELECD',0.0076,'Rep day 2023_07_20');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','summer','13','ELECD',0.0075,'Rep day 2023_07_20');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','summer','14','ELECD',0.0074,'Rep day 2023_07_20');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','summer','15','ELECD',0.0077,'Rep day 2023_07_20');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','summer','16','ELECD',0.0086,'Rep day 2023_07_20');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','summer','17','ELECD',0.0088,'Rep day 2023_07_20');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','summer','18','ELECD',0.0079,'Rep day 2023_07_20');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','summer','19','ELECD',0.0077,'Rep day 2023_07_20');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','summer','20','ELECD',0.0077,'Rep day 2023_07_20');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','summer','21','ELECD',0.0071,'Rep day 2023_07_20');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','summer','22','ELECD',0.0071,'Rep day 2023_07_20');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','summer','23','ELECD',0.0070,'Rep day 2023_07_20');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','fall','0','ELECD',0.0084,'Rep day 2023_10_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','fall','1','ELECD',0.0086,'Rep day 2023_10_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','fall','2','ELECD',0.0083,'Rep day 2023_10_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','fall','3','ELECD',0.0082,'Rep day 2023_10_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','fall','4','ELECD',0.0080,'Rep day 2023_10_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','fall','5','ELECD',0.0082,'Rep day 2023_10_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','fall','6','ELECD',0.0088,'Rep day 2023_10_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','fall','7','ELECD',0.0096,'Rep day 2023_10_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','fall','8','ELECD',0.0123,'Rep day 2023_10_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','fall','9','ELECD',0.0123,'Rep day 2023_10_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','fall','10','ELECD',0.0124,'Rep day 2023_10_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','fall','11','ELECD',0.0133,'Rep day 2023_10_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','fall','12','ELECD',0.0123,'Rep day 2023_10_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','fall','13','ELECD',0.0122,'Rep day 2023_10_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','fall','14','ELECD',0.0126,'Rep day 2023_10_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','fall','15','ELECD',0.0106,'Rep day 2023_10_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','fall','16','ELECD',0.0123,'Rep day 2023_10_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','fall','17','ELECD',0.0122,'Rep day 2023_10_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','fall','18','ELECD',0.0115,'Rep day 2023_10_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','fall','19','ELECD',0.0090,'Rep day 2023_10_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','fall','20','ELECD',0.0115,'Rep day 2023_10_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','fall','21','ELECD',0.0110,'Rep day 2023_10_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','fall','22','ELECD',0.0102,'Rep day 2023_10_05');
INSERT INTO DemandSpecificDistribution VALUES ('shungnak','fall','23','ELECD',0.0095,'Rep day 2023_10_05');
CREATE TABLE LoanRate
(
    region  TEXT,
    tech    TEXT
        REFERENCES Technology (tech),
    vintage INTEGER
        REFERENCES TimePeriod (period),
    rate    REAL,
    notes   TEXT,
    PRIMARY KEY (region, tech, vintage)
);
CREATE TABLE Efficiency
(
    region      TEXT,
    input_comm  TEXT
        REFERENCES Commodity (name),
    tech        TEXT
        REFERENCES Technology (tech),
    vintage     INTEGER
        REFERENCES TimePeriod (period),
    output_comm TEXT
        REFERENCES Commodity (name),
    efficiency  REAL,
    notes       TEXT,
    PRIMARY KEY (region, input_comm, tech, vintage, output_comm),
    CHECK (efficiency > 0)
);
-- 1. IMPORTS (Efficiency = 1.0)
-- IMP_DSL (Diesel Import)
INSERT INTO Efficiency VALUES ('shungnak','ethos','IMP_DSL',2025,'DSL',1.0,'');
INSERT INTO Efficiency VALUES ('shungnak','ethos','IMP_DSL',2030,'DSL',1.0,'');
INSERT INTO Efficiency VALUES ('shungnak','ethos','IMP_DSL',2035,'DSL',1.0,'');
INSERT INTO Efficiency VALUES ('shungnak','ethos','IMP_DSL',2040,'DSL',1.0,'');
INSERT INTO Efficiency VALUES ('shungnak','ethos','IMP_DSL',2045,'DSL',1.0,'');
-- IMP_HYD (Hydro Import)
INSERT INTO Efficiency VALUES ('shungnak','ethos','IMP_HYD',2025,'HYD',1.0,'');
INSERT INTO Efficiency VALUES ('shungnak','ethos','IMP_HYD',2030,'HYD',1.0,'');
INSERT INTO Efficiency VALUES ('shungnak','ethos','IMP_HYD',2035,'HYD',1.0,'');
INSERT INTO Efficiency VALUES ('shungnak','ethos','IMP_HYD',2040,'HYD',1.0,'');
INSERT INTO Efficiency VALUES ('shungnak','ethos','IMP_HYD',2045,'HYD',1.0,'');
-- IMP_SOL (Solar Import)
INSERT INTO Efficiency VALUES ('shungnak','ethos','IMP_SOL',2025,'SOL',1.0,'');
INSERT INTO Efficiency VALUES ('shungnak','ethos','IMP_SOL',2030,'SOL',1.0,'');
INSERT INTO Efficiency VALUES ('shungnak','ethos','IMP_SOL',2035,'SOL',1.0,'');
INSERT INTO Efficiency VALUES ('shungnak','ethos','IMP_SOL',2040,'SOL',1.0,'');
INSERT INTO Efficiency VALUES ('shungnak','ethos','IMP_SOL',2045,'SOL',1.0,'');
-- IMP_WND (Wind Import)
INSERT INTO Efficiency VALUES ('shungnak','ethos','IMP_WND',2025,'WND',1.0,'');
INSERT INTO Efficiency VALUES ('shungnak','ethos','IMP_WND',2030,'WND',1.0,'');
INSERT INTO Efficiency VALUES ('shungnak','ethos','IMP_WND',2035,'WND',1.0,'');
INSERT INTO Efficiency VALUES ('shungnak','ethos','IMP_WND',2040,'WND',1.0,'');
INSERT INTO Efficiency VALUES ('shungnak','ethos','IMP_WND',2045,'WND',1.0,'');
-- 2. DIESEL GENERATORS (Efficiency = 0.34)
-- Input: DSL -> Output: ELC
-- Basis: ~13.7 kWh/gal (Standard AK Village efficiency). Ref: AEA PCE Report 2023.
-- GDSL_01 (505 kW)
INSERT INTO Efficiency VALUES ('shungnak','DSL','GDSL_01',2025,'ELC',0.34,'Ref: AEA PCE Report 2023 (~13.7 kWh/gal)');
INSERT INTO Efficiency VALUES ('shungnak','DSL','GDSL_01',2030,'ELC',0.34,'Ref: AEA PCE Report 2023 (~13.7 kWh/gal)');
INSERT INTO Efficiency VALUES ('shungnak','DSL','GDSL_01',2035,'ELC',0.34,'Ref: AEA PCE Report 2023 (~13.7 kWh/gal)');
INSERT INTO Efficiency VALUES ('shungnak','DSL','GDSL_01',2040,'ELC',0.34,'Ref: AEA PCE Report 2023 (~13.7 kWh/gal)');
INSERT INTO Efficiency VALUES ('shungnak','DSL','GDSL_01',2045,'ELC',0.34,'Ref: AEA PCE Report 2023 (~13.7 kWh/gal)');
-- GDSL_02 (363 kW)
INSERT INTO Efficiency VALUES ('shungnak','DSL','GDSL_02',2025,'ELC',0.34,'Ref: AEA PCE Report 2023 (~13.7 kWh/gal)');
INSERT INTO Efficiency VALUES ('shungnak','DSL','GDSL_02',2030,'ELC',0.34,'Ref: AEA PCE Report 2023 (~13.7 kWh/gal)');
INSERT INTO Efficiency VALUES ('shungnak','DSL','GDSL_02',2035,'ELC',0.34,'Ref: AEA PCE Report 2023 (~13.7 kWh/gal)');
INSERT INTO Efficiency VALUES ('shungnak','DSL','GDSL_02',2040,'ELC',0.34,'Ref: AEA PCE Report 2023 (~13.7 kWh/gal)');
INSERT INTO Efficiency VALUES ('shungnak','DSL','GDSL_02',2045,'ELC',0.34,'Ref: AEA PCE Report 2023 (~13.7 kWh/gal)');
-- GDSL_03 (505 kW)
INSERT INTO Efficiency VALUES ('shungnak','DSL','GDSL_03',2025,'ELC',0.34,'Ref: AEA PCE Report 2023 (~13.7 kWh/gal)');
INSERT INTO Efficiency VALUES ('shungnak','DSL','GDSL_03',2030,'ELC',0.34,'Ref: AEA PCE Report 2023 (~13.7 kWh/gal)');
INSERT INTO Efficiency VALUES ('shungnak','DSL','GDSL_03',2035,'ELC',0.34,'Ref: AEA PCE Report 2023 (~13.7 kWh/gal)');
INSERT INTO Efficiency VALUES ('shungnak','DSL','GDSL_03',2040,'ELC',0.34,'Ref: AEA PCE Report 2023 (~13.7 kWh/gal)');
INSERT INTO Efficiency VALUES ('shungnak','DSL','GDSL_03',2045,'ELC',0.34,'Ref: AEA PCE Report 2023 (~13.7 kWh/gal)');
-- 3. RENEWABLES (Efficiency defined as 1.0)
-- Actual output controlled by CapacityFactorTech
-- Solar PV (GSOL_01)
INSERT INTO Efficiency VALUES ('shungnak','SOL','GSOL_01',2025,'ELC',1.0,'Modeling convention: Capacity Factor handles resource');
INSERT INTO Efficiency VALUES ('shungnak','SOL','GSOL_01',2030,'ELC',1.0,'Modeling convention: Capacity Factor handles resource');
INSERT INTO Efficiency VALUES ('shungnak','SOL','GSOL_01',2035,'ELC',1.0,'Modeling convention: Capacity Factor handles resource');
INSERT INTO Efficiency VALUES ('shungnak','SOL','GSOL_01',2040,'ELC',1.0,'Modeling convention: Capacity Factor handles resource');
INSERT INTO Efficiency VALUES ('shungnak','SOL','GSOL_01',2045,'ELC',1.0,'Modeling convention: Capacity Factor handles resource');
-- Hydro (GHYD_01) 
INSERT INTO Efficiency VALUES ('shungnak','HYD','GHYD_01',2030,'ELC',1.0,'Modeling convention: Capacity Factor handles resource');
INSERT INTO Efficiency VALUES ('shungnak','HYD','GHYD_01',2035,'ELC',1.0,'Modeling convention: Capacity Factor handles resource');
INSERT INTO Efficiency VALUES ('shungnak','HYD','GHYD_01',2040,'ELC',1.0,'Modeling convention: Capacity Factor handles resource');
INSERT INTO Efficiency VALUES ('shungnak','HYD','GHYD_01',2045,'ELC',1.0,'Modeling convention: Capacity Factor handles resource');
-- Wind (GWND_01)
INSERT INTO Efficiency VALUES ('shungnak','WND','GWND_01',2030,'ELC',1.0,'Modeling convention: Capacity Factor handles resource');
INSERT INTO Efficiency VALUES ('shungnak','WND','GWND_01',2035,'ELC',1.0,'Modeling convention: Capacity Factor handles resource');
INSERT INTO Efficiency VALUES ('shungnak','WND','GWND_01',2040,'ELC',1.0,'Modeling convention: Capacity Factor handles resource');
INSERT INTO Efficiency VALUES ('shungnak','WND','GWND_01',2045,'ELC',1.0,'Modeling convention: Capacity Factor handles resource');
-- 4. STORAGE & GRID
-- Battery (EBATT_01) - Roundtrip Efficiency 0.85
INSERT INTO Efficiency VALUES ('shungnak','ELC','EBATT_01',2025,'ELC',0.85,'Ref: NREL ATB 2024 (Round-trip efficiency)');
INSERT INTO Efficiency VALUES ('shungnak','ELC','EBATT_01',2030,'ELC',0.85,'Ref: NREL ATB 2024 (Round-trip efficiency)');
INSERT INTO Efficiency VALUES ('shungnak','ELC','EBATT_01',2035,'ELC',0.85,'Ref: NREL ATB 2024 (Round-trip efficiency)');
INSERT INTO Efficiency VALUES ('shungnak','ELC','EBATT_01',2040,'ELC',0.85,'Ref: NREL ATB 2024 (Round-trip efficiency)');
INSERT INTO Efficiency VALUES ('shungnak','ELC','EBATT_01',2045,'ELC',0.85,'Ref: NREL ATB 2024 (Round-trip efficiency)');
-- Grid Bookkeeping (ELECT) - Efficiency 1.0
-- Transfers produced electricity (ELC) to demand (ELECD)
INSERT INTO Efficiency VALUES ('shungnak','ELC','ELECT',2030,'ELECD',1.0,'');
INSERT INTO Efficiency VALUES ('shungnak','ELC','ELECT',2035,'ELECD',1.0,'');
INSERT INTO Efficiency VALUES ('shungnak','ELC','ELECT',2040,'ELECD',1.0,'');
INSERT INTO Efficiency VALUES ('shungnak','ELC','ELECT',2045,'ELECD',1.0,'');
CREATE TABLE EmissionActivity
(
    region      TEXT,
    emis_comm   TEXT
        REFERENCES Commodity (name),
    input_comm  TEXT
        REFERENCES Commodity (name),
    tech        TEXT
        REFERENCES Technology (tech),
    vintage     INTEGER
        REFERENCES TimePeriod (period),
    output_comm TEXT
        REFERENCES Commodity (name),
    activity    REAL,
    units       TEXT,
    notes       TEXT,
    PRIMARY KEY (region, emis_comm, input_comm, tech, vintage, output_comm)
);
-- 1. DIESEL GENERATORS (Burning Fuel)
-- Factor: ~0.0007421 tCO2/kWh (Based on 34% Efficiency)
-- GDSL_01 (505 kW)
INSERT INTO EmissionActivity VALUES ('shungnak','co2','DSL','GDSL_01',2025,'ELC',0.0007421,'tCO2_per_kWh_el','EPA 40 CFR Part 98, Table C-1 (73.96 kg/MMBtu) + η_el=0.34');
INSERT INTO EmissionActivity VALUES ('shungnak','co2','DSL','GDSL_01',2030,'ELC',0.0007421,'tCO2_per_kWh_el','');
INSERT INTO EmissionActivity VALUES ('shungnak','co2','DSL','GDSL_01',2035,'ELC',0.0007421,'tCO2_per_kWh_el','');
INSERT INTO EmissionActivity VALUES ('shungnak','co2','DSL','GDSL_01',2040,'ELC',0.0007421,'tCO2_per_kWh_el','');
INSERT INTO EmissionActivity VALUES ('shungnak','co2','DSL','GDSL_01',2045,'ELC',0.0007421,'tCO2_per_kWh_el','');
-- GDSL_02 CO2 emissions per kWh of ELECTRICITY output
INSERT INTO EmissionActivity VALUES ('shungnak','co2','DSL','GDSL_02',2025,'ELC',0.0007421,'tCO2_per_kWh_el','EPA 40 CFR Part 98, Table C-1 (73.96 kg/MMBtu) + η_el=0.34');
INSERT INTO EmissionActivity VALUES ('shungnak','co2','DSL','GDSL_02',2030,'ELC',0.0007421,'tCO2_per_kWh_el','');
INSERT INTO EmissionActivity VALUES ('shungnak','co2','DSL','GDSL_02',2035,'ELC',0.0007421,'tCO2_per_kWh_el','');
INSERT INTO EmissionActivity VALUES ('shungnak','co2','DSL','GDSL_02',2040,'ELC',0.0007421,'tCO2_per_kWh_el','');
INSERT INTO EmissionActivity VALUES ('shungnak','co2','DSL','GDSL_02',2045,'ELC',0.0007421,'tCO2_per_kWh_el','');
-- GDSL_03 CO2 emissions per kWh of ELECTRICITY output
INSERT INTO EmissionActivity VALUES ('shungnak','co2','DSL','GDSL_03',2025,'ELC',0.0007421,'tCO2_per_kWh_el','EPA 40 CFR Part 98, Table C-1 (73.96 kg/MMBtu) + η_el=0.34');
INSERT INTO EmissionActivity VALUES ('shungnak','co2','DSL','GDSL_03',2030,'ELC',0.0007421,'tCO2_per_kWh_el','');
INSERT INTO EmissionActivity VALUES ('shungnak','co2','DSL','GDSL_03',2035,'ELC',0.0007421,'tCO2_per_kWh_el','');
INSERT INTO EmissionActivity VALUES ('shungnak','co2','DSL','GDSL_03',2040,'ELC',0.0007421,'tCO2_per_kWh_el','');
INSERT INTO EmissionActivity VALUES ('shungnak','co2','DSL','GDSL_03',2045,'ELC',0.0007421,'tCO2_per_kWh_el','');
-- PV, wind, hydro (no direct CO2)
INSERT INTO EmissionActivity VALUES ('shungnak','co2','SOL','GSOL_01',2025,'ELC',0.0,'tCO2_per_kWh_el','non-combustion');
INSERT INTO EmissionActivity VALUES ('shungnak','co2','WND','GWND_01',2025,'ELC',0.0,'tCO2_per_kWh_el','non-combustion');
INSERT INTO EmissionActivity VALUES ('shungnak','co2','HYD','GHYD_01',2025,'ELC',0.0,'tCO2_per_kWh_el','non-combustion');
-- Router (ELC to ELECD) also zero
INSERT INTO EmissionActivity VALUES ('shungnak','co2','ELC','ELECT',2025,'ELECD',0.0,'','routing only');
-- Imports (identity transfers)
INSERT INTO EmissionActivity VALUES ('shungnak','co2','ethos','IMP_DSL',2030,'DSL',0.0,'','');
INSERT INTO EmissionActivity VALUES ('shungnak','co2','ethos','IMP_SOL',2030,'SOL',0.0,'','');
INSERT INTO EmissionActivity VALUES ('shungnak','co2','ethos','IMP_WND',2030,'WND',0.0,'','');
INSERT INTO EmissionActivity VALUES ('shungnak','co2','ethos','IMP_HYD',2030,'HYD',0.0,'','');
CREATE TABLE ExistingCapacity
(
    region   TEXT,
    tech     TEXT
        REFERENCES Technology (tech),
    vintage  INTEGER
        REFERENCES TimePeriod (period),
    capacity REAL,
    units    TEXT,
    notes    TEXT,
    PRIMARY KEY (region, tech, vintage)
);
-- Existing diesel generators
INSERT INTO ExistingCapacity VALUES ('shungnak','GDSL_01',2025,505,'kW','Caterpillar 3456 (505 kW)');
INSERT INTO ExistingCapacity VALUES ('shungnak','GDSL_02',2025,363,'kW','Caterpillar 3406B (363 kW)');
INSERT INTO ExistingCapacity VALUES ('shungnak','GDSL_03',2025,505,'kW','Caterpillar 3456 (505 kW)');
-- Existing PV (Shungnak ANRI build circa 2025)
INSERT INTO ExistingCapacity VALUES ('shungnak','GSOL_01',2025,186.3,'kW','ANRI SolarEdge array, Shungnak-owned portion');
-- Battery
INSERT INTO ExistingCapacity VALUES ('shungnak','EBATT_01',2025,250,'kW','Ageto/Blue Planet system (power rating)'); 

CREATE TABLE TechGroup
(
    group_name TEXT
        PRIMARY KEY,
    notes      TEXT
);
CREATE TABLE GrowthRateMax
(
    region TEXT,
    tech   TEXT
        REFERENCES Technology (tech),
    rate   REAL,
    notes  TEXT,
    PRIMARY KEY (region, tech)
);
CREATE TABLE GrowthRateSeed
(
    region TEXT,
    tech   TEXT
        REFERENCES Technology (tech),
    seed   REAL,
    units  TEXT,
    notes  TEXT,
    PRIMARY KEY (region, tech)
);
CREATE TABLE LoanLifetimeTech
(
    region   TEXT,
    tech     TEXT
        REFERENCES Technology (tech),
    lifetime REAL,
    notes    TEXT,
    PRIMARY KEY (region, tech)
);
-- Diesel: conservative financing assumption; AEA PPF allows up to 20 years
INSERT INTO LoanLifetimeTech VALUES ('shungnak','GDSL_01',15,'Conservative financing assumption; AEA PPF allows up to 20 years');
INSERT INTO LoanLifetimeTech VALUES ('shungnak','GDSL_02',15,'Conservative financing assumption; AEA PPF allows up to 20 years');
INSERT INTO LoanLifetimeTech VALUES ('shungnak','GDSL_03',15,'Conservative financing assumption; AEA PPF allows up to 20 years');
-- Solar PV: aligned with AEA PPF loan term ceiling
INSERT INTO LoanLifetimeTech VALUES ('shungnak','GSOL_01',20,'AEA PPF solar photovoltaic facilities: up to 20 years');
-- Wind: aligned with AEA PPF loan term ceiling
INSERT INTO LoanLifetimeTech VALUES ('shungnak','GWND_01',20,'AEA PPF wind facilities: up to 20 years');
-- Hydro: conservative assumption under AEA 50-year ceiling
INSERT INTO LoanLifetimeTech VALUES ('shungnak','GHYD_01',40,'Conservative assumption; AEA PPF hydroelectric facilities: up to 50 years');
-- Battery: ATB technical lifetime
INSERT INTO LoanLifetimeTech VALUES ('shungnak','EBATT_01',15,'NREL ATB utility-scale battery storage lifetime: 15 years');
-- GRID BOOKKEEPING (60 Years)
-- Standard transmission asset depreciation schedule.
INSERT INTO LoanLifetimeTech VALUES ('shungnak','ELECT',60,'Bookkeeping');
CREATE TABLE LifetimeProcess
(
    region   TEXT,
    tech     TEXT
        REFERENCES Technology (tech),
    vintage  INTEGER
        REFERENCES TimePeriod (period),
    lifetime REAL,
    notes    TEXT,
    PRIMARY KEY (region, tech, vintage)
);
-- DIESEL
-- Useful life based on MIT CEEPR Alaska diesel technology assumptions; 20 years used as a conservative value for village-scale diesel units.
INSERT INTO LifetimeProcess VALUES ('shungnak','GDSL_01',2030,20.0,'Ref: MacdonaldParsons2021 diesel lifetime assumption');
INSERT INTO LifetimeProcess VALUES ('shungnak','GDSL_02',2035,20.0,'Ref: MacdonaldParsons2021 diesel lifetime assumption');
INSERT INTO LifetimeProcess VALUES ('shungnak','GDSL_03',2040,20.0,'Ref: MacdonaldParsons2021 diesel lifetime assumption');
-- SOLAR
-- ATB technical life for utility-scale PV.
INSERT INTO LifetimeProcess VALUES ('shungnak','GSOL_01',2030,30.0,'Ref: NREL ATB 2024 technical life');
INSERT INTO LifetimeProcess VALUES ('shungnak','GSOL_01',2035,30.0,'Ref: NREL ATB 2024 technical life');
INSERT INTO LifetimeProcess VALUES ('shungnak','GSOL_01',2040,30.0,'Ref: NREL ATB 2024 technical life');
INSERT INTO LifetimeProcess VALUES ('shungnak','GSOL_01',2045,30.0,'Ref: NREL ATB 2024 technical life');
-- BATTERY
-- ATB technical life for utility-scale battery storage.
INSERT INTO LifetimeProcess VALUES ('shungnak','EBATT_01',2030,15.0,'Ref: NREL ATB 2024 utility-scale battery storage lifetime');
INSERT INTO LifetimeProcess VALUES ('shungnak','EBATT_01',2035,15.0,'Ref: NREL ATB 2024 utility-scale battery storage lifetime');
INSERT INTO LifetimeProcess VALUES ('shungnak','EBATT_01',2040,15.0,'Ref: NREL ATB 2024 utility-scale battery storage lifetime');
INSERT INTO LifetimeProcess VALUES ('shungnak','EBATT_01',2045,15.0,'Ref: NREL ATB 2024 utility-scale battery storage lifetime');
-- WIND
-- Conservative useful life for distributed wind in harsh operating environments.
INSERT INTO LifetimeProcess VALUES ('shungnak','GWND_01',2030,20.0,'Ref: PNNL Distributed Wind Guidebook');
INSERT INTO LifetimeProcess VALUES ('shungnak','GWND_01',2035,20.0,'Ref: PNNL Distributed Wind Guidebook');
INSERT INTO LifetimeProcess VALUES ('shungnak','GWND_01',2040,20.0,'Ref: PNNL Distributed Wind Guidebook');
INSERT INTO LifetimeProcess VALUES ('shungnak','GWND_01',2045,20.0,'Ref: PNNL Distributed Wind Guidebook');
-- HYDRO
-- ATB technical life for hydropower.
INSERT INTO LifetimeProcess VALUES ('shungnak','GHYD_01',2030,100.0,'Ref: NREL ATB 2024 technical life');
INSERT INTO LifetimeProcess VALUES ('shungnak','GHYD_01',2035,100.0,'Ref: NREL ATB 2024 technical life');
INSERT INTO LifetimeProcess VALUES ('shungnak','GHYD_01',2040,100.0,'Ref: NREL ATB 2024 technical life');
INSERT INTO LifetimeProcess VALUES ('shungnak','GHYD_01',2045,100.0,'Ref: NREL ATB 2024 technical life');
-- GRID
-- Conservative generic distribution infrastructure life.
INSERT INTO LifetimeProcess VALUES ('shungnak','ELECT',2030,50.0,'Ref: DOE utility pole service life ranges');
CREATE TABLE LifetimeTech
(
    region   TEXT,
    tech     TEXT
        REFERENCES Technology (tech),
    lifetime REAL,
    notes    TEXT,
    PRIMARY KEY (region, tech)
);
-- DIESEL
-- Alaska case-study benchmark for remote diesel systems.
INSERT INTO LifetimeTech VALUES ('shungnak','GDSL_01',20,'Ref: MacdonaldParsons2021 Alaska case-study benchmark');
INSERT INTO LifetimeTech VALUES ('shungnak','GDSL_02',20,'Ref: MacdonaldParsons2021 Alaska case-study benchmark');
INSERT INTO LifetimeTech VALUES ('shungnak','GDSL_03',20,'Ref: MacdonaldParsons2021 Alaska case-study benchmark');
-- SOLAR
-- ATB technical life for utility-scale PV.
INSERT INTO LifetimeTech VALUES ('shungnak','GSOL_01',30,'Ref: NREL ATB 2024 utility-scale PV technical life');
-- WIND
-- Conservative useful life for distributed wind in harsh environments.
INSERT INTO LifetimeTech VALUES ('shungnak','GWND_01',20,'Ref: PNNL Distributed Wind Guidebook (20 to 25 years)');
-- HYDRO
-- ATB technical life for hydropower.
INSERT INTO LifetimeTech VALUES ('shungnak','GHYD_01',100,'Ref: NREL ATB 2024 hydropower technical life');
-- BATTERY
-- ATB technical life for utility-scale battery storage.
INSERT INTO LifetimeTech VALUES ('shungnak','EBATT_01',15,'Ref: NREL ATB 2024 utility-scale battery storage lifetime');
-- IMPORTS (Placeholder processes)
INSERT INTO LifetimeTech VALUES('shungnak','IMP_DSL',1000.0,'Placeholder import process');
INSERT INTO LifetimeTech VALUES('shungnak','IMP_SOL',1000.0,'Placeholder import process');
INSERT INTO LifetimeTech VALUES('shungnak','IMP_HYD',1000.0,'Placeholder import process');
INSERT INTO LifetimeTech VALUES('shungnak','IMP_WND',1000.0,'Placeholder import process');
-- GRID
-- Conservative generic network bookkeeping life.
INSERT INTO LifetimeTech VALUES ('shungnak','ELECT',50,'Ref: DOE utility pole/service life ranges');
CREATE TABLE LinkedTech
(
    primary_region TEXT,
    primary_tech   TEXT
        REFERENCES Technology (tech),
    emis_comm      TEXT
        REFERENCES Commodity (name),
    driven_tech    TEXT
        REFERENCES Technology (tech),
    notes          TEXT,
    PRIMARY KEY (primary_region, primary_tech, emis_comm)
);
CREATE TABLE MaxActivity
(
    region  TEXT,
    period  INTEGER
        REFERENCES TimePeriod (period),
    tech    TEXT
        REFERENCES Technology (tech),
    max_act REAL,
    units   TEXT,
    notes   TEXT,
    PRIMARY KEY (region, period, tech)
);
CREATE TABLE MaxCapacity
(
    region  TEXT,
    period  INTEGER
        REFERENCES TimePeriod (period),
    tech    TEXT
        REFERENCES Technology (tech),
    max_cap REAL,
    units   TEXT,
    notes   TEXT,
    PRIMARY KEY (region, period, tech)
);
-- SOLAR: 1000 kW Ceiling (Allows ~3x overbuild relative to peak load for winter coverage)
-- Source: Current install 186.3 kW; planned expansion to ~500kW (NWAB Energy Plan).
INSERT INTO MaxCapacity VALUES ('shungnak',2030,'GSOL_01',1000,'kW','Total technical potential for solar');
INSERT INTO MaxCapacity VALUES ('shungnak',2035,'GSOL_01',1000,'kW','Total technical potential for solar');
INSERT INTO MaxCapacity VALUES ('shungnak',2040,'GSOL_01',1000,'kW','Total technical potential for solar');
INSERT INTO MaxCapacity VALUES ('shungnak',2045,'GSOL_01',1000,'kW','Total technical potential for solar');
-- WIND: 500 kW Ceiling (approx. 2-5 turbines on nearby ridges)
-- Source: Cosmos Hills potential; NPS 100kW turbines are standard for village wind.
INSERT INTO MaxCapacity VALUES ('shungnak',2030,'GWND_01',500,'kW','Total technical potential for wind');
INSERT INTO MaxCapacity VALUES ('shungnak',2035,'GWND_01',500,'kW','Total technical potential for wind');
INSERT INTO MaxCapacity VALUES ('shungnak',2040,'GWND_01',500,'kW','Total technical potential for wind');
INSERT INTO MaxCapacity VALUES ('shungnak',2045,'GWND_01',500,'kW','Total technical potential for wind');
-- HYDRO: 1200 kW Ceiling (Run-of-River)
-- Source: Village-scale hydro ceiling based on 1981 Army Corps Cosmos Creek installation concept
-- Dahl Creek also has ~140 kW potential.
INSERT INTO MaxCapacity VALUES ('shungnak',2030,'GHYD_01',144,'kW','Total technical potential for hydro');
INSERT INTO MaxCapacity VALUES ('shungnak',2035,'GHYD_01',144,'kW','Total technical potential for hydro');
INSERT INTO MaxCapacity VALUES ('shungnak',2040,'GHYD_01',144,'kW','Total technical potential for hydro');
INSERT INTO MaxCapacity VALUES ('shungnak',2045,'GHYD_01',144,'kW','Total technical potential for hydro');
CREATE TABLE MaxResource
(
    region  TEXT,
    tech    TEXT
        REFERENCES Technology (tech),
    max_res REAL,
    units   TEXT,
    notes   TEXT,
    PRIMARY KEY (region, tech)
);
CREATE TABLE MinActivity
(
    region  TEXT,
    period  INTEGER
        REFERENCES TimePeriod (period),
    tech    TEXT
        REFERENCES Technology (tech),
    min_act REAL,
    units   TEXT,
    notes   TEXT,
    PRIMARY KEY (region, period, tech)
);
CREATE TABLE MaxCapacityGroup
(
    region     TEXT,
    period     INTEGER
        REFERENCES TimePeriod (period),
    group_name TEXT
        REFERENCES TechGroup (group_name),
    max_cap    REAL,
    units      TEXT,
    notes      TEXT,
    PRIMARY KEY (region, period, group_name)
);
CREATE TABLE MinCapacity
(
    region  TEXT,
    period  INTEGER
        REFERENCES TimePeriod (period),
    tech    TEXT
        REFERENCES Technology (tech),
    min_cap REAL,
    units   TEXT,
    notes   TEXT,
    PRIMARY KEY (region, period, tech)
);
-- DIESEL: must-stay in 2030 to 2035, free to retire later
INSERT INTO MinCapacity VALUES ('shungnak',2030,'GDSL_01',505,'kW','CAT 3456 ~505 kW nameplate must-run in 2030');
INSERT INTO MinCapacity VALUES ('shungnak',2035,'GDSL_01',505,'kW','allow retirement/transition');
INSERT INTO MinCapacity VALUES ('shungnak',2040,'GDSL_01',0,'kW','allow retirement/transition');
INSERT INTO MinCapacity VALUES ('shungnak',2045,'GDSL_01',0,'kW','allow retirement/transition');
INSERT INTO MinCapacity VALUES ('shungnak',2030,'GDSL_02',363,'kW','CAT 3406B ~363 kW nameplate must-run in 2030');
INSERT INTO MinCapacity VALUES ('shungnak',2035,'GDSL_02',363,'kW','allow retirement/transition');
INSERT INTO MinCapacity VALUES ('shungnak',2040,'GDSL_02',363,'kW','allow retirement/transition');
INSERT INTO MinCapacity VALUES ('shungnak',2045,'GDSL_02',363,'kW','allow retirement/transition');
INSERT INTO MinCapacity VALUES ('shungnak',2030,'GDSL_03',505,'kW','CAT 3456 ~505 kW nameplate must-run in 2030');
INSERT INTO MinCapacity VALUES ('shungnak',2035,'GDSL_03',505,'kW','allow retirement/transition');
INSERT INTO MinCapacity VALUES ('shungnak',2040,'GDSL_03',0,'kW','allow retirement/transition');
INSERT INTO MinCapacity VALUES ('shungnak',2045,'GDSL_03',0,'kW','allow retirement/transition');
-- SOLAR: preserve at least the owned array across horizon (186.3 kW)
INSERT INTO MinCapacity VALUES ('shungnak',2030,'GSOL_01',186.3,'kW','Owned PV (ANRI/SolarEdge 2025) kept online');
INSERT INTO MinCapacity VALUES ('shungnak',2035,'GSOL_01',186.3,'kW','Owned PV kept online');
INSERT INTO MinCapacity VALUES ('shungnak',2040,'GSOL_01',186.3,'kW','Owned PV kept online');
INSERT INTO MinCapacity VALUES ('shungnak',2045,'GSOL_01',186.3,'kW','Owned PV kept online');
-- BATTERY: preserve at least the owned battery across horizon (250 kW)
INSERT INTO MinCapacity VALUES ('shungnak',2030,'EBATT_01',250,'kW','optional BESS; cap handled by MaxCapacity');
INSERT INTO MinCapacity VALUES ('shungnak',2035,'EBATT_01',250,'kW','optional BESS');
INSERT INTO MinCapacity VALUES ('shungnak',2040,'EBATT_01',250,'kW','optional BESS');
INSERT INTO MinCapacity VALUES ('shungnak',2045,'EBATT_01',250,'kW','optional BESS');
-- HYPOTHETICALS
INSERT INTO MinCapacity VALUES ('shungnak',2030,'GHYD_01',0,'kW','planning option only');
INSERT INTO MinCapacity VALUES ('shungnak',2035,'GHYD_01',0,'kW','planning option only');
INSERT INTO MinCapacity VALUES ('shungnak',2040,'GHYD_01',0,'kW','planning option only');
INSERT INTO MinCapacity VALUES ('shungnak',2045,'GHYD_01',0,'kW','planning option only');
INSERT INTO MinCapacity VALUES ('shungnak',2030,'GWND_01',0,'kW','planning option only');
INSERT INTO MinCapacity VALUES ('shungnak',2035,'GWND_01',0,'kW','planning option only');
INSERT INTO MinCapacity VALUES ('shungnak',2040,'GWND_01',0,'kW','planning option only');
INSERT INTO MinCapacity VALUES ('shungnak',2045,'GWND_01',0,'kW','planning option only');
CREATE TABLE MinCapacityGroup
(
    region     TEXT,
    period     INTEGER
        REFERENCES TimePeriod (period),
    group_name TEXT
        REFERENCES TechGroup (group_name),
    min_cap    REAL,
    units      TEXT,
    notes      TEXT,
    PRIMARY KEY (region, period, group_name)
);
CREATE TABLE OutputCurtailment
(
    scenario    TEXT,
    region      TEXT,
    sector      TEXT,
    period      INTEGER
        REFERENCES TimePeriod (period),
    season      TEXT
        REFERENCES TimePeriod (period),
    tod         TEXT
        REFERENCES TimeOfDay (tod),
    input_comm  TEXT
        REFERENCES Commodity (name),
    tech        TEXT
        REFERENCES Technology (tech),
    vintage     INTEGER
        REFERENCES TimePeriod (period),
    output_comm TEXT
        REFERENCES Commodity (name),
    curtailment REAL,
    PRIMARY KEY (region, scenario, period, season, tod, input_comm, tech, vintage, output_comm)
);
CREATE TABLE OutputNetCapacity
(
    scenario TEXT,
    region   TEXT,
    sector   TEXT
        REFERENCES SectorLabel (sector),
    period   INTEGER
        REFERENCES TimePeriod (period),
    tech     TEXT
        REFERENCES Technology (tech),
    vintage  INTEGER
        REFERENCES TimePeriod (period),
    capacity REAL,
    PRIMARY KEY (region, scenario, period, tech, vintage)
);
CREATE TABLE OutputBuiltCapacity
(
    scenario TEXT,
    region   TEXT,
    sector   TEXT
        REFERENCES SectorLabel (sector),
    tech     TEXT
        REFERENCES Technology (tech),
    vintage  INTEGER
        REFERENCES TimePeriod (period),
    capacity REAL,
    PRIMARY KEY (region, scenario, tech, vintage)
);
CREATE TABLE OutputRetiredCapacity
(
    scenario TEXT,
    region   TEXT,
    sector   TEXT
        REFERENCES SectorLabel (sector),
    period   INTEGER
        REFERENCES TimePeriod (period),
    tech     TEXT
        REFERENCES Technology (tech),
    vintage  INTEGER
        REFERENCES TimePeriod (period),
    capacity REAL,
    PRIMARY KEY (region, scenario, period, tech, vintage)
);
CREATE TABLE OutputFlowIn
(
    scenario    TEXT,
    region      TEXT,
    sector      TEXT
        REFERENCES SectorLabel (sector),
    period      INTEGER
        REFERENCES TimePeriod (period),
    season      TEXT
        REFERENCES TimeSeason (season),
    tod         TEXT
        REFERENCES TimeOfDay (tod),
    input_comm  TEXT
        REFERENCES Commodity (name),
    tech        TEXT
        REFERENCES Technology (tech),
    vintage     INTEGER
        REFERENCES TimePeriod (period),
    output_comm TEXT
        REFERENCES Commodity (name),
    flow        REAL,
    PRIMARY KEY (region, scenario, period, season, tod, input_comm, tech, vintage, output_comm)
);
CREATE TABLE OutputFlowOut
(
    scenario    TEXT,
    region      TEXT,
    sector      TEXT
        REFERENCES SectorLabel (sector),
    period      INTEGER
        REFERENCES TimePeriod (period),
    season      TEXT
        REFERENCES TimePeriod (period),
    tod         TEXT
        REFERENCES TimeOfDay (tod),
    input_comm  TEXT
        REFERENCES Commodity (name),
    tech        TEXT
        REFERENCES Technology (tech),
    vintage     INTEGER
        REFERENCES TimePeriod (period),
    output_comm TEXT
        REFERENCES Commodity (name),
    flow        REAL,
    PRIMARY KEY (region, scenario, period, season, tod, input_comm, tech, vintage, output_comm)
);
CREATE TABLE PlanningReserveMargin
(
    region TEXT
        PRIMARY KEY
        REFERENCES Region (region),
    margin REAL
);
INSERT INTO PlanningReserveMargin VALUES ('shungnak',0.50);
CREATE TABLE RampDown
(
    region TEXT,
    tech   TEXT
        REFERENCES Technology (tech),
    rate   REAL,
    PRIMARY KEY (region, tech)
);
CREATE TABLE RampUp
(
    region TEXT,
    tech   TEXT
        REFERENCES Technology (tech),
    rate   REAL,
    PRIMARY KEY (region, tech)
);
CREATE TABLE Region
(
    region TEXT
        PRIMARY KEY,
    notes  TEXT
);
INSERT INTO Region VALUES('shungnak',NULL);
CREATE TABLE TimeSegmentFraction
(
    season  TEXT
        REFERENCES TimeSeason (season),
    tod     TEXT
        REFERENCES TimeOfDay (tod),
    segfrac REAL,
    notes   TEXT,
    PRIMARY KEY (season, tod),
    CHECK (segfrac >= 0 AND segfrac <= 1)
);
INSERT INTO TimeSegmentFraction VALUES ('spring','0',0.01041665,'4 days = 96 hours, 8760 hrs in a yr, 96/8760 = 0.01041665, corrected to add 1 = 0.01041665');
INSERT INTO TimeSegmentFraction VALUES ('spring','1',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('spring','2',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('spring','3',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('spring','4',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('spring','5',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('spring','6',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('spring','7',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('spring','8',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('spring','9',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('spring','10',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('spring','11',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('spring','12',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('spring','13',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('spring','14',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('spring','15',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('spring','16',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('spring','17',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('spring','18',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('spring','19',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('spring','20',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('spring','21',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('spring','22',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('spring','23',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('summer','0',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('summer','1',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('summer','2',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('summer','3',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('summer','4',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('summer','5',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('summer','6',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('summer','7',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('summer','8',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('summer','9',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('summer','10',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('summer','11',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('summer','12',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('summer','13',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('summer','14',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('summer','15',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('summer','16',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('summer','17',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('summer','18',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('summer','19',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('summer','20',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('summer','21',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('summer','22',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('summer','23',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('fall','0',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('fall','1',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('fall','2',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('fall','3',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('fall','4',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('fall','5',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('fall','6',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('fall','7',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('fall','8',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('fall','9',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('fall','10',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('fall','11',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('fall','12',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('fall','13',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('fall','14',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('fall','15',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('fall','16',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('fall','17',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('fall','18',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('fall','19',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('fall','20',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('fall','21',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('fall','22',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('fall','23',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('winter','0',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('winter','1',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('winter','2',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('winter','3',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('winter','4',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('winter','5',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('winter','6',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('winter','7',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('winter','8',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('winter','9',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('winter','10',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('winter','11',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('winter','12',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('winter','13',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('winter','14',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('winter','15',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('winter','16',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('winter','17',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('winter','18',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('winter','19',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('winter','20',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('winter','21',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('winter','22',0.01041665,'');
INSERT INTO TimeSegmentFraction VALUES ('winter','23',0.01041665,'');
CREATE TABLE StorageDuration
(
    region   TEXT,
    tech     TEXT,
    duration REAL,
    notes    TEXT,
    PRIMARY KEY (region, tech)
);
-- Shungnak Blue Ion System (384 kWh / 250 kW)
INSERT INTO StorageDuration VALUES ('shungnak','EBATT_01',4,'4-hour duration (384kWh/250kW)');
CREATE TABLE StorageInit
(
    tech  TEXT
        PRIMARY KEY,
    value REAL,
    notes TEXT
);
CREATE TABLE TechnologyType
(
    label       TEXT
        PRIMARY KEY,
    description TEXT
);
INSERT INTO TechnologyType VALUES('r','resource technology');
INSERT INTO TechnologyType VALUES('p','production technology');
INSERT INTO TechnologyType VALUES('pb','baseload production technology');
INSERT INTO TechnologyType VALUES('ps','storage production technology');
CREATE TABLE TechInputSplit
(
    region         TEXT,
    period         INTEGER
        REFERENCES TimePeriod (period),
    input_comm     TEXT
        REFERENCES Commodity (name),
    tech           TEXT
        REFERENCES Technology (tech),
    min_proportion REAL,
    notes          TEXT,
    PRIMARY KEY (region, period, input_comm, tech)
);
CREATE TABLE TechInputSplitAverage
(
    region         TEXT,
    period         INTEGER
        REFERENCES TimePeriod (period),
    input_comm     TEXT
        REFERENCES Commodity (name),
    tech           TEXT
        REFERENCES Technology (tech),
    min_proportion REAL,
    notes          TEXT,
    PRIMARY KEY (region, period, input_comm, tech)
);
CREATE TABLE TechOutputSplit
(
    region         TEXT,
    period         INTEGER
        REFERENCES TimePeriod (period),
    tech           TEXT
        REFERENCES Technology (tech),
    output_comm    TEXT
        REFERENCES Commodity (name),
    min_proportion REAL,
    notes          TEXT,
    PRIMARY KEY (region, period, tech, output_comm)
);
-- Single-output generators and imports: 100% to their output commodity
-- Periods: 2030, 2035, 2040, 2045
-- DIESEL GENSET to ELC
INSERT INTO TechOutputSplit VALUES ('shungnak',2030,'GDSL_01','ELC',1.0,'single-output electricity');
INSERT INTO TechOutputSplit VALUES ('shungnak',2035,'GDSL_01','ELC',1.0,'single-output electricity');
INSERT INTO TechOutputSplit VALUES ('shungnak',2040,'GDSL_01','ELC',1.0,'single-output electricity');
INSERT INTO TechOutputSplit VALUES ('shungnak',2045,'GDSL_01','ELC',1.0,'single-output electricity');
INSERT INTO TechOutputSplit VALUES ('shungnak',2030,'GDSL_02','ELC',1.0,'single-output electricity');
INSERT INTO TechOutputSplit VALUES ('shungnak',2035,'GDSL_02','ELC',1.0,'single-output electricity');
INSERT INTO TechOutputSplit VALUES ('shungnak',2040,'GDSL_02','ELC',1.0,'single-output electricity');
INSERT INTO TechOutputSplit VALUES ('shungnak',2045,'GDSL_02','ELC',1.0,'single-output electricity');
INSERT INTO TechOutputSplit VALUES ('shungnak',2030,'GDSL_03','ELC',1.0,'single-output electricity');
INSERT INTO TechOutputSplit VALUES ('shungnak',2035,'GDSL_03','ELC',1.0,'single-output electricity');
INSERT INTO TechOutputSplit VALUES ('shungnak',2040,'GDSL_03','ELC',1.0,'single-output electricity');
INSERT INTO TechOutputSplit VALUES ('shungnak',2045,'GDSL_03','ELC',1.0,'single-output electricity');
-- SOLAR / HYDRO / WIND to ELC
INSERT INTO TechOutputSplit VALUES ('shungnak',2030,'GSOL_01','ELC',1.0,'PV output is electricity');
INSERT INTO TechOutputSplit VALUES ('shungnak',2035,'GSOL_01','ELC',1.0,'PV output is electricity');
INSERT INTO TechOutputSplit VALUES ('shungnak',2040,'GSOL_01','ELC',1.0,'PV output is electricity');
INSERT INTO TechOutputSplit VALUES ('shungnak',2045,'GSOL_01','ELC',1.0,'PV output is electricity');
INSERT INTO TechOutputSplit VALUES ('shungnak',2030,'GHYD_01','ELC',1.0,'Hydro output is electricity');
INSERT INTO TechOutputSplit VALUES ('shungnak',2035,'GHYD_01','ELC',1.0,'Hydro output is electricity');
INSERT INTO TechOutputSplit VALUES ('shungnak',2040,'GHYD_01','ELC',1.0,'Hydro output is electricity');
INSERT INTO TechOutputSplit VALUES ('shungnak',2045,'GHYD_01','ELC',1.0,'Hydro output is electricity');
INSERT INTO TechOutputSplit VALUES ('shungnak',2030,'GWND_01','ELC',1.0,'Wind output is electricity');
INSERT INTO TechOutputSplit VALUES ('shungnak',2035,'GWND_01','ELC',1.0,'Wind output is electricity');
INSERT INTO TechOutputSplit VALUES ('shungnak',2040,'GWND_01','ELC',1.0,'Wind output is electricity');
INSERT INTO TechOutputSplit VALUES ('shungnak',2045,'GWND_01','ELC',1.0,'Wind output is electricity');
-- ELECT (bookkeeping tech) to ELECD
INSERT INTO TechOutputSplit VALUES ('shungnak',2030,'ELECT','ELECD',1.0,'pass-through to delivered electricity');
INSERT INTO TechOutputSplit VALUES ('shungnak',2035,'ELECT','ELECD',1.0,'pass-through to delivered electricity');
INSERT INTO TechOutputSplit VALUES ('shungnak',2040,'ELECT','ELECD',1.0,'pass-through to delivered electricity');
INSERT INTO TechOutputSplit VALUES ('shungnak',2045,'ELECT','ELECD',1.0,'pass-through to delivered electricity');
-- IMPORTS produce their primary resource
INSERT INTO TechOutputSplit VALUES ('shungnak',2030,'IMP_DSL','DSL',1.0,'imported diesel commodity');
INSERT INTO TechOutputSplit VALUES ('shungnak',2035,'IMP_DSL','DSL',1.0,'imported diesel commodity');
INSERT INTO TechOutputSplit VALUES ('shungnak',2040,'IMP_DSL','DSL',1.0,'imported diesel commodity');
INSERT INTO TechOutputSplit VALUES ('shungnak',2045,'IMP_DSL','DSL',1.0,'imported diesel commodity');
INSERT INTO TechOutputSplit VALUES ('shungnak',2030,'IMP_SOL','SOL',1.0,'imported solar resource');
INSERT INTO TechOutputSplit VALUES ('shungnak',2035,'IMP_SOL','SOL',1.0,'imported solar resource');
INSERT INTO TechOutputSplit VALUES ('shungnak',2040,'IMP_SOL','SOL',1.0,'imported solar resource');
INSERT INTO TechOutputSplit VALUES ('shungnak',2045,'IMP_SOL','SOL',1.0,'imported solar resource');
INSERT INTO TechOutputSplit VALUES ('shungnak',2030,'IMP_HYD','HYD',1.0,'imported hydro resource');
INSERT INTO TechOutputSplit VALUES ('shungnak',2035,'IMP_HYD','HYD',1.0,'imported hydro resource');
INSERT INTO TechOutputSplit VALUES ('shungnak',2040,'IMP_HYD','HYD',1.0,'imported hydro resource');
INSERT INTO TechOutputSplit VALUES ('shungnak',2045,'IMP_HYD','HYD',1.0,'imported hydro resource');
INSERT INTO TechOutputSplit VALUES ('shungnak',2030,'IMP_WND','WND',1.0,'imported wind resource');
INSERT INTO TechOutputSplit VALUES ('shungnak',2035,'IMP_WND','WND',1.0,'imported wind resource');
INSERT INTO TechOutputSplit VALUES ('shungnak',2040,'IMP_WND','WND',1.0,'imported wind resource');
INSERT INTO TechOutputSplit VALUES ('shungnak',2045,'IMP_WND','WND',1.0,'imported wind resource');
-- BATTERY to ELC
INSERT INTO TechOutputSplit VALUES ('shungnak',2030,'EBATT_01','ELC',1.0,'Battery discharge');
INSERT INTO TechOutputSplit VALUES ('shungnak',2035,'EBATT_01','ELC',1.0,'Battery discharge');
INSERT INTO TechOutputSplit VALUES ('shungnak',2040,'EBATT_01','ELC',1.0,'Battery discharge');
INSERT INTO TechOutputSplit VALUES ('shungnak',2045,'EBATT_01','ELC',1.0,'Battery discharge');
CREATE TABLE TimeOfDay
(
    sequence INTEGER UNIQUE,
    tod      TEXT
        PRIMARY KEY
);
INSERT INTO TimeOfDay VALUES (1,'0'); 
INSERT INTO TimeOfDay VALUES (2,'1'); 
INSERT INTO TimeOfDay VALUES (3,'2'); 
INSERT INTO TimeOfDay VALUES (4,'3'); 
INSERT INTO TimeOfDay VALUES (5,'4'); 
INSERT INTO TimeOfDay VALUES (6,'5'); 
INSERT INTO TimeOfDay VALUES (7,'6'); 
INSERT INTO TimeOfDay VALUES (8,'7'); 
INSERT INTO TimeOfDay VALUES (9,'8'); 
INSERT INTO TimeOfDay VALUES (10,'9'); 
INSERT INTO TimeOfDay VALUES (11,'10'); 
INSERT INTO TimeOfDay VALUES (12,'11'); 
INSERT INTO TimeOfDay VALUES (13,'12'); 
INSERT INTO TimeOfDay VALUES (14,'13'); 
INSERT INTO TimeOfDay VALUES (15,'14'); 
INSERT INTO TimeOfDay VALUES (16,'15'); 
INSERT INTO TimeOfDay VALUES (17,'16'); 
INSERT INTO TimeOfDay VALUES (18,'17'); 
INSERT INTO TimeOfDay VALUES (19,'18'); 
INSERT INTO TimeOfDay VALUES (20,'19'); 
INSERT INTO TimeOfDay VALUES (21,'20'); 
INSERT INTO TimeOfDay VALUES (22,'21'); 
INSERT INTO TimeOfDay VALUES (23,'22'); 
INSERT INTO TimeOfDay VALUES (24,'23'); 
CREATE TABLE TimePeriod
(
    sequence INTEGER UNIQUE,
    period   INTEGER
        PRIMARY KEY,
    flag     TEXT
        REFERENCES TimePeriodType (label)
);
INSERT INTO TimePeriod VALUES (1,2025,'e');
INSERT INTO TimePeriod VALUES (2,2030,'f');
INSERT INTO TimePeriod VALUES (3,2035,'f');
INSERT INTO TimePeriod VALUES (4,2040,'f');
INSERT INTO TimePeriod VALUES (5,2045,'f');
INSERT INTO TimePeriod VALUES (6,2050,'f');
CREATE TABLE TimeSeason
(
    sequence INTEGER UNIQUE,
    season   TEXT
        PRIMARY KEY
);
INSERT INTO TimeSeason VALUES (1,'spring');
INSERT INTO TimeSeason VALUES (2,'summer');
INSERT INTO TimeSeason VALUES (3,'fall');
INSERT INTO TimeSeason VALUES (4,'winter');
CREATE TABLE TimePeriodType
(
    label       TEXT
        PRIMARY KEY,
    description TEXT
);
INSERT INTO TimePeriodType VALUES('e','existing vintages');
INSERT INTO TimePeriodType VALUES('f','future');
CREATE TABLE MaxActivityShare
(
    region         TEXT,
    period         INTEGER
        REFERENCES TimePeriod (period),
    tech           TEXT
        REFERENCES Technology (tech),
    group_name     TEXT
        REFERENCES TechGroup (group_name),
    max_proportion REAL,
    notes          TEXT,
    PRIMARY KEY (region, period, tech, group_name)
);
CREATE TABLE MaxCapacityShare
(
    region         TEXT,
    period         INTEGER
        REFERENCES TimePeriod (period),
    tech           TEXT
        REFERENCES Technology (tech),
    group_name     TEXT
        REFERENCES TechGroup (group_name),
    max_proportion REAL,
    notes          TEXT,
    PRIMARY KEY (region, period, tech, group_name)
);
CREATE TABLE MaxAnnualCapacityFactor
(
    region      TEXT,
    period      INTEGER
        REFERENCES TimePeriod (period),
    tech        TEXT
        REFERENCES Technology (tech),
    output_comm TEXT
        REFERENCES Commodity (name),
    factor      REAL,
    source      TEXT,
    notes       TEXT,
    PRIMARY KEY (region, period, tech),
    CHECK (factor >= 0 AND factor <= 1)
);
CREATE TABLE MaxNewCapacity
(
    region  TEXT,
    period  INTEGER
        REFERENCES TimePeriod (period),
    tech    TEXT
        REFERENCES Technology (tech),
    max_cap REAL,
    units   TEXT,
    notes   TEXT,
    PRIMARY KEY (region, period, tech)
);
-- DIESEL:Allow replacements in future periods
-- GDSL_01 (Main Genset)
INSERT INTO MaxNewCapacity VALUES ('shungnak',2030,'GDSL_01',505,'kW','Replacement-sized cap matching existing unit');
INSERT INTO MaxNewCapacity VALUES ('shungnak',2035,'GDSL_01',505,'kW','Replacement-sized cap matching existing unit');
INSERT INTO MaxNewCapacity VALUES ('shungnak',2040,'GDSL_01',505,'kW','Replacement-sized cap matching existing unit');
INSERT INTO MaxNewCapacity VALUES ('shungnak',2045,'GDSL_01',505,'kW','Replacement-sized cap matching existing unit');
-- GDSL_02 (Secondary Genset)
INSERT INTO MaxNewCapacity VALUES ('shungnak',2030,'GDSL_02',363,'kW','Replacement-sized cap matching existing unit');
INSERT INTO MaxNewCapacity VALUES ('shungnak',2035,'GDSL_02',363,'kW','Replacement-sized cap matching existing unit');
INSERT INTO MaxNewCapacity VALUES ('shungnak',2040,'GDSL_02',363,'kW','Replacement-sized cap matching existing unit');
INSERT INTO MaxNewCapacity VALUES ('shungnak',2045,'GDSL_02',363,'kW','Replacement-sized cap matching existing unit');
-- GDSL_03 (Main Genset)
INSERT INTO MaxNewCapacity VALUES ('shungnak',2030,'GDSL_03',505,'kW','Replacement-sized cap matching existing unit');
INSERT INTO MaxNewCapacity VALUES ('shungnak',2035,'GDSL_03',505,'kW','Replacement-sized cap matching existing unit');
INSERT INTO MaxNewCapacity VALUES ('shungnak',2040,'GDSL_03',505,'kW','Replacement-sized cap matching existing unit');
INSERT INTO MaxNewCapacity VALUES ('shungnak',2045,'GDSL_03',505,'kW','Replacement-sized cap matching existing unit');
-- SOLAR
INSERT INTO MaxNewCapacity VALUES ('shungnak',2030,'GSOL_01',250,'kW','Logistical limit: ~250kW install per summer');
INSERT INTO MaxNewCapacity VALUES ('shungnak',2035,'GSOL_01',250,'kW','Logistical limit');
INSERT INTO MaxNewCapacity VALUES ('shungnak',2040,'GSOL_01',250,'kW','Logistical limit');
INSERT INTO MaxNewCapacity VALUES ('shungnak',2045,'GSOL_01',250,'kW','Logistical limit');
-- BATTERY
INSERT INTO MaxNewCapacity VALUES ('shungnak',2030,'EBATT_01',250,'kW','1 container per period');
INSERT INTO MaxNewCapacity VALUES ('shungnak',2035,'EBATT_01',250,'kW','1 container per period');
INSERT INTO MaxNewCapacity VALUES ('shungnak',2040,'EBATT_01',250,'kW','1 container per period');
INSERT INTO MaxNewCapacity VALUES ('shungnak',2045,'EBATT_01',250,'kW','1 container per period');
-- WIND
INSERT INTO MaxNewCapacity VALUES ('shungnak',2030,'GWND_01',200,'kW','2 40m ATB Commercial DW - Class 1 turbine per period');
INSERT INTO MaxNewCapacity VALUES ('shungnak',2035,'GWND_01',200,'kW','2 40m ATB Commercial DW - Class 1 turbine per period');
INSERT INTO MaxNewCapacity VALUES ('shungnak',2040,'GWND_01',200,'kW','2 40m ATB Commercial DW - Class 1 turbine per period');
INSERT INTO MaxNewCapacity VALUES ('shungnak',2045,'GWND_01',200,'kW','2 40m ATB Commercial DW - Class 1 turbine per period');
-- HYDRO
INSERT INTO MaxNewCapacity VALUES ('shungnak',2030,'GHYD_01',144,'kW','Small intake additions');
INSERT INTO MaxNewCapacity VALUES ('shungnak',2035,'GHYD_01',144,'kW','Small intake additions');
INSERT INTO MaxNewCapacity VALUES ('shungnak',2040,'GHYD_01',144,'kW','Small intake additions');
INSERT INTO MaxNewCapacity VALUES ('shungnak',2045,'GHYD_01',144,'kW','Small intake additions');
CREATE TABLE MaxNewCapacityGroup
(
    region      TEXT,
    period      INTEGER
        REFERENCES TimePeriod (period),
    group_name  TEXT
        REFERENCES TechGroup (group_name),
    max_new_cap REAL,
    units       TEXT,
    notes       TEXT,
    PRIMARY KEY (region, period, group_name)
);
CREATE TABLE MaxNewCapacityShare
(
    region         TEXT,
    period         INTEGER
        REFERENCES TimePeriod (period),
    tech           TEXT
        REFERENCES Technology (tech),
    group_name     TEXT
        REFERENCES TechGroup (group_name),
    max_proportion REAL,
    notes          TEXT,
    PRIMARY KEY (region, period, tech, group_name)
);
CREATE TABLE MinActivityShare
(
    region         TEXT,
    period         INTEGER
        REFERENCES TimePeriod (period),
    tech           TEXT
        REFERENCES Technology (tech),
    group_name     TEXT
        REFERENCES TechGroup (group_name),
    min_proportion REAL,
    notes          TEXT,
    PRIMARY KEY (region, period, tech, group_name)
);
CREATE TABLE MinAnnualCapacityFactor
(
    region      TEXT,
    period      INTEGER
        REFERENCES TimePeriod (period),
    tech        TEXT
        REFERENCES Technology (tech),
    output_comm TEXT
        REFERENCES Commodity (name),
    factor      REAL,
    source      TEXT,
    notes       TEXT,
    PRIMARY KEY (region, period, tech),
    CHECK (factor >= 0 AND factor <= 1)
);
CREATE TABLE MinCapacityShare
(
    region         TEXT,
    period         INTEGER
        REFERENCES TimePeriod (period),
    tech           TEXT
        REFERENCES Technology (tech),
    group_name     TEXT
        REFERENCES TechGroup (group_name),
    min_proportion REAL,
    notes          TEXT,
    PRIMARY KEY (region, period, tech, group_name)
);
CREATE TABLE MinNewCapacity
(
    region  TEXT,
    period  INTEGER
        REFERENCES TimePeriod (period),
    tech    TEXT
        REFERENCES Technology (tech),
    min_cap REAL,
    units   TEXT,
    notes   TEXT,
    PRIMARY KEY (region, period, tech)
);
CREATE TABLE MinNewCapacityGroup
(
    region      TEXT,
    period      INTEGER
        REFERENCES TimePeriod (period),
    group_name  TEXT
        REFERENCES TechGroup (group_name),
    min_new_cap REAL,
    units       TEXT,
    notes       TEXT,
    PRIMARY KEY (region, period, group_name)
);
CREATE TABLE MinNewCapacityShare
(
    region         TEXT,
    period         INTEGER
        REFERENCES TimePeriod (period),
    tech           TEXT
        REFERENCES Technology (tech),
    group_name     TEXT
        REFERENCES TechGroup (group_name),
    max_proportion REAL,
    notes          TEXT,
    PRIMARY KEY (region, period, tech, group_name)
);
CREATE TABLE OutputEmission
(
    scenario  TEXT,
    region    TEXT,
    sector    TEXT
        REFERENCES SectorLabel (sector),
    period    INTEGER
        REFERENCES TimePeriod (period),
    emis_comm TEXT
        REFERENCES Commodity (name),
    tech      TEXT
        REFERENCES Technology (tech),
    vintage   INTEGER
        REFERENCES TimePeriod (period),
    emission  REAL,
    PRIMARY KEY (region, scenario, period, emis_comm, tech, vintage)
);
CREATE TABLE MinActivityGroup
(
    region     TEXT,
    period     INTEGER
        REFERENCES TimePeriod (period),
    group_name TEXT
        REFERENCES TechGroup (group_name),
    min_act    REAL,
    units      TEXT,
    notes      TEXT,
    PRIMARY KEY (region, period, group_name)
);
CREATE TABLE EmissionLimit
(
    region    TEXT,
    period    INTEGER
        REFERENCES TimePeriod (period),
    emis_comm TEXT
        REFERENCES Commodity (name),
    value     REAL,
    units     TEXT,
    notes     TEXT,
    PRIMARY KEY (region, period, emis_comm)
);
CREATE TABLE MaxActivityGroup
(
    region     TEXT,
    period     INTEGER
        REFERENCES TimePeriod (period),
    group_name TEXT
        REFERENCES TechGroup (group_name),
    max_act    REAL,
    units      TEXT,
    notes      TEXT,
    PRIMARY KEY (region, period, group_name)
);
CREATE TABLE RPSRequirement
(
    region      TEXT    NOT NULL
        REFERENCES Region (region),
    period      INTEGER NOT NULL
        REFERENCES TimePeriod (period),
    tech_group  TEXT    NOT NULL
        REFERENCES TechGroup (group_name),
    requirement REAL    NOT NULL,
    notes       TEXT
);
CREATE TABLE TechGroupMember
(
    group_name TEXT
        REFERENCES TechGroup (group_name),
    tech       TEXT
        REFERENCES Technology (tech),
    PRIMARY KEY (group_name, tech)
);
CREATE TABLE Technology
(
    tech         TEXT    NOT NULL PRIMARY KEY,
    flag         TEXT    NOT NULL,
    sector       TEXT,
    category     TEXT,
    sub_category TEXT,
    unlim_cap    INTEGER NOT NULL DEFAULT 0,
    annual       INTEGER NOT NULL DEFAULT 0,
    reserve      INTEGER NOT NULL DEFAULT 0,
    curtail      INTEGER NOT NULL DEFAULT 0,
    retire       INTEGER NOT NULL DEFAULT 0,
    flex         INTEGER NOT NULL DEFAULT 0,
    variable     INTEGER NOT NULL DEFAULT 0,
    exchange     INTEGER NOT NULL DEFAULT 0,
    description  TEXT,
    FOREIGN KEY (flag) REFERENCES TechnologyType (label)
);
INSERT INTO Technology VALUES('IMP_DSL','r','supply','petroleum','',1,0,0,0,0,0,0,0,' imported diesel');
INSERT INTO Technology VALUES('IMP_HYD','r','supply','hydro','',1,0,0,0,0,0,0,0,' imported water, doesnt exist in shungnak');
INSERT INTO Technology VALUES('IMP_SOL','r','supply','solar','',1,0,0,0,0,0,0,0,' imported solar');
INSERT INTO Technology VALUES('IMP_WND','r','supply','wind','',1,0,0,0,0,0,0,0,' imported wind');
INSERT INTO Technology VALUES('ELECT','p','electric','petroleum','',0,0,0,0,0,0,0,0,' general purpose electricity');
INSERT INTO Technology VALUES('GDSL_01','p','electric','petroleum','',0,0,0,0,0,0,0,0,' Caterpillar 3456, 505 kW');
INSERT INTO Technology VALUES('GDSL_02','p','electric','petroleum','',0,0,0,0,0,0,0,0,' Caterpillar 3406B, 363 kW');
INSERT INTO Technology VALUES('GDSL_03','p','electric','petroleum','',0,0,0,0,0,0,0,0,' Caterpillar 3456, 505 kW');
INSERT INTO Technology VALUES('GSOL_01','p','electric','solar','',0,0,0,0,0,0,0,0,' ANRI,SolarEdge inverter, bifacial 186.3 kW owned by shungnak)');
INSERT INTO Technology VALUES('GHYD_01','p','electric','hydro','',0,0,0,0,0,0,0,0,' small hydro plant power - Non existing');
INSERT INTO Technology VALUES('GWND_01','p','electric','wind','',0,0,0,0,0,0,0,0,' wind plant around 500 kW - Non existing');
INSERT INTO Technology VALUES('EBATT_01','ps','electric','storage','battery',0,0,0,0,0,0,0,0,' Blue Planet Blue Ion 2.0 BESS (384 kWh / 250 kW), EPC PD-250 converter, Ageto ARC controller');
CREATE TABLE OutputCost
(
    scenario TEXT,
    region   TEXT,
    period   INTEGER,
    tech     TEXT,
    vintage  INTEGER,
    d_invest REAL,
    d_fixed  REAL,
    d_var    REAL,
    d_emiss  REAL,
    invest   REAL,
    fixed    REAL,
    var      REAL,
    emiss    REAL,
    PRIMARY KEY (scenario, region, period, tech, vintage),
    FOREIGN KEY (vintage) REFERENCES TimePeriod (period),
    FOREIGN KEY (tech) REFERENCES Technology (tech)
);
COMMIT;

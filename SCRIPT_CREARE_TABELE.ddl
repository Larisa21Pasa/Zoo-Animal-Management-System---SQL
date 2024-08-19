-- Generated by Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   at:        2022-12-12 21:07:18 EET
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE animal_info (
    id_animals NUMBER(3) NOT NULL,
    name       VARCHAR2(50) NOT NULL,
    birth_date DATE NOT NULL,
    gender     VARCHAR2(20) NOT NULL
);

ALTER TABLE animal_info
    ADD CONSTRAINT animal_info_name_ck CHECK ( REGEXP_LIKE ( name,
                                                             '^[a-zA-Z_ ]*$' ) );

ALTER TABLE animal_info
    ADD CHECK ( gender IN ( 'Female', 'Male' ) );

COMMENT ON TABLE animal_info IS
    'general info about animal and its life';

ALTER TABLE animal_info ADD CONSTRAINT animals_id_animals_uk PRIMARY KEY ( id_animals );

CREATE TABLE animal_pen (
    id_animal_pen NUMBER(2) NOT NULL,
    name_pen      VARCHAR2(50) NOT NULL
);

ALTER TABLE animal_pen
    ADD CONSTRAINT animal_pen_name_pen_ck CHECK ( REGEXP_LIKE ( name_pen,
                                                                '^[a-zA-Z_ ]*$' ) );

COMMENT ON TABLE animal_pen IS
    'records of places where animals live';

ALTER TABLE animal_pen ADD CONSTRAINT animal_pen_pk PRIMARY KEY ( id_animal_pen );

ALTER TABLE animal_pen ADD CONSTRAINT animal_pen_name_pen_uk UNIQUE ( name_pen );

CREATE TABLE animal_type (
    id_animal_type NUMBER(2) NOT NULL,
    type_animal    VARCHAR2(50) NOT NULL
);

ALTER TABLE animal_type
    ADD CHECK ( type_animal IN ( 'Arachnids', 'Bird', 'Canine', 'Feline', 'Fish',
                                 'Insect', 'Reptiles', 'Rodent' ) );

COMMENT ON TABLE animal_type IS
    'generic type of animals wich help to identify characteristics of an animal';

ALTER TABLE animal_type ADD CONSTRAINT animal_type_pk PRIMARY KEY ( id_animal_type );

ALTER TABLE animal_type ADD CONSTRAINT animaltype_typeanimal_uk UNIQUE ( type_animal );

CREATE TABLE animals (
    id_animals     NUMBER(3) NOT NULL,
    id_animal_type NUMBER(2) NOT NULL,
    id_animal_pen  NUMBER(2) NOT NULL
);

COMMENT ON TABLE animals IS
    'main tabel where it is keeped id of animal and details about animal pen where it lives';

ALTER TABLE animals ADD CONSTRAINT animals_pk PRIMARY KEY ( id_animals );

CREATE TABLE diet (
    id_diet    NUMBER(5) NOT NULL,
    id_food    NUMBER(2) NOT NULL,
    id_animals NUMBER(3) NOT NULL,
    diet_type  VARCHAR2(20) NOT NULL,
    cantity    NUMBER(2) NOT NULL
);

ALTER TABLE diet
    ADD CONSTRAINT check_diet_type CHECK ( diet_type IN ( 'Carnivor', 'Erbivor', 'Omnivor' ) );

ALTER TABLE diet
    ADD CONSTRAINT diet_cantity_ck CHECK ( REGEXP_LIKE ( cantity,
                                                         '[+-]?([0-9]*[.])?[0-9]+' ) );

COMMENT ON TABLE diet IS
    'diet contains type of food and for what animal is it suitable for';

ALTER TABLE diet
    ADD CONSTRAINT diet_pk PRIMARY KEY ( id_diet,
                                         id_food,
                                         id_animals );

CREATE TABLE food (
    id_food   NUMBER(2) NOT NULL,
    food_type VARCHAR2(50) NOT NULL
);

ALTER TABLE food
    ADD CONSTRAINT food_food_type_ck CHECK ( REGEXP_LIKE ( food_type,
                                                           '^[a-zA-Z_ ]*$' ) );

COMMENT ON TABLE food IS
    'food actually contains types of food available for animals';

ALTER TABLE food ADD CONSTRAINT food_pk PRIMARY KEY ( id_food );

CREATE TABLE medical_info (
    id_medical_info   NUMBER(2) NOT NULL,
    id_animals        NUMBER(3) NOT NULL,
    data_registration DATE NOT NULL,
    birth_date        DATE NOT NULL,
    children          VARCHAR2(5) NOT NULL,
    surgery           VARCHAR2(50) NOT NULL,
    medication        VARCHAR2(50) NOT NULL
);

ALTER TABLE medical_info
    ADD CHECK ( children IN ( 'No', 'Yes' ) );

COMMENT ON TABLE medical_info IS
    'contains records about medical life of animals to let employees know how every animal is feeling';

ALTER TABLE medical_info ADD CONSTRAINT medical_info_pk PRIMARY KEY ( id_medical_info );

ALTER TABLE animals
    ADD CONSTRAINT animal_pen_animals_fk FOREIGN KEY ( id_animal_pen )
        REFERENCES animal_pen ( id_animal_pen );

ALTER TABLE animals
    ADD CONSTRAINT animal_type_animals_fk FOREIGN KEY ( id_animal_type )
        REFERENCES animal_type ( id_animal_type );

ALTER TABLE animal_info
    ADD CONSTRAINT animals_animal_info FOREIGN KEY ( id_animals )
        REFERENCES animals ( id_animals );

ALTER TABLE diet
    ADD CONSTRAINT animals_diet_fk FOREIGN KEY ( id_animals )
        REFERENCES animals ( id_animals );

ALTER TABLE medical_info
    ADD CONSTRAINT animals_medical_info_fk FOREIGN KEY ( id_animals )
        REFERENCES animals ( id_animals );

ALTER TABLE diet
    ADD CONSTRAINT food_diet_fk FOREIGN KEY ( id_food )
        REFERENCES food ( id_food );

CREATE SEQUENCE animal_info_id_animals_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER animal_info_id_animals_trg BEFORE
    INSERT ON animal_info
    FOR EACH ROW
    WHEN ( new.id_animals IS NULL )
BEGIN
    :new.id_animals := animal_info_id_animals_seq.nextval;
END;
/

CREATE SEQUENCE animal_pen_id_animal_pen_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER animal_pen_id_animal_pen_trg BEFORE
    INSERT ON animal_pen
    FOR EACH ROW
    WHEN ( new.id_animal_pen IS NULL )
BEGIN
    :new.id_animal_pen := animal_pen_id_animal_pen_seq.nextval;
END;
/

CREATE SEQUENCE animal_type_id_animal_type_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER animal_type_id_animal_type_trg BEFORE
    INSERT ON animal_type
    FOR EACH ROW
    WHEN ( new.id_animal_type IS NULL )
BEGIN
    :new.id_animal_type := animal_type_id_animal_type_seq.nextval;
END;
/

CREATE SEQUENCE animals_id_animals_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER animals_id_animals_trg BEFORE
    INSERT ON animals
    FOR EACH ROW
    WHEN ( new.id_animals IS NULL )
BEGIN
    :new.id_animals := animals_id_animals_seq.nextval;
END;
/

CREATE SEQUENCE diet_id_diet_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER diet_id_diet_trg BEFORE
    INSERT ON diet
    FOR EACH ROW
    WHEN ( new.id_diet IS NULL )
BEGIN
    :new.id_diet := diet_id_diet_seq.nextval;
END;
/

CREATE SEQUENCE food_id_food_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER food_id_food_trg BEFORE
    INSERT ON food
    FOR EACH ROW
    WHEN ( new.id_food IS NULL )
BEGIN
    :new.id_food := food_id_food_seq.nextval;
END;
/

CREATE SEQUENCE medical_info_id_medical_info START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER medical_info_id_medical_info BEFORE
    INSERT ON medical_info
    FOR EACH ROW
    WHEN ( new.id_medical_info IS NULL )
BEGIN
    :new.id_medical_info := medical_info_id_medical_info.nextval;
END;
/



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                             7
-- CREATE INDEX                             0
-- ALTER TABLE                             23
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           7
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          7
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0

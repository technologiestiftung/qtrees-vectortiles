-- DROP SCHEMA IF EXISTS "api" CASCADE;
CREATE EXTENSION postgis;

CREATE SCHEMA "api";

SET search_path TO "api", public;

-- DROP TABLE IF EXISTS "api"."trees";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.
-- Table Definition
CREATE TABLE "api"."trees" (
    "gml_id" text NOT NULL,
    "baumid" text,
    "standortnr" text,
    "kennzeich" text,
    "namenr" text,
    "art_dtsch" text,
    "art_bot" text,
    "gattung_deutsch" text,
    "gattung" text,
    "strname" text,
    "hausnr" text,
    "pflanzjahr" float8,
    "standalter" float8,
    "stammumfg" float8,
    "baumhoehe" float8,
    "bezirk" text,
    "eigentuemer" text,
    "zusatz" text,
    "kronedurch" float8,
    "geometry" geometry(point, 4326),
    "lat" float8,
    "lng" float8,
    "created_at" date,
    "updated_at" date,
    PRIMARY KEY ("gml_id")
);

INSERT INTO "api"."trees" ("gml_id", "baumid", "standortnr", "kennzeich", "namenr", "art_dtsch", "art_bot", "gattung_deutsch", "gattung", "strname", "hausnr", "pflanzjahr", "standalter", "stammumfg", "baumhoehe", "bezirk", "eigentuemer", "zusatz", "kronedurch", "geometry", "lat", "lng", "created_at", "updated_at")
    VALUES ('s_wfs_baumbestand_an.00008100:0022e7ba', '00008100:0022e7ba', '1', '124620', 'Eichendorffstr. Plansche', 'Gemeine Rosskastanie', 'Aesculus hippocastanum', 'ROSSKASTANIE', 'AESCULUS', NULL, NULL, 1964, 58, 130, 17, 'Mitte', 'Land Berlin', NULL, 14, 'SRID=4326;POINT(13.38877338434219 52.5308102068711)', 52.5308102068711, 13.38877338434219, '2022-06-12', '2022-06-12'), ('s_wfs_baumbestand_an.00008100:0022e7bb', '00008100:0022e7bb', '2', '124620', 'Eichendorffstr. Plansche', 'Gemeine Rosskastanie', 'Aesculus hippocastanum', 'ROSSKASTANIE', 'AESCULUS', NULL, NULL, 1944, 78, 178, 17, 'Mitte', 'Land Berlin', NULL, 14, 'SRID=4326;POINT(13.38873233751835 52.53087611267273)', 52.53087611267273, 13.388732337518348, '2022-06-12', '2022-06-12'), ('s_wfs_baumbestand_an.00008100:0022e7bc', '00008100:0022e7bc', '3', '124620', 'Eichendorffstr. Plansche', 'Spitz-Ahorn', 'Acer platanoides', 'AHORN', 'ACER', NULL, NULL, 1955, 67, 151, 19, 'Mitte', 'Land Berlin', NULL, 22, 'SRID=4326;POINT(13.38865031307491 52.53085412488677)', 52.53085412488677, 13.388650313074912, '2022-06-12', '2022-06-12'), ('s_wfs_baumbestand_an.00008100:0022e7bd', '00008100:0022e7bd', '4', '124620', 'Eichendorffstr. Plansche', 'Gemeine Rosskastanie', 'Aesculus hippocastanum', 'ROSSKASTANIE', 'AESCULUS', NULL, NULL, 1939, 83, 191, 19, 'Mitte', 'Land Berlin', NULL, 15, 'SRID=4326;POINT(13.38867801183462 52.53079856410942)', 52.53079856410942, 13.38867801183462, '2022-06-12', '2022-06-12'), ('s_wfs_baumbestand_an.00008100:0022e7be', '00008100:0022e7be', '5', '124620', 'Eichendorffstr. Plansche', 'Berg-Ahorn, Weiss-Ahorn', 'Acer pseudoplatanus', 'AHORN', 'ACER', NULL, NULL, 1948, 74, 169, 19, 'Mitte', 'Land Berlin', NULL, 17, 'SRID=4326;POINT(13.38856113475891 52.53085188561268)', 52.53085188561268, 13.388561134758913, '2022-06-12', '2022-06-12'), ('s_wfs_baumbestand_an.00008100:0022e7f8', '00008100:0022e7f8', '6', '124620', 'Eichendorffstr. Plansche', 'Berg-Ahorn, Weiss-Ahorn', 'Acer pseudoplatanus', 'AHORN', 'ACER', NULL, NULL, 1969, 53, 116, 17, 'Mitte', 'Land Berlin', NULL, 16, 'SRID=4326;POINT(13.38848230100409 52.5308875541159)', 52.5308875541159, 13.38848230100409, '2022-06-12', '2022-06-12'), ('s_wfs_baumbestand_an.00008100:0022e7fa', '00008100:0022e7fa', '7', '124620', 'Eichendorffstr. Plansche', 'Schwarz-Pappel', 'Populus nigra', 'PAPPEL', 'POPULUS', NULL, NULL, 1933, 89, 166, 22, 'Mitte', 'Land Berlin', NULL, 18, 'SRID=4326;POINT(13.38850586911777 52.53075290654783)', 52.53075290654783, 13.388505869117774, '2022-06-12', '2022-06-12'), ('s_wfs_baumbestand_an.00008100:0022e7fb', '00008100:0022e7fb', '8', '124620', 'Eichendorffstr. Plansche', 'Schwarz-Pappel', 'Populus nigra', 'PAPPEL', 'POPULUS', NULL, NULL, 1923, 99, 186, 22, 'Mitte', 'Land Berlin', NULL, 16, 'SRID=4326;POINT(13.3883570655577 52.53073469083389)', 52.53073469083389, 13.388357065557702, '2022-06-12', '2022-06-12'), ('s_wfs_baumbestand_an.00008100:0022e7fc', '00008100:0022e7fc', '9', '124620', 'Eichendorffstr. Plansche', 'Amerikanische Rot-Eiche', 'Quercus rubra', 'EICHE', 'QUERCUS', NULL, NULL, 1947, 75, 172, 20, 'Mitte', 'Land Berlin', NULL, 15, 'SRID=4326;POINT(13.38828249300369 52.53083347698578)', 52.53083347698578, 13.388282493003686, '2022-06-12', '2022-06-12'), ('s_wfs_baumbestand_an.00008100:0022e7ff', '00008100:0022e7ff', '10', '124620', 'Eichendorffstr. Plansche', 'Sand-Birke', 'Betula pendula', 'BIRKE', 'BETULA', NULL, NULL, 1960, 62, 140, 21, 'Mitte', 'Land Berlin', NULL, 16, 'SRID=4326;POINT(13.38816687591993 52.53090189418158)', 52.530901894181575, 13.388166875919925, '2022-06-12', '2022-06-12');


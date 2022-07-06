CREATE EXTENSION postgis;

CREATE SCHEMA api;

-- -------------------------------------------------------------
-- TablePlus 4.7.2(430)
--
-- https://tableplus.com/
--
-- Database: qtrees
-- Generation Time: 2022-07-06 12:14:41.5880
-- -------------------------------------------------------------
DROP TABLE IF EXISTS "api"."forecast";

-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.
-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS api.forecast_id_seq;

-- Table Definition
CREATE TABLE "api"."forecast" (
    "id" int4 NOT NULL DEFAULT nextval('api.forecast_id_seq'::regclass),
    "baum_id" text,
    "type_id" int2,
    "timestamp" timestamp,
    "value" float8,
    "created_at" timestamp,
    "model_id" text,
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "api"."forecast_types";

-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.
-- Table Definition
CREATE TABLE "api"."forecast_types" (
    "id" int2 NOT NULL,
    "name" text NOT NULL,
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "api"."nowcast";

-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.
-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS api.nowcast_id_seq;

-- Table Definition
CREATE TABLE "api"."nowcast" (
    "id" int4 NOT NULL DEFAULT nextval('api.nowcast_id_seq'::regclass),
    "baum_id" text,
    "type_id" int2,
    "timestamp" timestamp,
    "value" float8,
    "created_at" timestamp,
    "model_id" text,
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "api"."radolan";

-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.
-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS api.radolan_id_seq;

-- Table Definition
CREATE TABLE "api"."radolan" (
    "id" int4 NOT NULL DEFAULT nextval('api.radolan_id_seq'::regclass),
    "rainfall_mm" float8,
    "geometry" geometry(polygon, 4326),
    "timestamp" timestamp,
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "api"."shading";

-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.
-- Table Definition
CREATE TABLE "api"."shading" (
    "gml_id" text NOT NULL,
    "month" int2 NOT NULL,
    "index" float8,
    PRIMARY KEY ("gml_id", "month")
);

DROP TABLE IF EXISTS "api"."soil";

-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.
-- Table Definition
CREATE TABLE "api"."soil" (
    "gml_id" text,
    "schl5" int8,
    "nutz" float8,
    "nutz_bez" text,
    "vgradstufe" float8,
    "vgradstufe_bez" text,
    "boges_neu5" float8,
    "btyp" text,
    "bg_alt" text,
    "nutzgenese" text,
    "ausgangsm" text,
    "geomeinh" float8,
    "geomeinh_bez" text,
    "aus_bg" float8,
    "aus_bg_bez" text,
    "antro_bg" float8,
    "antro_bg_bez" text,
    "torf_bg" float8,
    "torf_bg_bez" text,
    "torf_klas" float8,
    "flur" float8,
    "flurstufe" float8,
    "flurstufe_bez" text,
    "flurklasse" float8,
    "flurklasse_bez" text,
    "bnbg_ob_h" text,
    "bnbg_ob_h_bez" text,
    "bnbg_ub_h" text,
    "bnbg_ub_h_bez" text,
    "bnbg_ob" text,
    "bngb_ob_bez" text,
    "bnbg_ub" text,
    "bnbg_ub_bez" text,
    "bart_gr" float8,
    "sg_ob" text,
    "sg_ob_bez" text,
    "sg_ub" text,
    "sg_ub_bez" text,
    "sg_klas" float8,
    "sg_klas_bez" text,
    "btyp_ka3" text,
    "btyp_ka3_bez" text,
    "btyp_ka4" text,
    "btyp_ka4_bez" text,
    "bform_ka5" text,
    "bform_ka5_bez" text,
    "torf_ob" text,
    "torf_ob_bez" text,
    "torf_klas_bez" text,
    "torf_ub" text,
    "torf_ub_bez" text,
    "geometry" geometry(MultiPolygon, 4326),
    "created_at" date,
    "updated_at" date
);

DROP TABLE IF EXISTS "api"."trees";

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

DROP TABLE IF EXISTS "api"."user_info";

-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.
-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS api.user_info_id_seq;

-- Table Definition
CREATE TABLE "api"."user_info" (
    "id" int4 NOT NULL DEFAULT nextval('api.user_info_id_seq'::regclass),
    "gml_id" text,
    "nutzer_id" text,
    "merkmal" text,
    "wert" text,
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "api"."weather";

-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.
-- Table Definition
CREATE TABLE "api"."weather" (
    "stations_id" int8 NOT NULL,
    "mess_datum" timestamp NOT NULL,
    "qn_3" int8,
    "fx" float8,
    "fm" float8,
    "qn_4" int8,
    "rsk" float8,
    "rskf" int8,
    "sdk" float8,
    "shk_tag" int8,
    "nm" int8,
    "vpm" float8,
    "pm" float8,
    "tmk" float8,
    "upm" float8,
    "txk" float8,
    "tnk" float8,
    "tgk" float8,
    PRIMARY KEY ("stations_id", "mess_datum")
);

DROP TABLE IF EXISTS "api"."weather_stations";

-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.
-- Table Definition
CREATE TABLE "api"."weather_stations" (
    "stations_id" int8 NOT NULL,
    "von_datum" date,
    "bis_datum" date,
    "stationshoehe" int8,
    "geobreite" float8,
    "geolaenge" float8,
    "stationsname" text,
    "bundesland" text,
    "geometry" geometry(point, 4326),
    PRIMARY KEY ("stations_id")
);

ALTER TABLE "api"."forecast"
    ADD FOREIGN KEY ("baum_id") REFERENCES "api"."trees" ("gml_id");

ALTER TABLE "api"."forecast"
    ADD FOREIGN KEY ("type_id") REFERENCES "api"."forecast_types" ("id");

ALTER TABLE "api"."nowcast"
    ADD FOREIGN KEY ("baum_id") REFERENCES "api"."trees" ("gml_id");

ALTER TABLE "api"."nowcast"
    ADD FOREIGN KEY ("type_id") REFERENCES "api"."forecast_types" ("id");

ALTER TABLE "api"."shading"
    ADD FOREIGN KEY ("gml_id") REFERENCES "api"."trees" ("gml_id");

ALTER TABLE "api"."user_info"
    ADD FOREIGN KEY ("gml_id") REFERENCES "api"."trees" ("gml_id");


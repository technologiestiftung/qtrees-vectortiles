-- This schema ddoes not refelct the whole setup. It only contains the api schema. The other schemas are created documented here
-- CREATE EXTENSION postgis;

-- CREATE EXTENSION fuzzystrmatch;

-- CREATE EXTENSION postgis_tiger_geocoder;

-- CREATE EXTENSION postgis_topology;

CREATE SCHEMA IF NOT EXISTS "api";

CREATE SEQUENCE "api"."forecast_id_seq";

CREATE SEQUENCE "api"."nowcast_id_seq";

CREATE SEQUENCE "api"."radolan_id_seq";

CREATE TABLE "api"."forecast" (
	"id" integer NOT NULL DEFAULT nextval('api.forecast_id_seq'::regclass),
	"tree_id" text,
	"forecast_type_id" smallint,
	"timestamp" timestamp without time zone,
	"value" double precision,
	"created_at" timestamp without time zone,
	"model_id" text
);

CREATE TABLE "api"."forecast_types" (
	"id" smallint NOT NULL,
	"name" text NOT NULL
);

CREATE TABLE "api"."issue_types" (
	"id" integer NOT NULL,
	"title" text NOT NULL,
	"description" text NOT NULL,
	"image_url" text
);

CREATE TABLE "api"."issues" (
	"id" integer NOT NULL,
	"issue_type_id" integer NOT NULL,
	"created_at" timestamp with time zone NOT NULL DEFAULT now(),
	"gml_id" text NOT NULL
);

CREATE TABLE "api"."nowcast" (
	"id" integer NOT NULL DEFAULT nextval('api.nowcast_id_seq'::regclass),
	"tree_id" text,
	"forecast_type_id" smallint,
	"timestamp" timestamp without time zone,
	"value" double precision,
	"created_at" timestamp without time zone,
	"model_id" text
);

CREATE TABLE "api"."radolan" (
	"id" integer NOT NULL DEFAULT nextval('api.radolan_id_seq'::regclass),
	"rainfall_mm" double precision,
	"geometry" geometry(polygon, 4326),
	"timestamp" timestamp without time zone
);

CREATE TABLE "api"."shading" (
	"tree_id" text NOT NULL,
	"month" smallint NOT NULL,
	"index" double precision
);

CREATE TABLE "api"."soil" (
	"id" text NOT NULL,
	"schl5" bigint,
	"nutz" double precision,
	"nutz_bez" text,
	"vgradstufe" double precision,
	"vgradstufe_bez" text,
	"boges_neu5" double precision,
	"btyp" text,
	"bg_alt" text,
	"nutzgenese" text,
	"ausgangsm" text,
	"geomeinh" double precision,
	"geomeinh_bez" text,
	"aus_bg" double precision,
	"aus_bg_bez" text,
	"antro_bg" double precision,
	"antro_bg_bez" text,
	"torf_bg" double precision,
	"torf_bg_bez" text,
	"torf_klas" double precision,
	"flur" double precision,
	"flurstufe" double precision,
	"flurstufe_bez" text,
	"flurklasse" double precision,
	"flurklasse_bez" text,
	"bnbg_ob_h" text,
	"bnbg_ob_h_bez" text,
	"bnbg_ub_h" text,
	"bnbg_ub_h_bez" text,
	"bnbg_ob" text,
	"bngb_ob_bez" text,
	"bnbg_ub" text,
	"bnbg_ub_bez" text,
	"bart_gr" double precision,
	"sg_ob" text,
	"sg_ob_bez" text,
	"sg_ub" text,
	"sg_ub_bez" text,
	"sg_klas" double precision,
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

CREATE TABLE "api"."trees" (
	"id" text NOT NULL,
	"standortnr" text,
	"kennzeich" text,
	"namenr" text,
	"art_dtsch" text,
	"art_bot" text,
	"gattung_deutsch" text,
	"gattung" text,
	"strname" text,
	"hausnr" text,
	"pflanzjahr" double precision,
	"standalter" double precision,
	"stammumfg" double precision,
	"baumhoehe" double precision,
	"bezirk" text,
	"eigentuemer" text,
	"zusatz" text,
	"kronedurch" double precision,
	"geometry" geometry(point, 4326),
	"lat" double precision,
	"lng" double precision,
	"created_at" date,
	"updated_at" date,
	"street_tree" boolean
);

CREATE TABLE "api"."weather" (
	"stations_id" bigint,
	"mess_datum" timestamp without time zone,
	"qn_3" bigint,
	"fx" double precision,
	"fm" double precision,
	"qn_4" bigint,
	"rsk" double precision,
	"rskf" bigint,
	"sdk" double precision,
	"shk_tag" bigint,
	"nm" double precision,
	"vpm" double precision,
	"pm" double precision,
	"tmk" double precision,
	"upm" double precision,
	"txk" double precision,
	"tnk" double precision,
	"tgk" double precision,
	"eor" text
);

CREATE TABLE "api"."weather_stations" (
	"id" bigint NOT NULL,
	"von_datum" date,
	"bis_datum" date,
	"stationshoehe" bigint,
	"lat" double precision,
	"lon" double precision,
	"stationsname" text,
	"bundesland" text,
	"geometry" geometry(point, 4326)
);

ALTER SEQUENCE "api"."forecast_id_seq" owned BY "api"."forecast"."id";

ALTER SEQUENCE "api"."nowcast_id_seq" owned BY "api"."nowcast"."id";

ALTER SEQUENCE "api"."radolan_id_seq" owned BY "api"."radolan"."id";

CREATE UNIQUE INDEX forecast_pkey ON api.forecast USING btree (id);

CREATE UNIQUE INDEX forecast_types_pkey ON api.forecast_types USING btree (id);

CREATE UNIQUE INDEX issue_types_pkey ON api.issue_types USING btree (id);

CREATE UNIQUE INDEX issues_pkey ON api.issues USING btree (id);

CREATE UNIQUE INDEX nowcast_pkey ON api.nowcast USING btree (id);

CREATE UNIQUE INDEX radolan_pkey ON api.radolan USING btree (id);

CREATE UNIQUE INDEX shading_pkey ON api.shading USING btree (tree_id, month);

CREATE UNIQUE INDEX soil_pkey ON api.soil USING btree (id);

CREATE UNIQUE INDEX trees_pkey ON api.trees USING btree (id);

CREATE UNIQUE INDEX weather_stations_pkey ON api.weather_stations USING btree (id);

ALTER TABLE "api"."forecast"
	ADD CONSTRAINT "forecast_pkey" PRIMARY KEY USING INDEX "forecast_pkey";

ALTER TABLE "api"."forecast_types"
	ADD CONSTRAINT "forecast_types_pkey" PRIMARY KEY USING INDEX "forecast_types_pkey";

ALTER TABLE "api"."issue_types"
	ADD CONSTRAINT "issue_types_pkey" PRIMARY KEY USING INDEX "issue_types_pkey";

ALTER TABLE "api"."issues"
	ADD CONSTRAINT "issues_pkey" PRIMARY KEY USING INDEX "issues_pkey";

ALTER TABLE "api"."nowcast"
	ADD CONSTRAINT "nowcast_pkey" PRIMARY KEY USING INDEX "nowcast_pkey";

ALTER TABLE "api"."radolan"
	ADD CONSTRAINT "radolan_pkey" PRIMARY KEY USING INDEX "radolan_pkey";

ALTER TABLE "api"."shading"
	ADD CONSTRAINT "shading_pkey" PRIMARY KEY USING INDEX "shading_pkey";

ALTER TABLE "api"."soil"
	ADD CONSTRAINT "soil_pkey" PRIMARY KEY USING INDEX "soil_pkey";

ALTER TABLE "api"."trees"
	ADD CONSTRAINT "trees_pkey" PRIMARY KEY USING INDEX "trees_pkey";

ALTER TABLE "api"."weather_stations"
	ADD CONSTRAINT "weather_stations_pkey" PRIMARY KEY USING INDEX "weather_stations_pkey";

ALTER TABLE "api"."forecast"
	ADD CONSTRAINT "forecast_forecast_type_id_fkey" FOREIGN KEY (forecast_type_id) REFERENCES api.forecast_types (id) NOT valid;

ALTER TABLE "api"."forecast" validate CONSTRAINT "forecast_forecast_type_id_fkey";

ALTER TABLE "api"."forecast"
	ADD CONSTRAINT "forecast_tree_id_fkey" FOREIGN KEY (tree_id) REFERENCES api.trees (id) NOT valid;

ALTER TABLE "api"."forecast" validate CONSTRAINT "forecast_tree_id_fkey";

ALTER TABLE "api"."nowcast"
	ADD CONSTRAINT "nowcast_forecast_type_id_fkey" FOREIGN KEY (forecast_type_id) REFERENCES api.forecast_types (id) NOT valid;

ALTER TABLE "api"."nowcast" validate CONSTRAINT "nowcast_forecast_type_id_fkey";

ALTER TABLE "api"."nowcast"
	ADD CONSTRAINT "nowcast_tree_id_fkey" FOREIGN KEY (tree_id) REFERENCES api.trees (id) NOT valid;

ALTER TABLE "api"."nowcast" validate CONSTRAINT "nowcast_tree_id_fkey";

ALTER TABLE "api"."shading"
	ADD CONSTRAINT "shading_tree_id_fkey" FOREIGN KEY (tree_id) REFERENCES api.trees (id) NOT valid;

ALTER TABLE "api"."shading" validate CONSTRAINT "shading_tree_id_fkey";


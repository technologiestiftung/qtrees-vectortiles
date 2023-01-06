-- This schema ddoes not refelct the whole setup. It only contains the api schema. The other schemas are created documented here
CREATE EXTENSION postgis;

CREATE EXTENSION fuzzystrmatch;

CREATE EXTENSION postgis_tiger_geocoder;

CREATE EXTENSION postgis_topology;

CREATE SEQUENCE "public"."forecast_id_seq";

CREATE SEQUENCE "public"."nowcast_id_seq";

CREATE SEQUENCE "public"."radolan_id_seq";

CREATE TABLE "public"."forecast" (
	"id" integer NOT NULL DEFAULT nextval('public.forecast_id_seq'::regclass),
	"tree_id" text,
	"forecast_type_id" smallint,
	"timestamp" timestamp without time zone,
	"value" double precision,
	"created_at" timestamp without time zone,
	"model_id" text
);

CREATE TABLE "public"."sensor_types" (
	"id" smallint NOT NULL,
	"name" text NOT NULL
);

CREATE TABLE "public"."issue_types" (
	"id" integer NOT NULL,
	"title" text NOT NULL,
	"description" text NOT NULL,
	"image_url" text
);

CREATE TABLE "public"."issues" (
	"id" integer NOT NULL,
	"issue_type_id" integer NOT NULL,
	"created_at" timestamp with time zone NOT NULL DEFAULT now(),
	"gml_id" text NOT NULL
);

CREATE TABLE "public"."nowcast" (
	"id" integer NOT NULL DEFAULT nextval('public.nowcast_id_seq'::regclass),
	"tree_id" text,
	"forecast_type_id" smallint,
	"timestamp" timestamp without time zone,
	"value" double precision,
	"created_at" timestamp without time zone,
	"model_id" text
);

CREATE TABLE "public"."radolan" (
	"id" integer NOT NULL DEFAULT nextval('public.radolan_id_seq'::regclass),
	"rainfall_mm" double precision,
	"geometry" geometry(polygon, 4326),
	"timestamp" timestamp without time zone
);

CREATE TABLE "public"."shading" (
	"tree_id" text NOT NULL,
	"month" smallint NOT NULL,
	"index" double precision
);

CREATE TABLE "public"."soil" (
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

CREATE TABLE "public"."trees" (
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

CREATE TABLE "public"."weather" (
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

CREATE TABLE "public"."weather_stations" (
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

ALTER SEQUENCE "public"."forecast_id_seq" owned BY "public"."forecast"."id";

ALTER SEQUENCE "public"."nowcast_id_seq" owned BY "public"."nowcast"."id";

ALTER SEQUENCE "public"."radolan_id_seq" owned BY "public"."radolan"."id";

CREATE UNIQUE INDEX forecast_pkey ON public.forecast USING btree (id);

CREATE UNIQUE INDEX sensor_types_pkey ON public.sensor_types USING btree (id);

CREATE UNIQUE INDEX issue_types_pkey ON public.issue_types USING btree (id);

CREATE UNIQUE INDEX issues_pkey ON public.issues USING btree (id);

CREATE UNIQUE INDEX nowcast_pkey ON public.nowcast USING btree (id);

CREATE UNIQUE INDEX radolan_pkey ON public.radolan USING btree (id);

CREATE UNIQUE INDEX shading_pkey ON public.shading USING btree (tree_id, month);

CREATE UNIQUE INDEX soil_pkey ON public.soil USING btree (id);

CREATE UNIQUE INDEX trees_pkey ON public.trees USING btree (id);

CREATE UNIQUE INDEX weather_stations_pkey ON public.weather_stations USING btree (id);

ALTER TABLE "public"."forecast"
	ADD CONSTRAINT "forecast_pkey" PRIMARY KEY USING INDEX "forecast_pkey";

ALTER TABLE "public"."sensor_types"
	ADD CONSTRAINT "sensor_types_pkey" PRIMARY KEY USING INDEX "sensor_types_pkey";

ALTER TABLE "public"."issue_types"
	ADD CONSTRAINT "issue_types_pkey" PRIMARY KEY USING INDEX "issue_types_pkey";

ALTER TABLE "public"."issues"
	ADD CONSTRAINT "issues_pkey" PRIMARY KEY USING INDEX "issues_pkey";

ALTER TABLE "public"."nowcast"
	ADD CONSTRAINT "nowcast_pkey" PRIMARY KEY USING INDEX "nowcast_pkey";

ALTER TABLE "public"."radolan"
	ADD CONSTRAINT "radolan_pkey" PRIMARY KEY USING INDEX "radolan_pkey";

ALTER TABLE "public"."shading"
	ADD CONSTRAINT "shading_pkey" PRIMARY KEY USING INDEX "shading_pkey";

ALTER TABLE "public"."soil"
	ADD CONSTRAINT "soil_pkey" PRIMARY KEY USING INDEX "soil_pkey";

ALTER TABLE "public"."trees"
	ADD CONSTRAINT "trees_pkey" PRIMARY KEY USING INDEX "trees_pkey";

ALTER TABLE "public"."weather_stations"
	ADD CONSTRAINT "weather_stations_pkey" PRIMARY KEY USING INDEX "weather_stations_pkey";

ALTER TABLE "public"."forecast"
	ADD CONSTRAINT "forecast_forecast_type_id_fkey" FOREIGN KEY (forecast_type_id) REFERENCES public.sensor_types (id) NOT valid;

ALTER TABLE "public"."forecast" validate CONSTRAINT "forecast_forecast_type_id_fkey";

ALTER TABLE "public"."forecast"
	ADD CONSTRAINT "forecast_tree_id_fkey" FOREIGN KEY (tree_id) REFERENCES public.trees (id) NOT valid;

ALTER TABLE "public"."forecast" validate CONSTRAINT "forecast_tree_id_fkey";

ALTER TABLE "public"."nowcast"
	ADD CONSTRAINT "nowcast_forecast_type_id_fkey" FOREIGN KEY (forecast_type_id) REFERENCES public.sensor_types (id) NOT valid;

ALTER TABLE "public"."nowcast" validate CONSTRAINT "nowcast_forecast_type_id_fkey";

ALTER TABLE "public"."nowcast"
	ADD CONSTRAINT "nowcast_tree_id_fkey" FOREIGN KEY (tree_id) REFERENCES public.trees (id) NOT valid;

ALTER TABLE "public"."nowcast" validate CONSTRAINT "nowcast_tree_id_fkey";

ALTER TABLE "public"."shading"
	ADD CONSTRAINT "shading_tree_id_fkey" FOREIGN KEY (tree_id) REFERENCES public.trees (id) NOT valid;

ALTER TABLE "public"."shading" validate CONSTRAINT "shading_tree_id_fkey";


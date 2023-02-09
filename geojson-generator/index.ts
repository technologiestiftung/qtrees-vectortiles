import fs from "node:fs";

const GEOJSON_OUTPUT_DIR = process.env.GEOJSON_OUTPUT_DIR;
const GEOJSON_OUTPUT_FILENAME = process.env.GEOJSON_OUTPUT_FILENAME;
const POSTGREST_API_URL = process.env.POSTGREST_API_URL;
const POSTGRES_MATERIALIZE_VIEW_NAME =
	process.env.POSTGRES_MATERIALIZE_VIEW_URL;
if (!POSTGRES_MATERIALIZE_VIEW_NAME) {
	throw new Error("POSTGRES_MATERIALIZE_VIEW_NAME env var not defined");
}
if (!POSTGREST_API_URL) {
	throw new Error("POSTGREST_API_URL env var not defined");
}

if (!GEOJSON_OUTPUT_DIR) {
	throw new Error("GEOJSON_OUTPUT_DIR env var not defined");
}

if (!GEOJSON_OUTPUT_FILENAME) {
	throw new Error("GEOJSON_OUTPUT_FILENAME env var not defined");
}

interface Tree extends Record<string, unknown> {
	trees_id: string;
	trees_standortnr: string;
	trees_kennzeich: string;
	trees_namenr: string;
	trees_art_dtsch: string;
	trees_art_bot: string;
	trees_gattung_deutsch: string;
	trees_gattung: string;
	trees_strname: string;
	trees_hausnr: string;
	trees_pflanzjahr: number;
	trees_standalter: number;
	trees_stammumfg: number;
	trees_baumhoehe: number;
	trees_bezirk: string;
	trees_eigentuemer: string;
	trees_zusatz: string;
	trees_kronedurch: number;
	trees_geometry: {
		type: "Point";
		crs: { type: "name"; properties: { name: "EPSG:4326" } };
		coordinates: number[];
	};
	trees_lat: number;
	trees_lng: number;
	trees_created_at: string;
	trees_updated_at: string;
	trees_street_tree: boolean;
	trees_baumscheibe: number;
	nowcast_tree_id: string;
	nowcast_type_30cm: number;
	nowcast_type_60cm: number;
	nowcast_type_90cm: number;
	nowcast_type_stamm: number;
	nowcast_timestamp_30cm: string;
	nowcast_timestamp_60cm: string;
	nowcast_timestamp_90cm: string;
	nowcast_timestamp_stamm: string;
	nowcast_values_30cm: number;
	nowcast_values_60cm: number;
	nowcast_values_90cm: number;
	nowcast_values_stamm: number;
	nowcast_created_at_30cm: string;
	nowcast_created_at_60cm: string;
	nowcast_created_at_90cm: string;
	nowcast_created_at_stamm: string;
	nowcast_model_id_30cm: string;
	nowcast_model_id_60cm: string;
	nowcast_model_id_90cm: string;
	nowcast_model_id_4: string;
}

async function generateGeoJson(trees: Tree[]) {
	const geojson: {
		type: "FeatureCollection";
		features: Record<string, unknown>[];
	} = {
		type: "FeatureCollection",
		features: [],
	};

	for (const tree of trees) {
		const [longitude, latitude, _elevation] = tree.trees_geometry.coordinates;
		const feature = {
			type: "Feature",
			properties: { ...tree },
			geometry: {
				type: "Point",
				crs: tree.trees_geometry.crs,
				coordinates: [longitude, latitude],
			},
		};
		geojson.features.push(feature);
	}
	return geojson;
}

/**
 * This function does a head call to the api to get a count of the total number of trees and the calculate the range we have availalbe to fetch elements.
 */
async function doHeadCount(
	url: URL
): Promise<{ count: number; range: number }> {
	const response = await fetch(url, {
		method: "HEAD",
		headers: {
			"Range-Unit": "items",
			Prefer: "count=exact",
		},
	});
	if (!response.ok) {
		throw new Error("Failed to get vector tiles HEAD count");
	}
	const contentRange = response.headers.get("Content-Range");
	if (!contentRange) {
		throw new Error("Failed to get response header Content-Range");
	}
	const countStr = contentRange.split("/")[1];
	const startStr = contentRange.split("/")[0].split("-")[0];
	const endStr = contentRange.split("/")[0].split("-")[1];
	const count = parseInt(countStr, 10);
	const end = parseInt(endStr, 10);
	const start = parseInt(startStr, 10);
	if (isNaN(start)) {
		throw new Error("Failed to parse start value");
	}
	if (isNaN(end)) {
		throw new Error("Failed to parse end value");
	}
	if (isNaN(count)) {
		throw new Error("Failed to parse count value");
	}
	const range = end - start + 1;
	return { count, range };
}

async function getTrees(
	url: URL,
	offset: number,
	limit: number
): Promise<Tree[]> {
	const response = await fetch(`${url}?limit=${limit}&offset=${offset}`, {
		method: "GET",
	});

	if (!response.ok) {
		throw new Error("Failed to get trees/vector tiles");
	}
	const json = await response.json();
	return json;
}
async function main() {
	try {
		const trees = [];
		const url = new URL(
			`${POSTGREST_API_URL}/${POSTGRES_MATERIALIZE_VIEW_NAME}`
		);

		const { count, range: limit } = await doHeadCount(url);

		let offset = 0;
		const requests = [];
		while (offset < count) {
			const p = getTrees(url, offset, limit);
			offset += limit;

			requests.push(p);
		}

		const results = await Promise.all(requests).catch((error) => {
			console.error(error);
			throw error;
		});

		for (const result of results) {
			trees.push(...result);
		}

		const geojson = await generateGeoJson(trees);
		fs.writeFileSync("out.full.geojson", JSON.stringify(geojson));
	} catch (error) {
		console.error(error);
	}
}

main().catch(console.error);

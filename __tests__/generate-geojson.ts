import fs from "node:fs";

interface Tree {
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

async function doHeadCount(
	url: string,
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
	const range = end - start + 1;
	return { count, range };
}

async function getTrees(
	url: string,
	offset: number,
	limit: number,
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
		const url = "http://localhost:3000/vector_tiles";
		const { count, range } = await doHeadCount(url);

		let offset = 0;
		let limit = range;
		const requests: Promise<Tree>[] = [];
		while (offset < count) {
			const p = getTrees(url, offset, limit);
			offset += limit;

			//@ts-ignore
			requests.push(p);
		}

		const results = await Promise.all(requests).catch((error) => {
			console.error(error);
		});

		//@ts-ignore
		for (const result of results) {
			// @ts-ignore
			trees.push(...result);
		}
		// console.log("trees.length", trees.length);
		// console.log(trees[0]);
		const geojson = await generateGeoJson(trees);
		// console.log(JSON.stringify(geojson, null, 2));
		fs.writeFileSync("out.full.geojson", JSON.stringify(geojson));
	} catch (error) {
		console.error(error);
	}
}

main().catch(console.error);

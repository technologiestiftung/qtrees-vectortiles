import test, { describe } from "node:test";
import assert from "node:assert";
import * as fs from "node:fs";

const TEST_GEOJSON_FILE_PATH = process.env.TEST_GEOJSON_FILE_PATH;

describe("gejson result tests", () => {
	test("env var TEST_GEOJSON_FILE_PATH is defined", () => {
		assert.notEqual(typeof TEST_GEOJSON_FILE_PATH, "undefined");
	});
	test("file under TEST_GEOJSON_FILE_PATH exists", () => {
		if (TEST_GEOJSON_FILE_PATH === undefined) {
			throw new Error("TEST_GEOJSON_FILE_PATH is undefined");
		}
		assert.strictEqual(true, fs.existsSync(TEST_GEOJSON_FILE_PATH));
	});
	test("TEST_GEOJSON_FILE_PATH is parseable as JSON", () => {
		if (TEST_GEOJSON_FILE_PATH === undefined) {
			throw new Error("TEST_GEOJSON_FILE_PATH is undefined");
		}
		assert.doesNotThrow(() => {
			const content = fs.readFileSync(TEST_GEOJSON_FILE_PATH, "utf8");
			JSON.parse(content);
		});
	});

	test("parsed JSON as n features", () => {
		if (TEST_GEOJSON_FILE_PATH === undefined) {
			throw new Error("TEST_GEOJSON_FILE_PATH is undefined");
		}
		const content = fs.readFileSync(TEST_GEOJSON_FILE_PATH, "utf8");
		const geojson = JSON.parse(content) as { features: unknown[] } & Record<
			string,
			unknown
		>;

		assert.strictEqual(geojson.features.length, 5000);
	});
});

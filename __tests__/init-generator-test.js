import postgres from "postgres";
import path from "node:path";
import { dirname } from "node:path";
import { fileURLToPath } from "node:url";
// import fs from "node:fs";
const __dirname = dirname(fileURLToPath(import.meta.url));

const init_file = path.resolve(
	__dirname,
	"../docker-entrypoint-initdb.d/00_init.sql"
);
const seed_file1 = path.resolve(
	__dirname,
	"../docker-entrypoint-initdb.d/10_seed.sql"
);
const seed_file2 = path.resolve(
	__dirname,
	"../docker-entrypoint-initdb.d/20_seed.sql"
);
const refresh_file = path.resolve(
	__dirname,
	"../docker-entrypoint-initdb.d/30_refresh.sql"
);
const sql = postgres({
	host: process.env.POSTGRES_HOST,
	port: process.env.PORT,
	user: process.env.POSTGRES_USER,
	database: process.env.POSTGRES_DB,
	password: process.env.POSTGRES_PASSWORD,
});

async function main() {
	try {
		const result_init = await sql.file(init_file);
		const result_seed1 = await sql.file(seed_file1);
		const result_seed2 = await sql.file(seed_file2);
		const result_refresh = await sql.file(refresh_file);

		console.log(result_init);
		console.log(result_seed1);
		console.log(result_seed2);
		console.log(result_refresh);
	} catch (error) {
		console.error(error);
	} finally {
		await sql.end();
	}
}

main().catch(console.error);

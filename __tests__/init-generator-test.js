import postgres from "postgres";
import path from "node:path";
import { dirname } from "node:path";
import { fileURLToPath } from "node:url";
// import fs from "node:fs";
const __dirname = dirname(fileURLToPath(import.meta.url));

const init_file = path.resolve(__dirname, "../docker-entrypoint-initdb.d/00_init.sql");
const seed_file = path.resolve(__dirname, "../docker-entrypoint-initdb.d/10_seed.sql");

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
		const result_seed = await sql.file(seed_file);

		console.log(result_init);
		console.log(result_seed);
	} catch (error) {
		console.error(error);
	}finally{
    await sql.end();
  }
}

main().catch(console.error);

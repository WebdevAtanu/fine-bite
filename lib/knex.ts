// lib/knex.js
import knex from "knex";

const db = knex({
  client: "mssql",
  connection: {
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_NAME,
    options: {
      encrypt: false, // change to true for local dev / self-signed certs
      trustServerCertificate: true, // change to true for local dev / self-signed certs
    },
  },
  pool: {
    min: 2, // min number of connections
    max: 10, // max number of connections
  },
});

export default db;

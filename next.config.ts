import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  webpack: (config) => {
    config.ignoreWarnings = [
      ...(config.ignoreWarnings || []),
      {
        module: /node_modules\/knex\/lib\/migrations/, // ignore knex migration warnings
      },
    ];

    config.externals = [
      ...(config.externals || []),
      {
        mysql: "commonjs mysql",
        mysql2: "commonjs mysql2",
        pg: "commonjs pg",
        "pg-native": "commonjs pg-native",
        sqlite3: "commonjs sqlite3",
        "better-sqlite3": "commonjs better-sqlite3",
        oracledb: "commonjs oracledb",
      },
    ];

    return config;
  },
};

export default nextConfig;

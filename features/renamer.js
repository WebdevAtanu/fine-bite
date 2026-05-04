import { readdirSync, lstatSync, existsSync, renameSync } from "fs";
import { join, dirname } from "path";
import { fileURLToPath } from "url";

// fix for __dirname in ES modules
const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

// base directory
const BASE_DIR = __dirname;

readdirSync(BASE_DIR, { withFileTypes: true })
    .filter(dirent => dirent.isDirectory())
    .forEach(dirent => {
        const folderPath = join(BASE_DIR, dirent.name);
        const folderName = dirent.name;

        const files = readdirSync(folderPath);

        files.forEach(file => {
            const oldPath = join(folderPath, file);

            if (!lstatSync(oldPath).isFile()) return;

            // skip if already renamed
            if (file.startsWith(folderName + ".")) return;

            // must have at least one dot
            if (!file.includes(".")) return;

            // get everything after first dot
            const suffix = file.split(".").slice(1).join(".");
            if (!suffix) return;

            const newName = `${folderName}.${suffix}`;
            const newPath = join(folderPath, newName);

            // avoid overwrite
            if (existsSync(newPath)) {
                console.log(`Skipped (exists): ${newPath}`);
                return;
            }

            renameSync(oldPath, newPath);
            console.log(`Renamed: ${file} → ${newName}`);
        });
    });

console.log("Done!");
#!/usr/bin/env node
import fs from "fs";
import { fileURLToPath } from "url";
import path from "path";
import fetch from "node-fetch";
import mustache from "mustache";

const year = 2021;
const day = process.argv[2];
if (!day) {
  exit("You must provide the day");
}

await main();

async function main() {
  console.log(`Setting up for day ${day}`);

  const templateDir = path.dirname(fileURLToPath(import.meta.url));
  const codeDir = path.normalize(path.join(templateDir, "../src"));

  const pageTemplate = fs
    .readFileSync(path.join(templateDir, "Pages/DayX.elm"))
    .toString();
  const inputTemplate = fs
    .readFileSync(path.join(templateDir, "Solutions/DayX/Input.elm"))
    .toString();
  const partTemplate = fs
    .readFileSync(path.join(templateDir, "Solutions/DayX/PartX.elm"))
    .toString();

  const pageOutput = mustache.render(pageTemplate, { day: day });
  const inputOutput = mustache.render(inputTemplate, { day: day });
  const part1Output = mustache.render(partTemplate, { day: day, part: 1 });
  const part2Output = mustache.render(partTemplate, { day: day, part: 2 });

  safeWrite(pageOutput, codeDir, `Pages/Day${day}.elm`);
  safeWrite(inputOutput, codeDir, `Solutions/Day${day}/Input.elm`);
  safeWrite(part1Output, codeDir, `Solutions/Day${day}/Part1.elm`);
  safeWrite(part2Output, codeDir, `Solutions/Day${day}/Part2.elm`);
}

function safeWrite(content, dir, file) {
  const outFile = path.join(dir, file);
  const outDir = path.dirname(outFile);
  fs.mkdirSync(outDir, { recursive: true });
  fs.writeFileSync(outFile, content, { flag: "wx" });
}

function exit(message) {
  console.error(message);
  process.exit(1);
}

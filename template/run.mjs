#!/usr/bin/env node
import fs from "fs";
import { fileURLToPath } from "url";
import path from "path";
import fetch from "node-fetch";
import mustache from "mustache";

await main();

async function main() {
  const templateDir = path.dirname(fileURLToPath(import.meta.url));
  const codeDir = path.normalize(path.join(templateDir, "../src"));
  const solutionsDir = path.join(codeDir, "Solutions");
  const days = fs.readdirSync(solutionsDir);
  const day = days.length + 1;

  console.log(`Adding day ${day}`);

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
  safeWrite(inputOutput, solutionsDir, `Day${day}/Input.elm`);
  safeWrite(part1Output, solutionsDir, `Day${day}/Part1.elm`);
  safeWrite(part2Output, solutionsDir, `Day${day}/Part2.elm`);

  updateMainJs(codeDir, day);
}

function safeWrite(content, dir, file) {
  const outFile = path.join(dir, file);
  const outDir = path.dirname(outFile);
  fs.mkdirSync(outDir, { recursive: true });
  fs.writeFileSync(outFile, content, { flag: "wx" });
}

function updateMainJs(codeDir, day) {
  const mainJs = path.join(codeDir, "../public/main.js");
  const mainCode = fs.readFileSync(mainJs).toString();
  const newMainCode = mainCode.replace(
    /const onDay.*/g,
    `const onDay = ${day};`
  );
  fs.writeFileSync(mainJs, newMainCode);
}

function exit(message) {
  console.error(message);
  process.exit(1);
}

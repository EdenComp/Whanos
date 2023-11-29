import Befunge from 'befunge93';
import * as fs from "fs";

async function main() {
  const program = fs.readFileSync("/app/app/main.bf", "utf-8");
  const befunge = new Befunge();
  const output = await befunge.run(program);

  process.stdout.write(output);
}

main().catch(console.error);

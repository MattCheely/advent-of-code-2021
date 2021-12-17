import { defineConfig } from "vite";
import elmPlugin from "vite-plugin-elm";

export default defineConfig(({ command, mode }) => {
  const basePath = process.env.DEPLOY_PATH || "./";

  return {
    root: "public",
    publicDir: "Solutions",
    base: basePath,
    plugins: [elmPlugin()],
    build: {
      outDir: "../dist"
    }
  };
});

import { defineConfig } from "vite";
import elmPlugin from "vite-plugin-elm";
import { createConfigFile } from "elm-build-config";

export default defineConfig(({ command, mode }) => {
  const basePath = (process.env.DEPLOY_PATH || "./").replace(/\/?$/, "/");

  return {
    root: "public",
    publicDir: "Solutions",
    base: basePath,
    plugins: [
      elmPlugin(),
      configPlugin({ basePath: basePath }, { src: "srcDir" })
    ],
    build: {
      outDir: "../dist",
      emptyOutDir: true
    }
  };
});

function configPlugin(configData, options) {
  return {
    name: "elm-build-config",
    buildStart() {
      createConfigFile(configData, options);
    }
  };
}

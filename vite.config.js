import elmPlugin from "vite-plugin-elm";

export default {
  root: "public",
  publicDir: "Solutions",
  base: "./",
  plugins: [elmPlugin()],
  build: {
    outDir: "../dist"
  }
};

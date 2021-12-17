import elmPlugin from "vite-plugin-elm";

export default {
  root: "public",
  base: "./",
  plugins: [elmPlugin()],
  build: {
    outDir: "../dist"
  }
};

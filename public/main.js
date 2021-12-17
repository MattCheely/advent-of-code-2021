import { Elm } from "../src/Main.elm";

const onDay = 3;
const baseUrl = import.meta.env.BASE_URL;

Elm.Main.init({ flags: { basePath: baseUrl, shared: onDay } });

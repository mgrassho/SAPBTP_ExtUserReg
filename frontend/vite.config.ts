import { fileURLToPath, URL } from "node:url";

import { defineConfig } from "vite";
import vue from "@vitejs/plugin-vue";

const outDir = "../app/pages";
const baseURL = "/pages/";

// https://vitejs.dev/config/
export default defineConfig({
  base: baseURL,
  plugins: [vue(
    {
      template: {
        compilerOptions: {
          // 1. Tell Vite that all components starting with "ui5-" are webcomponents
          isCustomElement: (tag) => tag.startsWith('ui5-')
        }
      }
    }
  )
  ],
  resolve: {
    alias: {
      "@": fileURLToPath(new URL("./src", import.meta.url)),
    },
  },
  build: {
    outDir: outDir,
    minify: false,
  },
});

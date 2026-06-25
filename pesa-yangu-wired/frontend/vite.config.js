import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

export default defineConfig({
  plugins: [react()],
  server: {
    port: 5173,
    proxy: {
      // In local dev, proxies /api/* to the Express backend
      "/api": {
        target: "http://localhost:3001",
        changeOrigin: true,
      },
    },
  },
  build: {
    outDir: "dist",
    sourcemap: false,
    // Warn if any single chunk exceeds 400 kB
    chunkSizeWarningLimit: 400,
    rollupOptions: {
      output: {
        manualChunks: {
          // React runtime in its own tiny chunk — browser caches it across deploys
          "vendor-react": ["react", "react-dom"],
          // Axios + http utilities
          "vendor-http":  ["axios"],
        },
      },
    },
  },
  resolve: { alias: { "@": "/src" } },
});

import { defineConfig } from 'vite'
import rabbitTEA from 'rabbit-tea-vite'
import tailwindcss from '@tailwindcss/vite'
import { exec } from 'child_process';
import server from './server.js';

server();

export default defineConfig({
    plugins: [
        rabbitTEA(),
        tailwindcss()
    ],
    server: {
        proxy: {
            '/api': 'http://localhost:3000'
        }
    }
})


import { defineConfig } from 'vite'
import rabbitTEA from 'rabbit-tea-vite'
import tailwindcss from '@tailwindcss/vite'

export default defineConfig({
    plugins: [
        rabbitTEA(),
        tailwindcss()
    ]
})


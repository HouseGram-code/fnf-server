FROM node:22-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install --ignore-scripts
COPY . .
RUN npx tsc
EXPOSE 2567
CMD ["node", "build/index.js"]

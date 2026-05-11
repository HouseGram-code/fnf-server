FROM node:22-slim
RUN apt-get update && apt-get install -y \
    libcairo2-dev libpango1.0-dev libjpeg-dev libgif-dev librsvg2-dev \
    python3 make g++ openssl \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY package*.json ./
RUN npm install --ignore-scripts
RUN npm rebuild canvas --update-binary
COPY . .
RUN DATABASE_URL="mongodb://localhost:27017/dummy" npx prisma generate
RUN npx tsc
EXPOSE 2567
CMD ["node", "build/index.js"]

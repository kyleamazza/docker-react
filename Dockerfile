# First phase: Build application into production
FROM node:10.11.0-alpine as builder

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY package.json .
RUN npm i -q

COPY . .

RUN npm run build

# Second phase: Serve built html files via Nginx
FROM nginx:1.15.8-alpine
COPY --from=builder /usr/src/app/build /usr/share/nginx/html

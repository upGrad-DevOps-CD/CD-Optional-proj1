FROM node:10 as builder
COPY . /app
WORKDIR /app
RUN npm install && yarn build 
FROM nginx
COPY --from=builder /app/build/ /usr/share/nginx/html
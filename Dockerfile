# Build Phase Install dependencies and build application
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN yarn install
COPY . .
RUN yarn build

# Run Phase to use nginx to copy over result of yarn build
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
# The default command of running the nginx container 
# automatically starts nginx server for us
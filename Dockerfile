FROM node:16-alpine as builder

WORKDIR '/app'

COPY package.json .
RUN npm install

COPY . .

RUN npm run build

# /app/build has stuff we care

FROM nginx
# important: we are copy from builder container to this container
COPY --from=builder /app/build/ /usr/share/nginx/html 
# start nginx is default command, no need to for start nginx
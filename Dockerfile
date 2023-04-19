#first configuration phase: build with node base image, named as the "builder" phase

FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build
# also works: CMD ["npm", "run", "build"]


# start of second phase to set up the web server in another image
FROM nginx
#copy from one image to another
COPY --from=builder app/build /usr/share/nginx/html


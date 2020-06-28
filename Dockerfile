# First phase
# builder is a tag name
FROM node:alpine as builder 
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . . 
# No need to set a volume because this is a production docker file
RUN npm run build

# /app/build <-- all the stuff that we care about(no need the dependencies as this is the binary)

# Second phase. the dest folder is taken the hub.docker.com page og nginx
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
# The first phase image is getting overriden / dropped. So we get a relatively small image with just our app and nginx
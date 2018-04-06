FROM node:9.10-alpine

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies
RUN apk update && apk upgrade && apk add git curl

ONBUILD COPY . /usr/src/app/
RUN mkdir -p node_modules/node-sass/vendor/linux-x64-59
RUN curl -L https://github.com/sass/node-sass/releases/download/v4.8.2/linux_musl-x64-59_binding.node -o node_modules/node-sass/vendor/linux-x64-59/binding.node

ONBUILD RUN npm install
RUN npm rebuild node-sass

# Build app
ONBUILD RUN npm run build

ENV HOST 0.0.0.0
EXPOSE 3000

# start command
CMD ["npm", "start"]


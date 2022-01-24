#Dockerfile for frontend
FROM node:13.12.0-alpine as build
WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH
COPY package.json ./app
COPY package-lock.json ./app
RUN npm install react-scripts@3.4.1 -g --silent
COPY . ./app
RUN npm install --production

EXPOSE 8080
CMD [ "node", "server.js" ]

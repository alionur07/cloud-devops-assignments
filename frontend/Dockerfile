#Dockerfile for frontend
FROM node:13.12.0-alpine as build
WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH
COPY package.json .
COPY package-lock.json .
COPY . .
RUN npm install react-scripts@3.4.1 -g --silent
RUN npm install --production

EXPOSE 80
CMD [ "node", "server.js" ]

FROM node:lts-alpine3.12 as build-stage

RUN mkdir /app
WORKDIR /app

COPY ./package*.json /app/

RUN npm install

COPY . /app

RUN npm run-script build

FROM nginx:stable-alpine as production

COPY --from=build-stage /app/build/ /usr/share/nginx/html
#COPY --from=build-stage /app/js/ /usr/share/nginx/html/js

EXPOSE 80




# IMPORTANT: Bellow is the dockerfile to run it as debugging mode on cloud.. Size will be more than 1 GB



#FROM node:latest
#
#RUN mkdir /app
#WORKDIR /app
#
#COPY ./package.json .
#
#RUN npm install
#
#ADD . /app
#
#EXPOSE 8080
#CMD [ "npm", "start" ]

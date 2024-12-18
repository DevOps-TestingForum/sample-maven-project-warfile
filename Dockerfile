FROM maven:3.8.6-openjdk-11 AS build

WORKDIR app

COPY . .

RUN mvn clean install

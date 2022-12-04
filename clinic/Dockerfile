FROM maven:3.8.5-openjdk-17-slim AS build
COPY libs /home/app/libs
COPY src /home/app/src
COPY pom.xml /home/app
WORKDIR /home/app
RUN mvn clean install
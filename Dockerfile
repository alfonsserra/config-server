### STAGE 1: Build ###

# We label our stage as 'builder'
FROM maven:alpine as builder

## Storing node modules on a separate layer will prevent unnecessary npm installs at each build
RUN mkdir /config-server

WORKDIR /config-server

COPY . .

## Build the angular app in production mode and store the artifacts in dist folder
RUN mvn package

### STAGE 2: Setup ###

FROM openjdk:8-jre-alpine


COPY --from=builder /config-server/target/config-server-1.0.jar config-server.jar


CMD ["java","-jar","config-server.jar"]

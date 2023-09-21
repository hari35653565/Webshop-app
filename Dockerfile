FROM clojure:openjdk-11-lein-slim-buster AS build
WORKDIR /usr/src/app  # Set the working directory
COPY . .  # Copy all files from the current directory to the container
RUN lein uberjar

FROM openjdk:11-jre-slim
WORKDIR /usr/src/app
COPY --from=build /usr/src/app/target/uberjar/*-standalone.jar ./app.jar
COPY logback.xml /usr/src/app/logback.xml
CMD ["java", "-jar", "app.jar"]

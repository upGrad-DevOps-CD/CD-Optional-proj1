FROM maven:3.8.1-jdk-11 as builder
COPY . /build
WORKDIR /build
RUN mvn clean -Dmaven.test.skip package install spring-boot:repackage
FROM openjdk:11.0.11-jre
WORKDIR /app
COPY --from=builder /build/target/upstac-api-*.jar /app/upstac-api.jar
CMD ["java","-jar","upstac-api.jar"]

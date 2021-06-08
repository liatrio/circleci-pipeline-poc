FROM gradle:latest as builder
COPY build.gradle.kts .
COPY src ./src
RUN gradle clean build

FROM openjdk:8-jre-alpine
COPY --from=builder /home/gradle/build/libs/gradle-0.0.1-SNAPSHOT.jar /springboot.jar
CMD [ "java", "-jar", "-Djava.security.egd=file:/dev/./urandom", "/springboot.jar" ]


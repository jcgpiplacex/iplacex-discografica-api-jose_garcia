# STAGE 1

FROM gradle:jdk21 AS builder

WORKDIR /app

COPY ./build.gradle .
COPY ./settings.gradle .

COPY src ./src

RUN gradle build --no-daemon

# STAGE 2

FROM eclipse-temurin:21-jre

WORKDIR /app

COPY --from=builder /app/build/libs/*.jar app.jar

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]
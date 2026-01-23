FROM maven:3.9-eclipse-temurin-21 AS builder

WORKDIR /build

COPY java-app/pom.xml .
RUN mvn -B -e dependency:go-offline

COPY java-app/src ./src
RUN mvn -B clean package -DskipTests

FROM gcr.io/distroless/java21-debian12

WORKDIR /app

COPY --from=builder /build/target/*.jar app.jar

EXPOSE 8080

CMD ["app.jar"]
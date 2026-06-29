FROM maven:3.9-eclipse-temurin-17 AS builder
WORKDIR /build
COPY pom.xml .
RUN mvn -q dependency:resolve
COPY . .
RUN mvn -q clean compile exec:java

FROM nginx:1.27-alpine
COPY --from=builder /build/output /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
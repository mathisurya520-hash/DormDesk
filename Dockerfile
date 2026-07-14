FROM maven:3.9.6-eclipse-temurin-11

WORKDIR /app

COPY . .

RUN mvn clean package

EXPOSE 8080

CMD ["mvn", "jetty:run", "-Djetty.http.port=8080"]
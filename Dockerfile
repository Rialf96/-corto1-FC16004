# Usa Maven para compilar
FROM maven:3.8.5-openjdk-17 AS builder

WORKDIR /app

# Copia los archivos del proyecto
COPY . .

# Compila la aplicación sin ejecutar pruebas
RUN mvn clean package -DskipTests

# Fase de ejecución con una imagen más ligera
FROM openjdk:17-jdk-slim

WORKDIR /app

# Copia el .jar generado
COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]

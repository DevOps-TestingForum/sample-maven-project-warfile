# Step 1: Use Maven image to build the app
FROM maven:3.8.6-openjdk-11 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml and source code into the container
COPY pom.xml ./
COPY src ./src

# Step 2: Build the application using Maven
RUN mvn clean install -DskipTests  # Optionally skip tests for faster build

# Step 3: Use a lightweight image for running the application
FROM openjdk:11-jre-slim

# Set the working directory for the runtime container
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/target/*.jar /app/my-app.jar

# Expose the port the app will run on (optional, depending on your app)
EXPOSE 8080

# Command to run the application
ENTRYPOINT ["java", "-jar", "/app/my-app.jar"]


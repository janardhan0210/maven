FROM maven:15.3.0.-openjdk-11-slim AS build

# Set the working directory in the container
WORKDIR /home/janardhan/project1/maven

# Copy the project's pom.xml file into the container
COPY pom.xml .

# Download dependencies specified in pom.xml (this step can be cached)
RUN mvn dependency:go-offline

# Copy the entire project source code into the container
COPY src ./src

# Build the Maven project
RUN mvn package

# Use a lightweight base image to deploy the application
FROM openjdk:11-jre-slim AS runtime

# Set the working directory in the container
WORKDIR //home/janardhan/project1/maven

# Copy the compiled application JAR file from the build stage
COPY --from=build /app/target/your-project.jar ./your-project.jar

# Expose the port on which your application will run
EXPOSE 8082

# Command to run your application when the container starts
CMD ["java", "-jar", "maven.jar"]

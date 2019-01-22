FROM maven:3-jdk-8-alpine AS build
LABEL Version="1.0" \
      Name="Spring Petclinic"
WORKDIR /petclinic
COPY pom.xml . 
COPY src/ src/
RUN ["mvn", "package", "-Dmaven.test.skip=true"]

FROM openjdk:8-jre-alpine AS runtime
WORKDIR /app
COPY --from=build /petclinic/target/*.jar .
EXPOSE 8080
CMD java -jar *.jar

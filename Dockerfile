FROM anapsix/alpine-java
LABEL maintainer="Bathina Pullarao"
COPY /target/jacoco-0.0.1-SNAPSHOT.jar /home/jacoco-0.0.1-SNAPSHOT.jar
CMD ["java","-jar","/home/jacoco-0.0.1-SNAPSHOT.jar"]

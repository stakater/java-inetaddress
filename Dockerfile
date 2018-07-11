FROM java:openjdk-8-jdk

COPY Main.java .
RUN javac Main.java

CMD ["java", "Main"]

# Base image
FROM oracle/openjdk:8

# Copy build files
WORKDIR /opt/aem
COPY files/6.4/cq-6.4.0-quickstart.jar files/6.4/license.properties ./

# Unpack AEM
RUN java \
  -Djava.awt.headless=true \
  -jar cq-6.4.0-quickstart.jar \
  -unpack

# Remove the original jar
RUN rm cq-6.4.0-quickstart.jar

# Base image
FROM oracle/openjdk:8

# Copy files
WORKDIR /opt/aem
COPY --from=0 /opt/aem .
COPY utils.sh ./

# Startup command
CMD ["/bin/bash"]

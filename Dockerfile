# Base image
FROM oracle/openjdk:8

# Copy build files
WORKDIR /opt/aem
COPY files/cq-6.3.0-quickstart.jar files/license.properties ./

# Unpack AEM
RUN java \
  -Djava.awt.headless=true \
  -jar cq-6.3.0-quickstart.jar \
  -unpack

# Remove the original jar
RUN rm cq-6.3.0-quickstart.jar

# Base image
FROM oracle/openjdk:8

# Copy files
WORKDIR /opt/aem
COPY --from=0 /opt/aem .
COPY scripts ./scripts

# Startup command
CMD ["/bin/bash"]

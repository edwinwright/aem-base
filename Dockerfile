# Base image
FROM oracle/openjdk:8

# Copy build files
COPY files/cq-6.3.0-quickstart.jar files/license.properties /opt/aem/

# Unpack AEM
WORKDIR /opt/aem
RUN java \
  -Djava.awt.headless=true \
  -jar cq-6.3.0-quickstart.jar \
  -unpack && \
  rm /opt/aem/cq-6.3.0-quickstart.jar

# Base image
FROM oracle/openjdk:8

WORKDIR /opt/aem
COPY --from=0 /opt/aem .
COPY scripts ./scripts

# Startup command
CMD ["/bin/bash"]

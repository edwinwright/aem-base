FROM oracle/openjdk:8
WORKDIR /opt/aem

# Unpack AEM
COPY files/6.4/cq-6.4.0-quickstart.jar files/6.4/license.properties ./
RUN java \
  -Djava.awt.headless=true \
  -jar cq-6.4.0-quickstart.jar \
  -unpack
RUN rm cq-6.4.0-quickstart.jar

# Base image
FROM oracle/openjdk:8
WORKDIR /opt/aem
COPY --from=0 /opt/aem .
CMD ["/bin/bash"]

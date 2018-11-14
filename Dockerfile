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

RUN groupadd --gid 1000 aem
RUN useradd --uid 1000 --gid aem --shell /bin/bash --create-home aem
RUN mkdir /opt/aem
RUN chgrp aem /opt/aem
RUN chmod g+s /opt/aem

WORKDIR /opt/aem
COPY --from=0 --chown=aem:aem /opt/aem .
COPY --chown=aem:aem scripts ./scripts
USER aem

# Startup command
CMD ["/bin/bash"]

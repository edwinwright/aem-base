# Base image
FROM oracle/openjdk:8

# Copy build files
WORKDIR /opt/aem
COPY files/cq-6.3.0-quickstart.jar files/license.properties ./

# Unpack AEM
RUN java \
  -Djava.awt.headless=true \
  -jar cq-6.3.0-quickstart.jar \
  -unpack && \
  rm cq-6.3.0-quickstart.jar

# Base image
FROM oracle/openjdk:8

RUN groupadd --gid 1000 aem \
  && useradd --uid 1000 --gid aem --shell /bin/bash --create-home aem

RUN mkdir /opt/aem \
  && chgrp aem /opt/aem \
  && chmod g+s /opt/aem

WORKDIR /opt/aem
COPY --from=0 --chown=root:aem /opt/aem .
COPY --chown=root:aem scripts ./scripts

# Startup command
CMD ["/bin/bash"]

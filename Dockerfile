FROM      python:3.7-alpine

WORKDIR   /config
VOLUME    /config

# Create a user to run the application
RUN       adduser -D flexget  

# Prepare config
RUN       ln -s /config /home/flexget/.flexget

# Install FlexGet
RUN       apk add -U tzdata \
                     curl && \
          pip3 install -U pip  && \
          pip3 install --no-cache-dir flexget transmissionrpc && \
          rm -rf /var/cache/apk/* \
                 /root/.cache \
                 /tmp/* \
                 /build \
                 /root/packages

# Add start script
COPY      start.sh /home/flexget/
RUN       chmod +x /home/flexget/start.sh

# Change permissions
RUN       chown -R flexget.flexget /home/flexget/  && \
          chmod 777 /home/flexget/                 && \
          chmod 777 /home/flexget/.flexget                 

# Ports and volumes.
EXPOSE    5050/tcp

USER      flexget
CMD       ["/home/flexget/start.sh"]
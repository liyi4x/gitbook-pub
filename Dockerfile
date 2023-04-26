FROM node:8.10.0-alpine

RUN npm config set unsafe-perm true && \
    npm install --global gitbook-cli && \
    apk --update add --no-cache git && \
    gitbook fetch 3.2.3 && \
    npm cache clear --force && \
    rm -rf /tmp/*

COPY main.sh /

ENTRYPOINT ["/main.sh"]

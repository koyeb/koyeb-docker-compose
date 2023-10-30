FROM docker:dind

WORKDIR /app

COPY koyeb-entrypoint.sh /koyeb-entrypoint.sh

ENTRYPOINT ["/koyeb-entrypoint.sh"]
CMD ["docker", "compose", "up"]
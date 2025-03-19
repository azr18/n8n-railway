FROM n8nio/n8n:latest

ENV NODE_ENV=production
ENV GENERIC_TIMEZONE=UTC

EXPOSE 5678

CMD ["n8n", "start"]

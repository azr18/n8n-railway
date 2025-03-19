FROM n8nio/n8n:latest

ENV NODE_ENV=production
ENV GENERIC_TIMEZONE=UTC
ENV N8N_METRICS=true

# Expose port for Railway
EXPOSE 5678

# Healthcheck to ensure container is running properly
HEALTHCHECK --interval=30s --timeout=10s --retries=3 CMD wget -O- localhost:5678/metrics || exit 1

# Start n8n
CMD ["n8n", "start"] 
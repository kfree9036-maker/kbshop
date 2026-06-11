FROM nginx:stable-alpine
COPY public /usr/share/nginx/html

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -q --spider http://localhost/ || exit 1

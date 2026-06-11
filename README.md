# kbshop
🛍️ KBShop – Modern E-Commerce Web App  KBShop is a modern full-stack e-commerce web application built for online shopping experience. It includes product browsing, cart system, and smooth checkout flow with a clean UI design.

## Deployment

Local (Docker Compose):

```bash
docker compose up --build
# open http://localhost:8080
```

CI publish (GHCR):

On push to `main`, GitHub Actions will build and publish a Docker image to GitHub Container Registry at `ghcr.io/<owner>/kbshop:latest` using the included workflow `.github/workflows/docker-publish.yml`.


Deployment: logs, health, and rollback
====================================

View running containers (local):

```bash
docker ps --filter name=kbshop
```

Stream logs:

```bash
docker compose logs -f
# or for the single container
docker logs -f $(docker ps -q -f name=kbshop-web)
```

Health check (returns 200):

```bash
curl -i http://localhost:8080/health
```

Restart / quick fix (local):

```bash
docker compose restart
# or rebuild & restart
docker compose up --build -d
```

Rollback (recommended approach)

- If using images pushed to GHCR, redeploy a previous image tag by updating `docker-compose.yml` to use a known-good tag, then pull & restart:

```bash
# edit docker-compose.yml: set image: ghcr.io/<owner>/kbshop:<tag>
docker compose pull
docker compose up -d
```

- Alternatively, re-run a previous successful GitHub Actions workflow and deploy its image tag.

GitHub Actions (CI) troubleshooting

- See workflow runs in the repo Actions tab: https://github.com/<owner>/kbshop/actions
- Using GitHub CLI:

```bash
gh run list --repo <owner>/kbshop
gh run view <run-id> --repo <owner>/kbshop --log
```

Deleting a problematic image (if you pushed a bad tag)

```bash
docker image rm ghcr.io/<owner>/kbshop:latest
```

Notes
- CI publishes images to `ghcr.io/<owner>/kbshop:latest` by default. Prefer immutable tags (semver or commit SHA) for production deployments so you can reliably roll back.
- If you want, I can add a small `deploy-to-cloud` guide for a specific provider (Cloud Run, ECS, Heroku, Vercel). Tell me which provider.

Custom domain (GitHub Pages)

- Add a `CNAME` file at the root of your `public/` directory with your desired domain, e.g.:

```text
kbshop.yourdomain.com
```

- Push the site (the repository already publishes `public/` to the `gh-pages` branch). The presence of `CNAME` will configure Pages to use the custom domain.

- DNS configuration:
	- For an apex/root domain (example.com): add these A records to your DNS provider pointing to GitHub Pages IPs:

```
185.199.108.153
185.199.109.153
185.199.110.153
185.199.111.153
```

	- For a subdomain (www or kbshop): create a `CNAME` record pointing to `kfree9036-maker.github.io` (or `<owner>.github.io`).

- Verify and enable HTTPS in the repository Pages settings after DNS propagation (GitHub will provision an SSL certificate automatically once DNS is correct).

- Using `gh` (optional): set Pages custom domain via API:

```bash
gh api -X PATCH repos/${GITHUB_OWNER}/${GITHUB_REPO}/pages -f cname='kbshop.yourdomain.com'
```

Replace `${GITHUB_OWNER}` and `${GITHUB_REPO}` accordingly. If you want, tell me the domain and I can set this for you (you may need to add DNS records afterwards).

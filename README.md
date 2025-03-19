# n8n on Railway

This repository contains the necessary configuration to deploy [n8n](https://n8n.io/) - a workflow automation tool - on [Railway](https://railway.app/).

## Features

- Latest version of n8n
- Automatic PostgreSQL database integration
- Basic authentication enabled by default
- Health checks for better reliability
- Optimized for Railway's environment

## Deployment Guide

### Prerequisites

- A [Railway](https://railway.app/) account
- Basic familiarity with n8n and environment variables

### Step 1: Create a New Project in Railway

1. Go to [Railway's website](https://railway.app/) and log in to your account
2. Click on "New Project" in your dashboard
3. Select "Deploy from GitHub repo"
4. Connect with your GitHub account and select this repository
5. Click "Deploy Now"

### Step 2: Add a PostgreSQL Database

1. In your new project, click "New" and select "Database"
2. Choose "PostgreSQL"
3. Click "Add PostgreSQL"
4. Wait for the database to be provisioned (this might take a minute)

### Step 3: Configure Environment Variables

1. Click on your n8n service
2. Go to the "Variables" tab
3. Add the following environment variables (you can reference the `.env.example` file):

```
N8N_BASIC_AUTH_ACTIVE=true
N8N_BASIC_AUTH_USER=your_username
N8N_BASIC_AUTH_PASSWORD=your_strong_password
DB_TYPE=postgresdb
DB_POSTGRESDB_HOST=${{Postgres.PGHOST}}
DB_POSTGRESDB_DATABASE=${{Postgres.PGDATABASE}}
DB_POSTGRESDB_USER=${{Postgres.PGUSER}}
DB_POSTGRESDB_PASSWORD=${{Postgres.PGPASSWORD}}
DB_POSTGRESDB_PORT=${{Postgres.PGPORT}}
NODE_FUNCTION_ALLOW_EXTERNAL=pg
WEBHOOK_URL=https://your-railway-app-name.up.railway.app
TZ=UTC
PORT=5678
RAILWAY_STATIC_URL=true
N8N_ENCRYPTION_KEY=your-random-encryption-key
```

Replace:
- `your_username` and `your_strong_password` with secure credentials
- `your-railway-app-name` with your actual Railway app name
- `your-random-encryption-key` with a secure random string (important for data encryption)

### Step 4: Deploy

Railway will automatically deploy your service. If it doesn't, click the "Deploy" button in the top right corner.

### Step 5: Access Your n8n Instance

1. Wait for the deployment to complete
2. Click on your n8n service
3. In the "Settings" tab, find your service URL
4. Visit this URL in your browser
5. Log in using the username and password you set in the environment variables

## Important Security Notes

1. **Change Default Credentials**: Always change the default authentication credentials.
2. **Encryption Key**: Set a strong, random `N8N_ENCRYPTION_KEY` to secure sensitive workflow data.
3. **Webhook URL**: Ensure the `WEBHOOK_URL` is set correctly for webhook functionality.

## Updating n8n

To update to the latest version of n8n, simply click "Deploy" on your Railway service. The Dockerfile uses the `latest` tag, which will pull the most recent stable version of n8n.

If you prefer a specific version, modify the Dockerfile to use a specific tag:
```
FROM n8nio/n8n:0.236.0
```

## Troubleshooting

### Database Connection Issues

If you encounter database connection issues:
1. Verify that the PostgreSQL database is running
2. Check that the database environment variables are correctly linked
3. Review Railway logs for specific error messages

### Webhook Problems

If webhooks aren't working:
1. Ensure the `WEBHOOK_URL` environment variable is set correctly
2. Verify that Railway has assigned your service a public URL

## Support and Contributions

- For n8n-specific questions, refer to the [n8n documentation](https://docs.n8n.io/)
- For Railway deployment issues, check the [Railway documentation](https://docs.railway.app/)
- Contributions to improve this deployment configuration are welcome! 
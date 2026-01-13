# Hytale Server with Docker

This project allows you to run a Hytale server in a Docker container.

I use it for Dokploy

## Prerequisites

- Docker and Docker Compose installed

## Installation

1. Execute the docker compose:
   ```bash
   docker compose up -d
   ```
2. The first time, you'll need to check the log and click on the oauth link:
   ```bash
   docker compose logs -f
   ```

```
   hytale-server  | Please visit the following URL to authenticate:
   hytale-server  | https://oauth.accounts.hytale.com/oauth2/device/verify?user_code=ABC-DEF
   hytale-server  | Or visit the following URL and enter the code:
   hytale-server  | https://oauth.accounts.hytale.com/oauth2/device/verify
   hytale-server  | Authorization code: ABC-DEF
```

## Usage

- **Start the server**: `docker compose up -d`
- **View logs**: `docker compose logs -f`
- **Stop the server**: `docker compose down`
- **Restart**: `docker compose restart`

## Ports

The server listens on port **5520**.

## Persistent data

Server data (worlds, configurations, etc.) is stored in the `./data/` folder.

## Documentation

For more information, consult the [Hytale Server Manual](https://support.hytale.com/hc/en-us/articles/45326769420827-Hytale-Server-Manual).


# Developer Documentation

## Project Structure

```
inception/
├── srcs/
│   ├── docker-compose.yml         # Docker services configuration
│   ├── .env                       # Environment variables
│   └── requirements/
│       ├── mariadb/               # MariaDB service
│       │   ├── Dockerfile
│       │   ├── conf/50-server.cnf
│       │   └── tools/init.sh
│       ├── nginx/                 # Nginx reverse proxy
│       │   ├── Dockerfile
│       │   └── conf/nginx.conf
│       └── wordpress/             # WordPress + PHP-FPM
│           ├── Dockerfile
│           └── tools/setup.sh
├── secrets/                       # Secret files (not committed)
├── Makefile                       # Build automation
└── README.md                      # Project overview
```

## Architecture

- **Nginx**: Reverse proxy on port 443 (HTTPS only)
- **WordPress**: PHP-FPM application server (port 9000)
- **MariaDB**: Database server (port 3306, internal only)

## Key Features

- Docker Compose orchestration
- SSL/TLS encryption (self-signed)
- Named volumes for data persistence
- Custom network for service communication
- WP-CLI for WordPress automation

## Building

```bash
make build      # Build images
make up         # Start services
make down       # Stop services
make fclean     # Full cleanup
```

## Secrets Management

Place password files in `secrets/` directory:
```
   secrets/
   ├── db_password.txt         (WordPress database user password)
   ├── db_root_password.txt    (MariaDB root password)
   ├── wp_admin_pass.txt       (WordPress admin password)
   └── wp_user_password.txt    (Additional WordPress user password)
```

## Environment Variables

Edit `srcs/.env` to customize:
- `DOMAIN_NAME` - Your domain/hostname
- `DB_*` - Database credentials
- `WP_*` - WordPress configuration

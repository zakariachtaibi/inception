# User Documentation

## Services Overview

The Inception stack provides a complete web hosting solution with three core services:

1. **Nginx** - Web server and reverse proxy
   - Listens on HTTPS (port 443)
   - Routes requests to WordPress
   - Handles SSL/TLS encryption

2. **WordPress** - Content management system
   - PHP-FPM application server
   - Manages website content and users
   - Accessible through admin panel

3. **MariaDB** - Database server
   - Stores all WordPress data
   - Manages user accounts and posts
   - Runs internally (not exposed to the internet)

---

## Starting and Stopping the Project

### First-Time Setup

1. **Start the project**:
   ```bash
   make
   ```
   This builds and starts all services automatically.

### Daily Operations

- **Stop the project**: `make down`
- **Stop without removing**: `make stop`
- **Start the project**: `make up`
- **View live logs**: `make logs`

### Full Cleanup

- **Complete reset** (removes all data):
  ```bash
  make fclean
  ```

---

## Accessing the Website and Admin Panel

### Website
- **URL**: https://zchtaibi.42.fr
- **Type**: Your WordPress website
- **Note**: Accept the SSL certificate warning (self-signed certificate)

### Admin Panel
- **URL**: https://zchtaibi.42.fr/wp-admin
- **Username**: `zchtaibi`
- **Password**: Content of `secrets/wp_admin_pass.txt`

### Additional User
- **Username**: `wpuser`
- **Password**: Content of `secrets/wp_user_password.txt`

---

## Managing Credentials

All passwords are stored in text files in the `secrets/` directory

**⚠️ Important**: 
- Keep these files secure
- Do not commit to Git
- Change passwords after first installation
- Back up these files before using `make fclean`

---

## Checking Service Status

### View Running Containers
```bash
docker ps
```
You should see three containers:
- `mariadb` - Database service
- `wordpress` - PHP-FPM application
- `nginx` - Web server

### Check Logs

View all logs:
```bash
docker compose -f srcs/docker-compose.yml logs
```

View specific service logs:
```bash
docker compose -f srcs/docker-compose.yml logs wordpress
docker compose -f srcs/docker-compose.yml logs mariadb
docker compose -f srcs/docker-compose.yml logs nginx
```

### Verify Services Are Healthy

1. **Website is accessible**: Visit https://zchtaibi.42.fr
2. **Admin panel works**: Login to https://zchtaibi.42.fr/wp-admin
3. **Database connection**: If WordPress loads, the database is working

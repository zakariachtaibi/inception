
*This project has been created as part of the 42 curriculum by zchtaibi.*

# Inception

## Description
This project aims to broaden the knowledge of system administration by using Docker. It involves virtualizing several Docker images (Nginx, WordPress, MariaDB) in a personal virtual machine, orchestrating them with Docker Compose, and setting up a specific network and volume architecture.

## Instructions

### 1. Installation
Clone the repository to your virtual machine:
git clone <repository_url>
cd inception

### 2. Configuration

Create a .env file in the srcs/ directory to configure the environment variables. (Note: Do not commit this file to Git).

Required Variables:

    DOMAIN_NAME (zchtaibi.42.fr)

    DB_NAME, DB_USER, DB_PASSWORD, DB_ROOT_PASSWORD

    WP_ADMIN_USER, WP_ADMIN_PASSWORD, WP_ADMIN_EMAIL

    WP_USER, WP_USER_EMAIL, WP_USER_PASSWORD

### 3. Execution

Use the Makefile at the root of the repository to build and start the infrastructure:
```Bash
make
```
This command will build the Docker images and start the containers in detached mode.

### 4. Access

    Website: Open https://zchtaibi.42.fr in your browser.

    Admin Panel: https://zchtaibi.42.fr/wp-admin

(Note: You must accept the self-signed SSL certificate warning.)

## Project Architecture & Design Choices

# Virtual Machines vs Docker

    Virtual Machines (VMs): Emulate an entire computer system, including the hardware and a full Operating System. They are resource-heavy, slow to boot, and isolate the entire system.

    Docker: Uses containerization to share the host's OS kernel while isolating application processes in user space. Containers are lightweight, start almost instantly, and are highly portable compared to VMs.

# Secrets vs Environment Variables

    Environment Variables: Useful for configuration but can be insecure if sensitive data is exposed in logs or process inspections (docker inspect).

    Docker Secrets: Designed specifically for managing sensitive data (passwords, keys). They are encrypted at rest and mounted only into the containers that need them as files.

    Choice: In this project, we use Environment Variables via a .env file as explicitly required by the subject guidelines.

# Docker Network vs Host Network

    Host Network: The container shares the host's networking namespace. It offers no isolation, and ports typically conflict if multiple services need the same port.

    Docker Network (Bridge): Provides network isolation. Containers communicate with each other using internal DNS names (e.g., wordpress connects to mariadb:3306) without exposing internal ports to the outside world. Only the NGINX entrypoint (port 443) is exposed to the host.

# Docker Volumes vs Bind Mounts

    Bind Mounts: Map a specific file or directory on the host's filesystem to the container. They rely on the host's specific directory structure and file permissions.

    Docker Volumes: Managed entirely by Docker and stored in a part of the host filesystem owned by Docker. They are easier to back up, migrate, and are the preferred mechanism for persisting data in Docker.

## Resources

    Docker Documentation: Used for Dockerfile syntax and docker-compose configuration.

    AI Usage: AI assistance was used to clarify the theoretical differences between Docker network types and to help debug Nginx configuration syntax. All code generated was manually reviewed and tested.
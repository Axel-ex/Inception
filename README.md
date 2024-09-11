## Inception

This project aims to set up a containerized environment using Docker Compose to deploy three essential services: WordPress, MariaDB, and Nginx. The goal is to simulate a real-world web application environment by leveraging containerization, service orchestration, and network management.

By using Docker Compose, the project combines a WordPress CMS, backed by a MariaDB database, with an Nginx web server acting as a reverse proxy. This setup is designed to be lightweight, modular, and easy to maintain, while providing the benefits of isolation and scalability that containers offer.

## Implementation
### Services

#### 1. **WordPress**
   - The WordPress container is responsible for serving the web content. It uses environment variables defined in the `.env` file to configure the database connection and site settings.
   - It depends on MariaDB to manage the backend data for dynamic content.
   - The WordPress files are persisted using the `wordpress_volume` volume.

#### 2. **MariaDB**
   - The MariaDB container serves as the relational database management system, storing all the data required by the WordPress site.
   - Like WordPress, the configuration parameters for MariaDB (e.g., database name, user, and password) are passed through environment variables.
   - The database data is stored persistently using the `mariadb_volume` volume.

#### 3. **Nginx**
   - Nginx is configured as a reverse proxy, routing incoming traffic to the WordPress service.
   - It listens on port 443 to handle HTTPS traffic, making the application secure by default.
   - It also mounts the WordPress volume to access the static files directly.


### Docker network
A custom Docker network is defined to allow all containers to communicate with each other securely and efficiently.

### Volumes
Persistent storage is achieved using Docker volumes. Two volumes are mounted:
- **MariaDB Volume**: `/var/lib/mysql`, stores database data.
- **WordPress Volume**: `/var/www/html`, stores the WordPress files.
Both volumes are bound to local directories on the host machine. This ensures that data persists even if the containers are removed or restarted.

### Docker Compose

All the services are managed using a `docker-compose.yml` file, which defines how the services should interact with each other, and ensures automatic startup, restart policies, and network configuration. 

The key configuration for Docker Compose includes:
- **Service Dependencies**: WordPress depends on MariaDB, and Nginx depends on WordPress.
- **Network**: All services are part of the same `inception` network.
- **Restart Policies**: Services are set to always restart on failure or upon system reboots, ensuring high availability.

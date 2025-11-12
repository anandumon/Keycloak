# Keycloak on Render

This directory contains the necessary files to deploy Keycloak to Render.

## Files:

- `Dockerfile`: Defines the Docker image for Keycloak.
- `render.yaml`: Render Blueprint for deploying Keycloak and a PostgreSQL database.
- `.env.example`: Example environment variables for local development or reference.

## Deployment to Render

1.  **Create a new Blueprint instance on Render:**
    *   Go to your Render Dashboard.
    *   Click "New" -> "Blueprint".
    *   Connect your Git repository where these files are located.
    *   Render will automatically detect the `render.yaml` file.

2.  **Configure Environment Variables:**
    *   Render will prompt you to set environment variables. The `render.yaml` file defines most of them, including auto-generated passwords for the database and Keycloak admin.
    *   You can override these or add more as needed in the Render dashboard.

3.  **Build and Deploy:**
    *   Once configured, Render will build your Docker image using the `Dockerfile` and deploy the Keycloak service and PostgreSQL database.

## Local Development

For local development, you can use the `Dockerfile` to build and run Keycloak.

1.  **Build the Docker image:**
    ```bash
    docker build -t my-keycloak .
    ```
2.  **Run the Docker container:**
    ```bash
    docker run -p 8080:8080 -e KEYCLOAK_ADMIN=admin -e KEYCLOAK_ADMIN_PASSWORD=admin -e KC_HOSTNAME=localhost:8080 my-keycloak start-dev
    ```
    *   Adjust environment variables as needed, or use a `.env` file with `docker compose`.
    *   For a more robust local setup with a database, consider using `docker compose`.

3.  **Access Keycloak:**
    *   Open your browser and navigate to `http://localhost:8080`.
    *   Log in to the admin console using the `KEYCLOAK_ADMIN` and `KEYCLOAK_ADMIN_PASSWORD` you set.

## Important Notes:

*   **Security:** For production environments, ensure you use strong, randomly generated passwords and secure your Keycloak instance appropriately.
*   **Database:** The `render.yaml` sets up a PostgreSQL database managed by Render. For local development, you might need to set up a local PostgreSQL instance or use Keycloak's H2 database (for development purposes only).
*   **Hostname:** The `KC_HOSTNAME` and related `KC_HOSTNAME_STRICT` variables are configured for Render's environment. Adjust them if you are deploying to a different domain or locally.

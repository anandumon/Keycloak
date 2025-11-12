# ==========================================
# 🧩 Keycloak Deployment Dockerfile
# ==========================================

# Use a recent, official Keycloak image
FROM quay.io/keycloak/keycloak:23.0.7

# Set working directory
WORKDIR /opt/keycloak

# Set static environment variables for running in a production/proxy environment.
# Dynamic values like database credentials will be injected by Render.
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_PROXY=edge
ENV KC_DB=postgres

# Expose the port Keycloak listens on.
# This must match the KC_HTTP_PORT environment variable.
EXPOSE 8080

# Build an optimized Keycloak server image. This is a best practice for production.
RUN /opt/keycloak/bin/kc.sh build

# The command to run when the container starts.
# It starts Keycloak in production mode, using the optimized build.
ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start", "--optimized"]
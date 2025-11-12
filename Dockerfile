# ==========================================
# 🧩 Keycloak Deployment Dockerfile (Render)
# ==========================================

# Use a recent, official Keycloak image
FROM quay.io/keycloak/keycloak:23.0.7

# Set working directory
WORKDIR /opt/keycloak

# ==========================================
# ✅ Environment Configuration
# ==========================================
# These are safe defaults for running Keycloak behind Render’s HTTPS proxy
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_PROXY=edge
ENV KC_DB=postgres
ENV KC_DB_URL_HOST=${KC_DB_URL_HOST}
ENV KC_DB_URL_DATABASE=${KC_DB_URL_DATABASE}
ENV KC_DB_USERNAME=${KC_DB_USERNAME}
ENV KC_DB_PASSWORD=${KC_DB_PASSWORD}

# Required for Render (strict hostname fix)
ENV KC_HOSTNAME=${KC_HOSTNAME}
ENV KC_HOSTNAME_STRICT=false
ENV KC_HOSTNAME_STRICT_HTTPS=false

# Expose the HTTP port (matches KC_HTTP_PORT)
EXPOSE 8080

# ==========================================
# ✅ Build optimized Keycloak image
# ==========================================
RUN /opt/keycloak/bin/kc.sh build

# ==========================================
# ✅ Start Keycloak in production mode
# ==========================================
# The Render environment variable KC_HOSTNAME must be set to your public Render URL
# Example: KC_HOSTNAME=my-keycloak.onrender.com
ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start", "--optimized", "--hostname-strict=false", "--hostname-strict-https=false"]

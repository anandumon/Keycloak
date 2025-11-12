FROM quay.io/keycloak/keycloak:23.0.7

WORKDIR /opt/keycloak

# Enable health & metrics
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

# Expose HTTP port
EXPOSE 8080

# Build optimized Keycloak
RUN /opt/keycloak/bin/kc.sh build

# Start Keycloak in production mode with proper hostname flags
ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start", "--optimized", "--hostname-strict=false", "--hostname-strict-https=false"]

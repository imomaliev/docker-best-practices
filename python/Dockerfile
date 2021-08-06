FROM python:3.7.11-slim-buster

# Add user that will be used in the container.
RUN useradd --create-home app

# Set environment variables.
ENV PYTHONUNBUFFERED=1 \
    PYTHONIOENCODING=UTF-8 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

COPY install-from-bindep /usr/local/bin/
COPY bindep.txt /

# RUN apt-get update && apt-get install wkhtmltopdf -y
RUN set -eux \
    && pip install \
        pip==21.2.2 \
        bindep==2.9.0 \
    && install-from-bindep \
    # Check dependendcies
    && bindep \
    && :

WORKDIR /app
# Set this directory to be owned by the "app" user.
RUN chown -R app:app /app

# Install the project requirements.
RUN set -eux \
    && su app -c "python -m venv .venv" \
    && :

# Volume venv folder so that on mount it wouldn't get replaced
VOLUME ["/app/.venv"]

USER app

RUN echo "PATH=/app/.venv/bin:$PATH" > /home/app/.bashrc

COPY entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["app"]

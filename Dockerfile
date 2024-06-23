FROM python:3.11-alpine3.19
LABEL maintainer="Sohanuzzaman Soad"

# Set environment variables
ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

# Install dependencies
RUN python -m venv /opt/venv && \
    /opt/venv/bin/pip install --upgrade pip && \
    /opt/venv/bin/pip install -r /tmp/requirements.txt && \
    rm -rf /tmp && \
    adduser \
    --disabled-password \
    --no-create-home \
    django-user

# Switch to the non-root user
ENV PATH="/opt/venv/bin:$PATH"

USER django-user


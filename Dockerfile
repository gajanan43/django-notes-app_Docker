# Backend Dockerfile

FROM python:3.9-slim

# Set work directory
WORKDIR /app/backend

# Copy dependencies file
COPY requirements.txt .

# Install system dependencies and Python packages
RUN apt-get update && \
    apt-get install -y gcc default-libmysqlclient-dev pkg-config && \
    pip install --upgrade pip && \
    pip install mysqlclient && \
    pip install --no-cache-dir -r requirements.txt && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy the entire project
COPY . .

# Expose the application port
EXPOSE 8000

# Run database migrations automatically (optional)
# RUN python manage.py makemigrations && python manage.py migrate

# Run Django server
CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]

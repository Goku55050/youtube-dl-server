FROM python:3.13-slim

WORKDIR /usr/src/app

# Install dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY youtube_dl_server.py .

# Create a non-root user
RUN useradd -m python
USER python

# Expose the port (Render uses PORT env variable)
EXPOSE 8080

CMD ["sh", "-c", "python -m uvicorn youtube_dl_server:app --host 0.0.0.0 --port ${PORT:-8080}"]

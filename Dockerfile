# 1. Base Image: Use a minimal, official Linux distribution
FROM python:3.11-slim

# 2. Set environment variables to optimize Python execution
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# 3. Create and set the working directory inside the container
WORKDIR /app

# 4. Copy only the dependency file first to leverage Docker layer caching
COPY requirements.txt .

# 5. Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# 6. Copy the rest of the application code into the container
COPY . .

# 7. Security Best Practice: Create a non-root user to run the application
RUN adduser --disabled-password --gecos '' appuser
USER appuser

# 8. Define the network port the container will listen on
EXPOSE 8000

# 9. The default command to execute when the container starts
CMD ["python", "main.py"]

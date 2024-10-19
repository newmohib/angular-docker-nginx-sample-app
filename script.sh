#!/bin/bash

# Define the image name
IMAGE_NAME="angular-docker-nginx-sample-app"

# Find all container IDs associated with the image
CONTAINER_IDS=$(docker ps -a -q --filter ancestor="$IMAGE_NAME")

# Check if there are any containers to remove
if [ -n "$CONTAINER_IDS" ]; then
    # Stop and remove each container associated with the image
    echo "Stopping and removing containers for image: $IMAGE_NAME"
    docker stop $CONTAINER_IDS
    docker rm $CONTAINER_IDS
else
    echo "No containers found for image: $IMAGE_NAME"
fi

# Check if the Docker image exists
IMAGE_EXISTS=$(docker images -q "$IMAGE_NAME")

if [ -n "$IMAGE_EXISTS" ]; then
    # If the image exists, remove it
    echo "Removing image: $IMAGE_NAME"
    docker rmi "$IMAGE_NAME"
else
    echo "Image $IMAGE_NAME does not exist."
fi


# Build the Docker image
echo "Building the Docker image..."

docker build -t $IMAGE_NAME .

# Check if the build was successful
if [ $? -eq 0 ]; then
    echo "Image built successfully. Running the container..."

    # Run the Docker container
    docker run -p 3002:80 $IMAGE_NAME
else
    echo "Failed to build the Docker image."
    exit 1
fi

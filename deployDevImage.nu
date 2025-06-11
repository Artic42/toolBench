# Stop and delete the old container if its running
do -i {docker stop toolbenchDev}
do -i {docker rm toolbenchDev}

# Delete image before creating new overlay new 
do -i {docker rmi toolbench_dev}

# Create new image
docker build -t toolbench_dev .

# Start new container
docker run -itd -p 10022:22 --name toolbenchDev toolbench_dev

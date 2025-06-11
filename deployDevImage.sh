#!/usr/bin/sh
# Stop and delete the old container if its running
docker stop toolbenchDev
docker rm toolbenchDev

# Delete image before creating new overlay new 
docker rmi toolbench_dev

# Download personal config file to temp folder for build
mkdir -p dockerFiles/temp
git clone https://github.com/Artic42/NeoVim.git dockerFiles/temp/NeoVim
gcc dockerFiles/temp/NeoVim/isGit.c -o dockerFiles/temp/isGit.app


# Create new image
docker build -t toolbench_dev .

# Start new container
docker run -itd -p 10022:22 --name toolbenchDev --hostname ToolBenchDev toolbench_dev

# Remove temporal files created by the script
rm -rf dockerFiles/temp

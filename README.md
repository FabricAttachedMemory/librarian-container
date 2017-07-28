# librarian-container
files to create the Docker container to run the Librarian

Download either of the Dockerfiles and run "docker build -t ..."
Pre-built images and instructions on running the lib-container can be found on https://cloud.docker.com/swarm/mkubala7219/repository/docker/mkubala7219/librarian/general


If you are working outside of HPE's network, please comment out the ARG instructions and the RUN ...<proxy info for etc/environment and apt.conf>... instructions in your desired Dockerfile and replace it with your own proxy/network information

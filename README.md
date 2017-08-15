# librarian-container
These files are used to create the Docker container to run the Librarian

Download either of the Dockerfiles into a directory along with the script.sh file. If behind a firewall be sure to enter proxy information into the Dockerfiles or if not, remove the RUN echo and ARG commands. Then, from within the directory run "docker build -t <name of image> ." If using script.sh, make sure the file is executable.
  
Pre-built images and instructions on running the lib-container can be found on https://hub.docker.com/r/mmkala/lfs/ There are two tags for the image: proxy and no-proxy. Note: the pre-built images do not have the most updated version of the tm-librarian repository or tm-manifesting.

After the Docker image has completed building, do the following command "docker run -i -p 9093:9093 <name of image>". This will start the container, ask the user for information on how to setup the config files for the nodes and run the librarian. For further details and information on each command in the Dockerfile, please visit one of the websites above.

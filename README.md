# librarian-container
These files are used to create the Docker container to run the Librarian for Fabric Attached Memory Emulation

Docker is a tool used to create containers that can run programs. A container is similar to a VM, but uses the Host's OS, rather than running another OS on bare hardware. It's more lightweight, provides isolation for testing software and can be shared on Docker hub.

To run this Docker container, first install Docker on your system. This website has a great tutorial and goes in more depth of what a Docker container is: https://docs.docker.com/get-started/. Also, please install Fabric Attached Emulation(FAME) from another repo in the FabricAttachedMemory directory. This container works with it.

Steps:
1. Download a Dockerfile into a directory. Make sure the Dockerfile is named "Dockerfile" in the directory. This is the file docker uses to build the Librarian container. If you do not know how the Librarian works and would like the container to take care of the set up for you, download Dockerfile. If you understand how the Librarian works and would like to write the setup files and run the commands for the Librarian, download Dockerfile.2

-- If you downloaded the first Dockerfile, which is just called Dockerfile, download script.sh into the same directory as your Dockerfile. Make sure you change the permissions on script.sh to make it executable. As long as the user can execute the file, it should work. When developing the container, we ran the command: chmod 744 script.sh. You can skip the next part and go to Step 2.

-- If you downloaded Dockerfile.2, the process is a little different. You do not need to download script.sh. Go ahead to step 2.

2. Now you've downloaded the Dockerfile. Open the Dockerfile in a text editor on your system. You will notice there are lines for proxies. If you are behind a firewall you NEED to enter in your proxy information. Please enter them between the brackets. Do not change any other part of the line. Once you've entered the proxy information, delete the'<>' surrounding them. Please do the same for the lines that begin with "ARG". If you are not behind a firewall, either put '#' in front of each of those lines to comment it out or delete the lines completely from the Dockerfile. 

3. Save the Dockerfile, if you have made changes. Then, from within the directory run the command: "docker build -t name_of_image ." Notice the "." in the previous line is not a period to end a sentence. It is part of the command. This command tells docker to build an image from the directory you are in and to give it the name you specify in name_of_image. If the Dockerfile is written correctly, the container should build correctly.

-- Pre-built images and instructions on running the lib-container can be found on https://hub.docker.com/r/mmkala/lfs/ There are two tags for the image: proxy and no-proxy. Note: the pre-built images do not have the most updated version of the tm-librarian repository or tm-manifesting.

4. If you downloaded Dockerfile, run the command "docker run -i -p 9093:9093 <name of image>". This starts up the container, makes it interactive and maps port 9093 on your system to port 9093 in the docker container. The reason for the container being interactive is where script.sh comes in. This container will run script.sh and ask questions on how you would like to set up the environment for the Librarian. It will ask you if you have done this before, and if so, ask for the names of those files used for setup. If this is your first time go ahead and give the container information on how to proceed. Here are some examples for input to enter:
  
Name of .ini file: data.ini (Make sure you include ".ini"!!!!)

Name of .db file: data.db (Make sure you include ".db"!!!!)

Total Memory: 8M (M is for megabytes, G is for gigabytes, K is for kilobytes. Make sure you do the math to figure out how much to give each book!!)

Book for each node: 256B (B stands for book size bytes and relates to the amount of total memory you allocate)
  
  If you downloaded Dockerfile.2, run the command: "docker run -it -p 9093:9093 <name of image>". Because you will be setting up the container yourself you need the '-t' flag to tell docker to give you a terminal for the container. Once in the container, make sure the directory you are in has the tm-librarian repo. Make a file called whatever you want that follows the format of the .ini file to be used by book_register.py. Look at the tm-librarian repo to see the format and how to run the commands for the Librarian
  
5. Once the container has ran the librarian command, run a node from FAME. Run "cd /" and see that the directory lfs is lit up. If it is, the container was successful! Go ahead and start using the Librarian! If not, see that the versions of FAME and the Librarian are the same and make sure the info you entered for the .ini file is correct.

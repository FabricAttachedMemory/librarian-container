FROM bitnami/minideb:jessie 

#set the working directory to where the librarian files will be stored 
WORKDIR /librarian_image

#set up the proxy information in apt.conf and etc/environment 
# RUN echo "http_proxy=<http proxy> \nhttps_proxy=<https proxy>\nftp_proxy=<ftp proxy>" >> /etc/environment
# RUN echo "Acquire::http::proxy \"<http proxy>\"; Acquire::https::proxy \"<https proxy>\"; Acquire::ftp::proxy \"<ftp proxy>";" >> /etc/apt/apt.conf

#set build time proxy variables if you are behind a firewall
#ARG HTTP_PROXY=<http proxy>
#ARG HTTPS_PROXY=https proxy>

#expose ports for TCP and communication
EXPOSE 9093

#install git and any other packages needed, always use the -qy option
RUN apt-get update && \
    apt-get -qy install \
    git \
    python3 \
    procps

#Add the book_data/book_register/librarian automatic script to the workdir
COPY script.sh /librarian_image/ 


#pull the librarian from the FAME repo --> copy the librarian data into the container 
RUN git clone https://github.com/FabricAttachedMemory/tm-librarian.git 

#run script.sh on startup of the container
ENTRYPOINT ["./script.sh"] 

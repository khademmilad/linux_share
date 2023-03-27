FROM ubuntu

RUN apt-get update && \
    apt-get install -y git

RUN useradd -ms /bin/bash test

USER test
WORKDIR /home/test

RUN apt-get update && \
    apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg-agent \
        software-properties-common && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io && \
    curl -sSL https://github.com/docker/compose/releases/download/1.29.2/docker-compose-Linux-x86_64 -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose && \
    docker pull teddysun/v2raya && \
    docker run -d -p 8080:80 teddysun/v2raya && \
    docker ps | grep teddysun/v2raya | awk '{print $NF}' | cut -d '-' -f 2 | cut -d '>' -f 1

CMD ["bash"]

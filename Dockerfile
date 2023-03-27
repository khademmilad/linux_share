FROM ubuntu
RUN useradd -ms /bin/bash test
USER test
WORKDIR /home/test

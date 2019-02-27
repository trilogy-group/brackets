FROM phusion/baseimage:0.11

RUN apt-get update -y && \
    apt-get install -y bzip2 curl fontconfig git iputils-ping software-properties-common sudo tar telnet wget && \
    # Install NodeJS 8.x for UI Front-End build
    curl -sL https://deb.nodesource.com/setup_8.x | bash && \
    apt-get install -y nodejs && \
    apt-get clean all && \
    # Brackets specific dependencies
    npm install grunt-cli -g
    
WORKDIR /data

CMD tail -f /dev/null

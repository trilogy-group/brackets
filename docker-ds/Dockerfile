FROM ubuntu:18.04

LABEL   com.trilogy.company="DevFactory" \
        com.trilogy.team="Eng.DSImport" \
        com.trilogy.product="brackets" \
        com.trilogy.service="bracket" \
        com.trilogy.stage="dev" \
        com.trilogy.maintainer.skype="thien@aurea.com" \
        com.trilogy.maintainer.email="thien@aurea.com"
      
RUN apt-get update -y && \
    apt-get install telnet iputils-ping wget sudo fontconfig tar bzip2 -y && \
    apt-get install git -y && \
    apt-get clean

# Install NodeJS 8.x for UI Front-End build
RUN apt-get install curl software-properties-common -y && \
    curl -sL https://deb.nodesource.com/setup_8.x | bash && \
    apt-get install nodejs -y && \
    apt-get clean

# Brackets specific dependencies
RUN npm install grunt-cli -g
    
WORKDIR /data

CMD tail -f /dev/null

# Selenium with Google Chrome und PowerShell / Pester

## Create container

    sudo docker build --rm -t akaer/selenium-chrome-powershell . 2>&1 |tee docker_build.log

## Start Container

    sudo docker run --rm -d -e JAVA_OPTS=-Dwebdriver.chrome.whitelistedIps= -p 4444:4444 -p 5900:5900 --name se-chrome1 --hostname se-chrome1 --shm-size="2g" -v $(pwd)/data:/data akaer/selenium-chrome-powershell

HINT: Watch for the /data volume and correct the name

## Use Container

    sudo docker exec -it se-chrome1 /bin/bash

Enter container as above and start your scripts from /data

Powershell can be started by typing `pwsh`

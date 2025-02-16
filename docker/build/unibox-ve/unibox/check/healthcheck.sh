#! /bin/bash

checkAlive=`curl -k --silent --write-out "%{http_code}" --output /dev/null https://$HOSTNAME:8000/hw_proxy/status`

checkPos=`curl --silent --fail -k https://$HOSTNAME:8000/hw_proxy/status | grep -i escpos | sed -E -n 's/.*>(.*)<\/h3>/\1/p'  | awk '{print $3}'`

if [ "$checkAlive" == "200" ] && [ "$checkPos" == "connected" ]; then

    echo "Container is healthy"
    exit 0  # Контейнер здоровый

    else 
    
    echo "Container is unhealthy"
    exit 1  # Контейнер нездоровый
    
    fi
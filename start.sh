#!/bin/bash
cd ../bff-scan-tickets/
git pull 
#·docker build -t bff-scan-tickets .
cd ..
cd fe-scan-tickets 
git pull
#docker build -t fe-scan-tickets .
cd ..
cd platform-scan-tickets

docker-compose up --build -d --remove-orphans
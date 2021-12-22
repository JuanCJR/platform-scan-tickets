#!/bin/bash
cd ../bff-scan-tickets/
git pull 
docker build -t bff-scan-tickets .
cd ..
cd fe-scan-tickets 
git pull
docker build -t fe-scan-tickets .


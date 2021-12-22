#!/bin/bash
cd ../bff-scan-tickets/
docker build -t bff-scan-tickets .
cd ..
cd fe-scan-tickets 
docker build -t fe-scan-tickets .


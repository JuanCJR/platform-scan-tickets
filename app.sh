#!/bin/bash

option=$1
bffVersion=1.0.0
feVersion=1.0.0

build_app () {

    appName=$1
    appVersion=$2
    echo "Construyendo app  - $appName ..."
    cd ../$appName
    git pull 
    docker build -t $appName:$appVersion .
    cd ../platform-scan-tickets
    echo "Fin de construccion. app: $appName"
}

case $option in 
    "build")
        bffName="bff-scan-tickets"
        feName="fe-scan-tickets"

        build_app $bffName $bffVersion
        build_app $feName $feVersion
    
        echo "Build completado"
        ;;

    "start")
        echo "Inicializando app..."
        docker-compose up -d   
    ;;
    "stop")
        echo "Deteniendo app..."
        docker-compose stop
        ;;
    
    "status")
        docker-compose ps
        ;;
    "backup")
        echo "Reespaldando base de datos...";;
    
    "restore")
        echo "Restaurando base de datos...";;

    *) echo  "Parametros incorrectos";;
esac

    
#!/bin/bash

option=$1
bffVersion=1.0.0
feVersion=1.0.0
bkDir='bk'
dbHost=""
dbUser=""

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
        
        echo "Respaldando base de datos..."
        if [ -d "./$bkDir" ]; then
           echo "Existe dir bk"
        else
            mkdir $bkDir
            chmod 777 $bkDir
        fi

        cd "./$bkDir"
        echo "Ingresar datos de conexion a bd"       
        read -p "Host: " dbHost 
        read -p "Usuario: " dbUser
        pg_dump --column-inserts --data-only -U $dbUser -h $dbHost -p 5432 -F t ticketsdb > ticketsdb.tar
        ;;

    "restore")
        echo "Restaurando base de datos..."
        cd "./$bkDir"
        read -p "Host: " dbHost 
        read -p "Usuario: " dbUser
        pg_restore -h $dbHost -p 5432 -d ticketsdb -U $dbUser ticketsdb.tar
        ;;

    *) echo  "Parametros incorrectos";;
esac

    
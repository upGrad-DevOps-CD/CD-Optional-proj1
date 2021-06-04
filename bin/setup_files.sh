#!/bin/bash
set -eux 
echo "Dont run this script unless you have master zip files"
function file_found_or_error () {
    if [[ -f $1 ]];
     then
       echo "File found $1";
    else
      echo "File not found $1";
      exit 1;
    fi
}

function clean_dir () {
  if [[ -d $1 ]];
    then
     echo "Deleting $1"
     rm -rf "$1"
  else
    echo "$1 directory not present"   
  fi
}

echo "checking presence of code zip files"

for code_zip in upstac_ui.zip upstac-api-master.zip;
    do
        file_found_or_error "$code_zip";
    done    


echo "Deleting old directories"
for code_dir in upstac-api-master covid-track-ui-master;
  do
    clean_dir "$code_dir";
  done
  

echo "Extracting code in respective directories"

for code_zip in upstac_ui.zip upstac-api-master.zip;
    do
        unzip "$code_zip";
        file_found_or_error "$code_zip";
    done    




echo "Moving ui code to directory"
mv covid-track-ui-master\(1\)/covid-track-ui-master/ covid-track-ui-master/
rm -rf covid-track-ui-master\(1\)
#rm -rf covid-track-ui-master/node_modules
echo "Setting up Dockerfile for upstac-api-master"
cat <<HERE > upstac-api-master/Dockerfile
FROM maven:3.8.1-jdk-11 as builder
COPY . /build
WORKDIR /build
RUN mvn clean -Dmaven.test.skip package install spring-boot:repackage
FROM openjdk:11.0.11-jre
WORKDIR /app
COPY --from=builder /build/target/upstac-api-*.jar /app/upstac-api.jar
CMD ["java","-jar","upstac-api.jar"]
HERE


#sed -i 's/localhost/upstac-api/' covid-track-ui-master/src/environment.js
cat <<HERE > covid-track-ui-master/Dockerfile
FROM node:10 as builder
COPY . /app
WORKDIR /app
RUN npm install && yarn build 
FROM nginx
COPY --from=builder /app/build/ /usr/share/nginx/html
HERE

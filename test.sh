#!/bin/bash

set -e

exitCode=0

echo "--> Building image"
docker build -t nginx-www-redirect:dev .

echo "--> Starting it in the background"
docker rm -f nginx-www-redirect
docker run --rm -d -p 8080:80 --name nginx-www-redirect nginx-www-redirect:dev
sleep 5

echo "--> Testing 301 response"
if curl -v -H 'Host: www.example.com' http://127.0.0.1:8080/ 2>&1 | grep "< Location: http://example.com/"; then
  echo "PASS"
else
  echo "FAIL"
  exitCode=1
fi

echo "--> Testing 404 response"
if curl -v -H 'Host: example.com' http://127.0.0.1:8080/ 2>&1 | grep "< HTTP/1.1 404 Not Found"; then
  echo "PASS"
else
  echo "FAIL"
  exitCode=1
fi

echo "--> Killing container"
docker rm -f nginx-www-redirect

echo "--> Done (exiting with $exitCode)"
exit $exitCode

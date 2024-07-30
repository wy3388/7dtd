#!/bin/bash

docker rm -f 7dtd && docker rmi 7dtd:1.0 && docker build -t 7dtd:1.0 . && docker run -it -e MODE=START -v ./data:/data --name 7dtd 7dtd:1.0
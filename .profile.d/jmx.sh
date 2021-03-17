#!/bin/bash

wget https://c.jun6.net/ZFILE/zfile-release.jar
java -Dfile.encoding=utf-8 -jar -Dserver.port=5000 zfile-release.jar

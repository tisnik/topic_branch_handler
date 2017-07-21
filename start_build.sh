#!/usr/bin/env bash

#Accepts 1 args, params:
# 1st - job name

curl -v -X POST "http://`hostname`:8080/job/$1/build"



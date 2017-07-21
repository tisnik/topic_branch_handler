#!/usr/bin/env bash

#Accepts 1 args, params:
# 1st - job name

function deleteJob {
	curl -X POST -H "Content-Type:text/xml" "http://`hostname`:8080/job/${1}/doDelete" > /dev/null 2>&1
}

function main {
	deleteJob ${1}
}

main ${1}


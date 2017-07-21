#!/usr/bin/env bash

#Accepts 3 args
# 1st - branch (e.g. */master)
# 2nd - book name
# 3rd - repo URL
# 4th - build script

WORK_DIR=`mktemp -d`

TEMPLATE="template.xml"

#Path to the directory where script is.
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function prepareDir {
	cd ${WORK_DIR}
	mkdir job
}

function createConfig {
	cd ${SCRIPT_DIR}
	XML_FILE=`cat ${TEMPLATE}`

	cd "${WORK_DIR}/job"
	printf "${XML_FILE}" "${1}" "${2}" "${3}" > config.xml
	cd ..
}

function createJob {
	cd job
	curl -X POST -H "Content-Type:application/xml" -d @config.xml "http://`hostname`:8080/createItem?name=${1}" > /dev/null 2>&1
	cd ..
}

function removeDir {
	rm -rf ${WORK_DIR}
}

function main {
	prepareDir
	createConfig "${3}" "${1}" "${4}"
	createJob "${2}"
	removeDir
}

main "${1}" "${2}" "${3}" "${4}"


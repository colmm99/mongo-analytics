#!/bin/bash
#
# Export Mongodb to Make Generate Some Analysis
#

MONGO_SERVER=${1-"localhost"}
MONGOG_DB=${2-"DB_1"}
EXPORT_FILE=${3-export.csv}

# Delete previous Export
if [ -f ${EXPORT_FILE} ];then
   rm -rf ${EXPORT_FILE}
fi

# Make Sure Mongo Client is Installed before running
if [ ! -f /usr/bin/mongoexport ];then
	echo "Mongo Client not installed, it's required"
	exit 1
fi


# Iterate through the collections
for COLLECTION in $(cat ./collections.txt)
do
	/usr/bin/mongoexport -h ${MONGO_SERVER} --db ${MONGOG_DB} --collection ${COLLECTION} -csv --fieldFile fields.txt --query '{ "Status": "OK" }'  >> ${EXPORT_FILE} 
done

#!/bin/sh
endpoint=s3.us-south.cloud-object-storage.appdomain.cloud
bucket_name=cos-standard-26y
object_key=dataset4.csv
content_type='text/csv'

resource_instance_id="crn:v1:bluemix:public:cloud-object-storage:global:a/645098ca282e44de9672597dc96a6f86:8c6f8fe4-a745-4517-bfa5-770c07a55385::"

API_KEY=vYZbrdpToaGRzGLY3F_TbeSbkDglgfodCrx5FkyEwFqz

token_data=$(curl -X "POST" "https://iam.cloud.ibm.com/identity/token" \
     -H 'Accept: application/json' \
     -H 'Content-Type: application/x-www-form-urlencoded' \
     --data-urlencode "apikey=$API_KEY" \
     --data-urlencode "response_type=cloud_iam" \
     --data-urlencode "grant_type=urn:ibm:params:oauth:grant-type:apikey")

access_token=$(python read_access_token.py "$token_data")

#echo $token_data
#echo "token****"
#echo $access_token

curl -X "PUT" "https://$endpoint/$bucket_name/$object_key" \
 -H "Authorization: bearer $access_token" \
 -H "Content-Type: $content_type" \
 --data-binary @dataset4.csv

echo "file uploaded",$(date +"%Y-%m-%d %T")

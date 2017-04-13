#!/bin/sh
CURRENT_READUNIT=2
CURRENT_WRITEUNIT=1

EP="--endpoint-url http://dynamodb:8000"

aws dynamodb --region us-east-1 create-table --table-name test-local --attribute-definitions AttributeName=consumer_id,AttributeType=S \
    AttributeName=event_id,AttributeType=N AttributeName=log_id,AttributeType=S \
    --key-schema AttributeName=log_id,KeyType=HASH \
    --global-secondary-indexes \
       IndexName=event_id-index,Projection={ProjectionType=ALL},ProvisionedThroughput="{ReadCapacityUnits=${CURRENT_READUNIT},WriteCapacityUnits=${CURRENT_WRITEUNIT}}",KeySchema=["{AttributeName=event_id,KeyType=HASH}"] \
       IndexName=consumer_id-index,Projection={ProjectionType=ALL},ProvisionedThroughput="{ReadCapacityUnits=${CURRENT_READUNIT},WriteCapacityUnits=${CURRENT_WRITEUNIT}}",KeySchema=["{AttributeName=consumer_id,KeyType=HASH}"] \
    --provisioned-throughput ReadCapacityUnits=${CURRENT_READUNIT},WriteCapacityUnits=${CURRENT_WRITEUNIT} $EP

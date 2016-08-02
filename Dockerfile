FROM java:8-jre

RUN mkdir /var/dynamodb /var/db
WORKDIR /var/dynamodb

RUN apt-get update && \
    apt-get install -y wget && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean && \
    wget -O /var/dynamodb/dynamodb_local_latest \
        http://dynamodb-local.s3-website-us-west-2.amazonaws.com/dynamodb_local_latest && \
    tar xfz /var/dynamodb/dynamodb_local_latest

EXPOSE 8000

# NOTE: Use -sharedDb flag so that the dynamodb tables are agnostic to the hostname.
ENTRYPOINT ["/usr/bin/java", "-Djava.library.path=.", "-jar", "DynamoDBLocal.jar", "-dbPath", "/var/db", "-sharedDb"]

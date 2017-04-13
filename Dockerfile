FROM java:8-jre

RUN mkdir /var/dynamodb /var/db
WORKDIR /var/dynamodb

RUN wget -O /var/dynamodb/dynamodb_local_latest.tar.gz \
        https://s3-us-west-2.amazonaws.com/dynamodb-local/dynamodb_local_latest.tar.gz && \
    tar xfz /var/dynamodb/dynamodb_local_latest.tar.gz && \
    rm /var/dynamodb/dynamodb_local_latest.tar.gz

EXPOSE 8000

# NOTE: Use -sharedDb flag so that the dynamodb tables are agnostic to the hostname.
ENTRYPOINT ["/usr/bin/java", "-Djava.library.path=.", "-jar", "DynamoDBLocal.jar", "-dbPath", "/var/db", "-sharedDb"]

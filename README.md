# Vungle Mock DynamoDB image
Hub: `vungle/dynamodb`

Vungle Mock DynamoDB image allows you to create a dynamodb service running in
Docker with a configured set of tables on your custom image.

To create a custom image with your set of tables, you should first create
`tables.conf` following the format in `example-tables.conf` file. Then, run:

    make run with-tables SUBPROJECT_IMAGE=vungle/adserver:dynamodb-service

This will create a Docker image, `vungle/adserver:dynamodb-service`, that
contains the tables you specified in `tables.conf` on your local Docker daemon.
You can push this image to Docker Hub by running:

    docker push vungle/adserver:dynamodb-service

To run DynamoDB without creating any tables, you can simply run:

    docker run -d -p 8000:8000 vungle/dynamodb
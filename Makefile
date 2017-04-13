ifndef BUILD_SCOPE
BUILD_SCOPE=dev
endif

PROJECT_IMAGE=vungle/dynamodb

build:
	@docker build . -t $(PROJECT_IMAGE)

publish:
	@docker push $(PROJECT_IMAGE)

DYNAMODB_CONTAINER=$(BUILD_SCOPE)_dynamodb_local
run:
	@docker run -d -p 8000:8000 --name $(DYNAMODB_CONTAINER) \
	$(PROJECT_IMAGE)

clean:
	@docker rm $$(docker kill $(DYNAMODB_CONTAINER))

build-tables:
	@docker run --rm \
	-v `pwd`/scripts/maketables.sh:/usr/local/bin/maketables.sh \
	--link $(DYNAMODB_CONTAINER):dynamodb \
	--entrypoint /usr/local/bin/maketables.sh \
	vungle/awscli
	@docker commit $(DYNAMODB_CONTAINER) $(SUBPROJECT_IMAGE)

with-tables:
	@docker run --rm \
	-v `pwd`/scripts/createdb:/usr/local/bin/createdb \
	-v `pwd`/tables.conf:/etc/dynamodb/tables.conf \
	--link $(DYNAMODB_CONTAINER):dynamodb \
	--entrypoint /usr/local/bin/createdb \
	vungle/awscli
	@docker commit $(DYNAMODB_CONTAINER) $(SUBPROJECT_IMAGE)

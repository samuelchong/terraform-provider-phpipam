PROVIDER_NAME = phpipam
BIN_DIRECTORY   = _bin
DEV_BIN_DIRECTORY = _bin
LOCAL_BIN_DIRECTORY = /usr/local/bin
EXECUTABLE_NAME = terraform-provider-$(PROVIDER_NAME)

test:
	go test -v $(shell go list ./... | grep -v /vendor/) 

testacc:
	TF_ACC=1 go test -v ./plugin/providers/phpipam -run="TestAcc"

build: deps
	gox -osarch="linux/amd64 windows/amd64 darwin/amd64" \
	-output="pkg/{{.OS}}_{{.Arch}}/terraform-provider-phpipam" .

release: release_bump release_build

release_bump:
	scripts/release_bump.sh

release_build:
	scripts/release_build.sh

deps:
	go get -u github.com/mitchellh/gox

clean:
	rm -rf pkg/

# Peform a LOCAL development (current-platform-only) build.
local: version fmt
	go build -o $(LOCAL_BIN_DIRECTORY)/$(EXECUTABLE_NAME)

# Peform a development (current-platform-only) build.
dev: version fmt
	go build -o $(DEV_BIN_DIRECTORY)/$(EXECUTABLE_NAME)

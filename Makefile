TAG?=$(shell git rev-list HEAD --max-count=1 --abbrev-commit)
export TAG

test:
   go test ./...

build:
   go build -ldflags "-X main.version=$(TAG)" -o news .

pack: build
	sudo docker build -t sample/news-service:$(TAG) .

tag:
	sudo docker tag sample/news-service sisimogangg/sample/news-service:$(TAG)

push:
	sudo docker push sample/news-service  
TAG?=$(shell git rev-list HEAD --max-count=1 --abbrev-commit)

export TAG

build:
	go build -ldflags "-X main.version=$(TAG)" -o news .

pack: build
	sudo docker build -t sample/news-service:$(TAG) .

run:
	sudo docker run -d -p 3333:3000 --name go-app-container sample/news-service:$(TAG)

tag:
	sudo docker tag sample/news-service:$(TAG) sisimogangg/sample/news-service:$(TAG)

push:
	sudo docker push sisimogangg/sample/news-service:$(TAG)  
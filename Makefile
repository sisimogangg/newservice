TAG?=$(shell git rev-list HEAD --max-count=1 --abbrev-commit)

export TAG

build:
	go build -ldflags "-X main.version=$(TAG)" -o news .

pack: build
	sudo docker build -t news-service:$(TAG) .

run:
	sudo docker run -d -p 3333:3000 --name go-app-container news-service:$(TAG)

tag:
	sudo docker tag news-service:$(TAG) sisimogangg/news-service:$(TAG)

push:
	sudo docker push sisimogangg/news-service
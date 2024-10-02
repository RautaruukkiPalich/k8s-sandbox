.PHONY: run

run: stage1 stage2 stage3

API_IMAGE := "api:v0.0.3"
BACKEND_IMAGE := "backend:v0.0.3"

stage1:
	docker build -t $(API_IMAGE) -t "api:latest" -f dockerfiles/api.dev.Dockerfile .
	docker build -t $(BACKEND_IMAGE) -t "backend:latest" -f dockerfiles/backend.dev.Dockerfile .

stage2:
	kubectl apply -f k8s/deployments/deployment.api.dev.yaml
	kubectl apply -f k8s/deployments/deployment.backend.dev.yaml

stage3:
	kubectl apply -f k8s/ingress/ingress.api.dev.yaml
	kubectl apply -f k8s/ingress/ingress.backend.dev.yaml



########################

docker-build:
	docker build -t myapp .

docker-run:
	docker run myapp

k8s-run:
	kind load docker-image myapp:latest

# path to config file
k8s-apply:
	kubectl apply -f config.yaml

# port forward
k8s-ports:
	kubectl port-forward $(pod_name) $(outer):$(inner)

# make k8s-ports pod_name=myapp-bdf5c945c-wcf9x outer=9000 inner=9000
# k9s


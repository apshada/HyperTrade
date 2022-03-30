NAMESPACE=hypertrade

dev:
	scripts/prepare.sh development
	skaffold dev --profile=development --tail

stop:
	minikube stop

build:
	scripts/prepare.sh production
	skaffold build --profile production

prod:
	scripts/prepare.sh production
	skaffold run --profile production

connect:
	doctl kubernetes cluster kubeconfig save $(NAMESPACE)-cluster
	kubectl port-forward svc/proxy 8080:8080 --namespace=$(NAMESPACE)

disconnect:
	doctl kubernetes cluster kubeconfig remove $(NAMESPACE)-cluster

delete:
	kubectl delete --all deployments
	minikube delete

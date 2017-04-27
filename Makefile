ORG ?= dxdung
FLUENTD_VERSION ?= 0.14.12

.PHONY:	build
build:
	docker build --build-arg FLUENTD_VERSION=${FLUENTD_VERSION} -t $(ORG)/fluentd-dit:$(FLUENTD_VERSION) ./image

.PHONY:	push
push:
	docker push $(ORG)/fluentd-dit:$(FLUENTD_VERSION)

.PHONY:	destroy
destroy:
	cat k8s/fluentd-dit-ds.yaml | sed -e "s/dxdung/$(ORG)/g" -e "s/0.14.12/$(FLUENTD_VERSION)/g" | kubectl delete --namespace=default -f - --kubeconfig=k8s/k8s-core-credentials.yaml

.PHONY:	deploy
deploy:
	cat k8s/fluentd-dit-ds.yaml | sed -e "s/dxdung/$(ORG)/g" -e "s/0.14.12/$(FLUENTD_VERSION)/g" | kubectl create --namespace=default -f - --kubeconfig=k8s/k8s-core-credentials.yaml

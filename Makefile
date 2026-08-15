.PHONY: syntax lint check
syntax:
	KAFKA_CLUSTER_ID=example-cluster-id-123456 ansible-playbook playbooks/site.yml --syntax-check
	KAFKA_CLUSTER_ID=example-cluster-id-123456 ansible-playbook playbooks/rolling-update.yml --syntax-check
lint:
	ansible-lint --offline playbooks/*.yml
	shellcheck scripts/*.sh
check: syntax lint

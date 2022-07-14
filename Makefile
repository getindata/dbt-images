build-gcp:
	docker build --target gcp-image -t dbt-base .  

.PHONY: build-gcp
build-gcp:
	docker build --target gcp -t dbt-image:gcp .  

build-aws:
	docker build --target aws -t dbt-image:aws .  

build-base:
	docker build --target base -t dbt-image:base .

.PHONY: build-gcp build-aws build-base
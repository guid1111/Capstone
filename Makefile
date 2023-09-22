
install:
	# Install the .NET 6.0 SDK - required to build .NET code.
	./dotnet-install.sh --channel 6.0
	# Install hadolint - note if not using Linux a different installation method may be required.
	wget -O hadolint https://github.com/hadolint/hadolint/releases/download/v1.16.3/hadolint-Linux-x86_64 
	chmod +x hadolint	

release_build_and_lint:
	dotnet build Capstone.sln --configuration Release
    
test:
	# Run all tests in all projects in the solution	
	dotnet test Capstone.sln --configuration Release

lint:
	# See local hadolint install instructions:   https://github.com/hadolint/hadolint
	# This is linter for Dockerfiles
	hadolint Dockerfile	

	

destroy_environment:
	eksclt delete cluster -f eksctl_cluster_config.yml -disable-nodegroup-eviction

docker_build:
	cd OptionPricer
	docker build -t guid1111/optionpricer .

docker_publish:
	#How to do versioning?
	docker push guid1111/optionpricer

docker_update:
	#Rolling update given existing deployment?
	#aws emr describe-cluster --cluster-id option-pricer-cluster
	# aws emr list-clusters
	kubectl set image deployments/<deployment> <deployment>=guid1111/optionpricer=guid1111/optionpricer:v2

kubernetes_run:
	kubectl run capstonedeployment --image=guid1111/optionpricer


create_cluster:
	eksctl create cluster -f eksctl_cluster_config.yml

deploy_app_to_cluster:
	kutctl apply -f deployment-manifest.yml
	kubctl apply -f service-manifest.yml

all: install lint release_build_and_lint test




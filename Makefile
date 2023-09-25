install:
	# Install the .NET 6.0 SDK - required to build .NET code.
	./Scripts/dotnet-install.sh --channel 6.0
	# Install hadolint - note if not using Linux a different installation method may be required.
	wget -O hadolint https://github.com/hadolint/hadolint/releases/download/v1.16.3/hadolint-Linux-x86_64 
	chmod +x hadolint	

build:
	dotnet build Capstone.sln --configuration Release
    
test:
	# Run all tests in all projects in the solution	
	dotnet test Capstone.sln --configuration Release

lint:
	# See local hadolint install instructions:   https://github.com/hadolint/hadolint
	hadolint OptionPricer/Dockerfile	

create-cluster:
	eksctl create cluster -f eksctl_cluster_config.yml

destroy-cluster:
	eksctl delete cluster -f eksctl_cluster_config.yml --disable-nodegroup-eviction

docker-build:
	cd OptionPricer
	docker build -t guid1111/optionpricer .

docker-run-local:
	#expose port 80 on this host and forward traffic there to port 8000 on the running docker container - so app is available on port 80
	docker run -p 80:8000 guid1111/optionpricer

docker-publish:	
	docker push guid1111/optionpricer

kubernetes-run:
	kubectl run capstonedeployment --image=guid1111/optionpricer

deploy-app-to-cluster:
	kutctl apply -f deployment-manifest.yml
	kubctl apply -f service-manifest.yml

all: install lint release_build_and_lint test




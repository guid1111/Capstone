FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-environment

WORKDIR /app

# Copy the project file from local to container, and restore dependencies using NUTGET.
COPY *.csproj ./
RUN dotnet restore

# Copy files and build Release Configuratoin
COPY . ./
RUN dotnet publish -c Release -o bin

# Runtime image - just use aspnet runtime for container and not full sdk.
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app

# This says nothing about the host - it is just the container.
# It doesn't say how the host port maps on to the container port.  For that you need: "docker run -p <HOSTPORT>:8000 imagename"
EXPOSE 8000
COPY --from=build-environment /app/bin .
ENTRYPOINT [ "dotnet", "OptionPricer.dll" ]




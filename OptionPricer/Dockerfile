FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-environment

WORKDIR /app

# Copy the project file from local to container, and restore dependencies using NUTGET.
COPY *.csproj ./
RUN dotnet restore

# Copy files and build
COPY . ./
RUN dotnet publish -c Release -o bin

# Runtime image - just use aspnet runtime for container and not full sdk.
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
EXPOSE 80
COPY --from=build-environment /app/bin .
ENTRYPOINT [ "dotnet", "OptionPricer.dll" ]




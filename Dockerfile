# Get base SDK Image from Microsoft
FROM mcr.Microsoft.com/dotnet/sdk:3.1 AS build-env
WORKDIR /app

# Copy the .CSPROJ file and restore dependencies(via NUGET)
COPY *.csproj ./
RUN dotnet restore

# Copy the project files and build our release
COPY . ./
RUN dotnet publish -c Release -o out

# Generate runtime Image
FROM mcr.Microsoft.com/dotnet/sdk:3.1
WORKDIR /app
EXPOSE 8000
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet","DOCKER_COREAPI.dll"]
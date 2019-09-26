FROM mcr.microsoft.com/dotnet/core/aspnet:2.2-stretch-slim AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/core/sdk:2.2-stretch AS build
# Install Nodejs
RUN apt-get install --yes curl
RUN curl --silent --location https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install --yes nodejs

# Restore .NET dependencies
WORKDIR /src
COPY ["src/docker-aspnetcore-react.csproj", "src/"]
RUN dotnet restore "src/docker-aspnetcore-react.csproj"

# Restore NPM dependencies
COPY ["src/ClientApp/package.json", "src/ClientApp/"]
COPY ["src/ClientApp/package-lock.json", "src/ClientApp/"]
WORKDIR /src/src/ClientApp
RUN npm install

# Copy Source code and Build
WORKDIR /src
COPY . .
WORKDIR "/src/"
RUN dotnet build "docker-aspnetcore-react.sln" -c Release -o /app

FROM build AS test
WORKDIR /src
ENTRYPOINT ["dotnet", "test", "--logger:trx", "--results-directory", "/testsresults"]

FROM build AS publish
RUN dotnet publish "docker-aspnetcore-react.sln" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "docker-aspnetcore-react.dll"]
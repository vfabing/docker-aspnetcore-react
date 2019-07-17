FROM mcr.microsoft.com/dotnet/core/aspnet:2.2-stretch-slim AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/core/sdk:2.2-stretch AS build
WORKDIR /src
COPY ["docker-aspnetcore-react.csproj", ""]
RUN dotnet restore "docker-aspnetcore-react.csproj"
COPY . .
WORKDIR "/src/"
RUN dotnet build "docker-aspnetcore-react.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "docker-aspnetcore-react.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "docker-aspnetcore-react.dll"]
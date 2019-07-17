# docker-aspnetcore-react

## Install dotnetcore-sdk
`choco install dotnetcore-sdk`

`dotnet --version`

```cmd
2.2.301
```

## Create aspnetcore react app
`dotnet new react --force`

`dotnet run`

## Add Docker
Visual Studio version 16.1.6

`docker build -t aspnetcore-react .`

## Run the container
`docker run -it --rm -p 5000:80 aspnetcore-react:latest`

`explorer http://localhost:5000`

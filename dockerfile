# Etapa de build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copie o arquivo csproj e restaure as dependências
COPY *.csproj ./
RUN dotnet restore

# Copie o restante dos arquivos e faça o build
COPY . ./
RUN dotnet publish -c Release -o out

# Etapa de runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/out .

# Exponha a porta que a aplicação irá usar
EXPOSE 80

# Comando para rodar a aplicação
ENTRYPOINT ["dotnet", "RPG API.dll"]

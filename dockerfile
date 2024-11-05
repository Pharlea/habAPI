# Etapa 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /app

# Copiar o arquivo .csproj e restaurar dependências
COPY *.csproj ./
RUN dotnet restore

# Publicar a aplicação
COPY . ./
RUN dotnet publish -c Release -o out

# Etapa 2: Criar a imagem final
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

# Copiar os arquivos publicados do build
COPY --from=build-env /app/out .

# Expor a porta em que a aplicação vai rodar
EXPOSE 80

# Definir o comando para iniciar a aplicação
ENTRYPOINT ["dotnet", "RPG_API.dll"]

# Etapa de build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /app

# Copia o .csproj e restaura dependências
COPY *.csproj ./
RUN dotnet restore

# Copia o restante dos arquivos e compila
COPY . ./
RUN dotnet publish -c Release -o out

# Etapa de runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build-env /app/out .

# Expõe a porta em que a aplicação ASP.NET Core escuta
EXPOSE 80

# Comando para iniciar a aplicação
ENTRYPOINT ["dotnet", "habAPI.dll"]

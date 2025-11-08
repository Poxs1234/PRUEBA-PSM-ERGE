# Etapa 1: Construcción
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copia el archivo del proyecto y restaura dependencias
COPY *.csproj .
RUN dotnet restore

# Copia todo el código fuente
COPY . .

# Construye y publica la aplicación
RUN dotnet publish -c Release -o /app/publish

# Etapa 2: Runtime (imagen más liviana)
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

# Copia los archivos publicados desde la etapa de build
COPY --from=build /app/publish .

# Expone el puerto que usará la aplicación
EXPOSE 8080

# Variable de entorno para el puerto
ENV ASPNETCORE_URLS=http://*:8080

# Comando para ejecutar la aplicación
ENTRYPOINT ["dotnet", "PROYECTOMOVIE.dll"]
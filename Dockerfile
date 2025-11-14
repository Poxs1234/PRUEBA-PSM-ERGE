# Build stage
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# Copia el proyecto y restaura (copia todo para mayor compatibilidad)
COPY . .
RUN dotnet restore
RUN dotnet publish -c Release -o /app

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS runtime
WORKDIR /app
COPY --from=build /app ./

# Puerto por defecto y binding
ENV PORT=80
ENV ASPNETCORE_URLS=http://+:${PORT}

EXPOSE 80

# Ejecuta el assembly de tu proyecto
ENTRYPOINT ["dotnet", "PROYECTOMOVIE.dll"]

FROM mcr.microsoft.com/dotnet/sdk:6.0-focal AS build
WORKDIR /src

COPY keen_yearling.csproj ./
RUN dotnet restore

COPY . .
RUN dotnet publish keen_yearling.csproj -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 AS runtime
WORKDIR /app
COPY --from=build /app ./

ENTRYPOINT ["dotnet", "keen_yearling.dll"]
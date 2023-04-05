FROM mcr.microsoft.com/dotnet/aspnet:6.0-focal AS base
WORKDIR /app
EXPOSE 80
FROM mcr.microsoft.com/dotnet/sdk:6.0-focal AS build
WORKDIR /src
COPY ["keen_yearling.csproj", "./"]
RUN dotnet restore "./keen_yearling.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "keen_yearling.csproj" -c Release -o /app/build
FROM build AS publish
RUN dotnet publish "keen_yearling.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "keen_yearling.dll"]
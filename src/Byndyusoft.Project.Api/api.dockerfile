FROM mcr.microsoft.com/dotnet/sdk:5.0 as build
COPY ./src ./src
WORKDIR /src/Byndyusoft.Project.Api
RUN dotnet publish -o /out -c Release


FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app
COPY --from=build /out .
ENTRYPOINT ["dotnet", "Byndyusoft.Project.Api.dll"]

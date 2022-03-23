FROM mcr.microsoft.com/dotnet/sdk:3.1 as build
COPY ./src ./src
WORKDIR /src/Byndyusoft.Project.Worker
RUN dotnet publish -o /out -c Release

FROM mcr.microsoft.com/dotnet/runtime:3.1
WORKDIR /app
COPY --from=build /out .
ENTRYPOINT ["dotnet", "Byndyusoft.Project.Worker.dll"]

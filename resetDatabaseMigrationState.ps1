$rootPath = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
$rootPath = Resolve-Path -Path $rootPath\.. 
Set-Location $rootPath
  
$migrationsPath = Join-Path -Path $rootPath -ChildPath "src/SAC.Infrastructure/Persistence/Migrations" 
$webPath = Join-Path -Path $rootPath -ChildPath "src/SAC.Web"
$infrastructurePath = Join-Path -Path $rootPath -ChildPath "src/SAC.Infrastructure"

#Remove the migration files
Remove-Item $migrationsPath\* -Include *.cs

#Remove the database
Remove-Item $webPath\app.db


dotnet ef migrations add "InitialMigration" --project $infrastructurePath --startup-project $webPath --output-dir $migrationsPath
dotnet ef database update --project $infrastructurePath --startup-project $webPath


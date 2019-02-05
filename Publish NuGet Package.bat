:: search for msbuild (old C#) and make it available
:: set bb.build.msbuild.exe=
:: for /D %%D in (%SYSTEMROOT%\Microsoft.NET\Framework\v4*) do set msbuildPath=%%D
:: set PATH=%PATH%;%msbuildPath%

:: search for msbuild C# 6.0+ and make it available
set msbuildPath=%ProgramFiles(x86)%\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin\
set PATH=%PATH%;%msbuildPath%

:: make sure we have a clean release build
msbuild /t:Rebuild /p:Configuration=Release /p:Platform="Any CPU" OpenTK.sln

:: remove any existing nupkg files
del *.nupkg

:: build the nuget packages
.nuget\nuget pack Source\OpenTK\OpenTK.csproj -Properties Configuration=Release
.nuget\nuget pack Source\GLControl\OpenTK.GLControl.csproj -Properties Configuration=Release

:: upload the nuget packages
.nuget\nuget push AdamsLair.OpenTK.*.nupkg -Source "https://www.nuget.org"
:: The above implies the GLControl one
::.nuget\nuget push AdamsLair.OpenTK.GLControl.*.nupkg -Source "https://www.nuget.org"

:: remove nupkg files after uploading them
del *.nupkg

pause
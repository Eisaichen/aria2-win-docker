# Download Aria2

.\wget --no-hsts -q "https://github.com/aria2/aria2/releases/download/release-$env:GH_CI_TAG/aria2-$env:GH_CI_TAG-win-64bit-build1.zip" -O .\aria2-$env:GH_CI_TAG-win-64bit-build1.zip
Expand-Archive -Path .\aria2-$env:GH_CI_TAG-win-64bit-build1.zip -DestinationPath .
Move-Item -Path .\aria2-1.37.0-win-64bit-build1 -Destination .\build\aria2
Copy-Item -Path .\entry.ps1 -Destination .\build\aria2


# Download AriaNG

.\wget --no-hsts -q "https://github.com/mayswind/AriaNg/releases/download/1.3.10/AriaNg-1.3.10.zip" -O .\AriaNg-1.3.10.zip
Expand-Archive -Path .\AriaNg-1.3.10.zip -DestinationPath .\build\AriaNg
$a = (Get-Content -Path .\build\AriaNg\js\aria-ng-ff0f4540ce.min.js) -replace ',rpcHost:"",rpcPort:"6800",rpcInterface:"jsonrpc",protocol:"http",httpMethod:"POST",rpcRequestHeaders:"",secret:"",',',rpcHost:"",rpcPort:"6800",rpcInterface:"jsonrpc",protocol:"ws",rpcRequestHeaders:"",secret:"",'
Set-Content -Path .\build\AriaNg\js\aria-ng-ff0f4540ce.min.js -Value $a


# Build

if ($env:GH_CI_LATEST -eq "true") {
    docker build --isolation hyperv --no-cache --pull -t eisai/aria2:latest -t eisai/aria2:$env:GH_CI_TAG .\build
} else {
    docker build --isolation hyperv --no-cache --pull -t eisai/aria2:$env:GH_CI_TAG .\build
}


# Push

if ($env:GH_CI_PUSH -eq "true") {
    docker push eisai/aria2 -a
}

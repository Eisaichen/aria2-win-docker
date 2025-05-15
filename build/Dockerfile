FROM mcr.microsoft.com/windows/servercore:ltsc2022

EXPOSE 80 6800
COPY ./aria2 C:/aria2
COPY ./AriaNg C:/inetpub/wwwroot
SHELL [ "powershell.exe", "-Command" ]

RUN Add-WindowsFeature Web-Server ; \
    New-Item -Type Directory -Path "C:\downloads"

WORKDIR C:/aria2
ENTRYPOINT .\entry.ps1

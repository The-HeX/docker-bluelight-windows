FROM microsoft/nanoserver

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]


RUN Invoke-WebRequest 'https://github.com/BlueLightJapan/BlueLight/archive/master.zip'  -OutFile 'bluelight.zip' -UseBasicParsing ; \
    mkdir c:\bluelight ;\
    Expand-Archive bluelight.zip -DestinationPath C:\bluelight ; \
    Remove-Item -Path bluelight.zip ; 

RUN Invoke-WebRequest 'http://windows.php.net/downloads/releases/php-7.0.23-nts-Win32-VC14-x64.zip' -OutFile 'php.zip' -UseBasicParsing ; \
    mkdir c:\php ; \
    Expand-Archive php.zip -DestinationPath C:\php ; \
    $env:PATH = 'C:\php;{0}' -f $env:PATH ; \
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\' -Name Path -Value $env:PATH ; \
    Remove-Item -Path php.zip ; 

RUN Invoke-WebRequest 'https://download.microsoft.com/download/9/3/F/93FCF1E7-E6A4-478B-96E7-D4B285925B00/vc_redist.x64.exe' -OutFile 'vc_redist.x64.exe' -UseBasicParsing ; \
    .\vc_redist.x64.exe  /install /passive /norestart ; 
  
EXPOSE 19132
EXPOSE 80

CMD [ "powershell.exe" ]
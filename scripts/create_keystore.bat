@echo off
setlocal
set KEYSTORE=f:\Zerixa\xerinnewmobile\android\app\upload-keystore.jks
set PASS=pR8FrOXNHnTmEjvY
set ALIAS=upload
set DNAME=CN=Xerin Market, OU=Development, O=Xerin, L=Dar es Salaam, ST=Dar es Salaam, C=TZ

if exist "%KEYSTORE%" del "%KEYSTORE%"

keytool -genkey -v -keystore "%KEYSTORE%" -alias "%ALIAS%" -keyalg RSA -keysize 2048 -validity 10000 -storetype JKS -storepass "%PASS%" -keypass "%PASS%" -dname "%DNAME%"

if %ERRORLEVEL% neq 0 (
    echo Keystore creation failed
    exit /b 1
)

echo Keystore created successfully

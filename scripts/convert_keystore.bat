@echo off
setlocal
set KEYSTORE=f:\Zerixa\xerinnewmobile\android\app\upload-keystore.jks
set PASS=pR8FrOXNHnTmEjvY

keytool -importkeystore -srckeystore "%KEYSTORE%" -srcstoretype JKS -srcstorepass "%PASS%" -destkeystore "%KEYSTORE%" -deststoretype PKCS12 -deststorepass "%PASS%" -destkeypass "%PASS%" -srcalias upload -destalias upload -noprompt

if %ERRORLEVEL% neq 0 (
    echo Keystore conversion failed
    exit /b 1
)

echo Keystore converted to PKCS12

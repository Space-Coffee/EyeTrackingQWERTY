@echo off
SETLOCAL

REM === KONFIGURACJA ===
SET APK_NAME=EyeTracking.apk
SET PACKAGE_NAME=com.spacecoffee.eyeapp

REM === Pobieranie IP z wlan0 ===
echo [1/5] Pobieranie IP gogli...
FOR /F "tokens=2 delims= " %%A IN ('./adb shell ip addr show wlan0 ^| findstr /R "inet "') DO (
    SET IP_FULL=%%A
)

FOR /F "tokens=1 delims=/" %%B IN ("%IP_FULL%") DO (
    SET GOGGLE_IP=%%B
)

echo IP gogli: %GOGGLE_IP%

REM === Przełączenie w tryb TCP ===
echo [2/5] Włączanie ADB przez Wi-Fi...
./adb tcpip 5555

REM === Łączenie przez Wi-Fi ===
echo [3/5] Łączenie z %GOGGLE_IP%:5555...
./adb connect %GOGGLE_IP%:5555

REM === Instalacja APK ===
echo [4/5] Wgrywanie %APK_NAME%...
./adb -s %GOGGLE_IP%:5555 install -r .\%APK_NAME%

REM === Uruchamianie aplikacji ===
echo [5/5] Uruchamianie aplikacji: %PACKAGE_NAME% ...
./adb -s %GOGGLE_IP%:5555 shell monkey -p %PACKAGE_NAME% -c android.intent.category.LAUNCHER 1

echo ✅ Gotowe!
pause

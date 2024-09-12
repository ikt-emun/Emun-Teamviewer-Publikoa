# Define el nombre del paquete de la aplicación a instalar
$nombrePaquete = "ProtonTechnologies.ProtonVPN"

# Define la ubicación del directorio donde se guardarán los logs
$directorioLogs = "C:\Wget-install-packages\"

# Crea el directorio si no existe
if (-not (Test-Path -Path $directorioLogs)) {
    New-Item -ItemType Directory -Path $directorioLogs
}

# Define el archivo de log
$archivoLog = Join-Path -Path $directorioLogs -ChildPath "ProtonVPN_Install_Log.txt"

# Instala la aplicación y captura el log
try {
    winget install $nombrePaquete --accept-source-agreements | Tee-Object -FilePath $archivoLog
    "Instalación completada." | Out-File -FilePath $archivoLog -Append
} catch {
    "Error al ejecutar el script: $_" | Out-File -FilePath $archivoLog -Append
}

# Muestra el contenido del log en la consola
Get-Content -Path $archivoLog

# Lasterbide Ikonoen Eguneratzailea PowerShell bidez

Script honek Windows ekipoko erabiltzaile guztien mahaigaineko lasterbide baten ikonoa automatikoki eguneratzen du. Erabiltzaileen profilak iteratzen ditu eta "Trebe Itzuli" izeneko lasterbidearen ikonoa definitzen du aurrez zehaztutako ikono-fitxategi bat erabiliz. 

## Ezaugarriak

- Erabiltzaile guztien mahaigainetara sartzen da.
- "Trebe Itzuli" lasterbidearen ikonoa eguneratzen du.
- Ikono-fitxategia urruneko URL batetik deskargatzen du eta `C:\Ikonoak\` karpetan gordetzen du.
- Administratzaile baimenak behar ditu.

## Baldintzak

- **Administratzaile baimenak** behar dira script hau exekutatzeko.
- Ikonoa deskargatzeko sarbidea behar da (Interneteko konexioa).
- PowerShell 3.0 edo bertsio berriagoa gomendagarria da.

## Nola erabili

1. **Script-a deskargatu** edo kopiatu zure sisteman.
2. Exekutatu PowerShell administratzaile moduan.
3. Script-ak ikono-fitxategia deskargatu eta erabiltzaile guztien mahaigaineko "Trebe Itzuli" lasterbidearen ikonoa eguneratuko du.

### Exekutatzeko urratsak

1. Ireki PowerShell **administratzaile moduan**.
2. Exekutatu script hau:
   ```powershell
   # Ikonoa deskargatzeko URL eta helmuga
   $ikonoURL = "https://raw.githubusercontent.com/Emun-Teamviewer-Publikoa/Trebe/adarkadura/trebe_2qZ_icon.ico"
   $helmuga = "C:\Ikonoak\trebe_2qZ_icon.ico"

   # Ziurtatu C:\Ikonoak karpeta existitzen dela; bestela, sortu
   if (!(Test-Path -Path "C:\Ikonoak")) {
       New-Item -ItemType Directory -Path "C:\Ikonoak"
   }

   # Deskargatu ikonoa
   Invoke-WebRequest -Uri $ikonoURL -OutFile $helmuga

   # Erabiltzaile bakoitzaren mahaigainean lasterbidea eguneratu
   $erabiltzaileak = Get-ChildItem -Path "C:\Users" -Directory | Where-Object { Test-Path "$($_.FullName)\Desktop\Trebe Itzuli.lnk" }

   foreach ($erabiltzaile in $erabiltzaileak) {
       $shortcutPath = "$($erabiltzaile.FullName)\Desktop\Trebe Itzuli.lnk"
       $shortcut = (New-Object -ComObject WScript.Shell).CreateShortcut($shortcutPath)
       $shortcut.IconLocation = $helmuga
       $shortcut.Save()
       Write-Output "Ikonoa eguneratu da: $shortcutPath"
   }

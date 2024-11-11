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
   ```

##    Oharrak

###  .Lasterbidearen izena: Lasterbidearen izena "Trebe Itzuli.lnk" dela ziurtatu behar duzu erabiltzaile guztien mahaigainean, script honek izen hori bilatzen baitu.
###  .Ikono-fitxategiaren kokapena: Script-ak C:\Ikonoak\ karpetan gordetzen du ikonoa; nahi izanez gero, karpeta hau aldatu dezakezu.

## Erabilitako Komandoak

    Invoke-WebRequest: URL batetik fitxategi bat deskargatzeko.
    Test-Path: Fitxategi edo karpeta bat existitzen den egiaztatzeko.
    Get-ChildItem: Erabiltzaileen direktorioak lortzeko.
    New-Object -ComObject WScript.Shell: Lasterbide bat kudeatzeko.

## Laguntza

Arazoak badituzu edo laguntza behar baduzu, jarri harremanetan zure IT taldearekin edo kontsultatu GitHub proiektuaren Issues atala.

Eskerrik asko script hau erabiltzeagatik!
   ```markdown
### Azalpena
- **Helburu nagusiak**: Script-ak zer egiten duen, nola erabili eta zer pribilegio behar diren laburbiltzen ditu.
- **Exekuzio argibideak**: PowerShell administratzaile moduan exekutatzeko urratsak zehazten dira.
- **Ohar praktikoak**: Lasterbidearen izena eta karpeten kokapena azpimarratzen dira.

README hau zure GitHub proiektuan txertatuz, beste erabiltzaileek erraz ulertu eta erabil dezakete script-a.
   ```


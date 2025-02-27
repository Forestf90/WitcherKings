; Simple CK2 mod manual installer for Windows

; To generate the installer, download NSIS Unicode 2.46.5 from https://code.google.com/p/unsis/downloads/list
; and launch "Compile NSIS Unicode script" from context menu.
; Unicode is needed to support French accents.
; NSIS documentation:
; - MUI: http://nsis.sourceforge.net/Docs/Modern%20UI/Readme.html
; - Scripting reference: http://nsis.sourceforge.net/Docs/Chapter4.html

!include "MUI2.nsh"

; Mod configuration defined in .mod file, to know which folders to cleanup.
!define mod_path "Witcher"
!define mod_user_dir "Witcher"

; The name of the installer
Name "Witcher Kings"

; The file to write
OutFile "Witcher_Kings.exe"

; The default installation directory
InstallDir "$DOCUMENTS\Paradox Interactive\Crusader Kings II\mod"

; Request application privileges for Windows Vista
RequestExecutionLevel user

; ---------------------------
; Interface settings
; ---------------------------

!define MUI_ICON "WitcherKings.ico"
!define MUI_WELCOMEFINISHPAGE_BITMAP "WitcherKings.bmp"
!define MUI_WELCOMEFINISHPAGE_BITMAP_NOSTRETCH

; ---------------------------
; Pages: Language -> Welcome -> Directory -> Install -> Finish
; ---------------------------

!define MUI_WELCOMEPAGE_TITLE $(MUI_WELCOMEPAGE_TITLE)
!define MUI_WELCOMEPAGE_TITLE_3LINES
!define MUI_WELCOMEPAGE_TEXT $(MUI_WELCOMEPAGE_TEXT)
!insertmacro MUI_PAGE_WELCOME

; To simplify, do not display components page: all are installed
;!insertmacro MUI_PAGE_COMPONENTS

!define MUI_DIRECTORYPAGE_TEXT_DESTINATION $(MUI_DIRECTORYPAGE_TEXT_DESTINATION)
!insertmacro MUI_PAGE_DIRECTORY

!insertmacro MUI_PAGE_INSTFILES

!define MUI_FINISHPAGE_NOAUTOCLOSE
!define MUI_FINISHPAGE_TITLE $(MUI_FINISHPAGE_TITLE)
!define MUI_FINISHPAGE_TEXT $(MUI_FINISHPAGE_TEXT)
!define MUI_FINISHPAGE_TEXT_LARGE
!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\ChangeLog.txt"
;!define MUI_FINISHPAGE_SHOWREADME_NOTCHECKED
!define MUI_FINISHPAGE_SHOWREADME_TEXT $(MUI_FINISHPAGE_SHOWREADME_TEXT)
!define MUI_FINISHPAGE_LINK $(MUI_FINISHPAGE_LINK)
!define MUI_FINISHPAGE_LINK_LOCATION "http://www.ckiiwiki.com/Witcher_Kings"
!define MUI_FINISHPAGE_NOREBOOTSUPPORT
!insertmacro MUI_PAGE_FINISH

;Languages - needs to be after page declarations
!insertmacro MUI_LANGUAGE English ;First language is the default if a better match is not found
!insertmacro MUI_LANGUAGE French

; Display Language selection dialog
Function .onInit

  !insertmacro MUI_LANGDLL_DISPLAY

FunctionEnd

; Un-install main mod 
Section "Uninstall previous"

  ; Remove directories and files recursively
  ; Only delete <path> folder of main mod, in case some files are removed from folders
  ; .mod files and other sub-mod files will always get overwritten during install.
  RMDir /r "$INSTDIR\${mod_path}"

SectionEnd

; Clean gfx cache
Section "Clean gfx cache"

  ; Delete <user_dir>/gfx folder
  RMDir /r "$INSTDIR\..\${mod_user_dir}\gfx"

SectionEnd

;--------------------------------

; Install mod and sub-mods
Section "Install"

  ; Set output path to the installation directory.
  SetOutPath "$INSTDIR"
  
  ; Copy mod files (excluding configuration files)
  File "${mod_path}\changelog.txt" ; Copy changelog to open it after installation
  File "*.mod" ; Copy all .mod descriptors
  File /r /x "*.exe" "${mod_path}*" ; Note: sub-mod paths start with same as main mod path
  
SectionEnd

; ---------------------------
; Localization
; ---------------------------

; English
LangString MUI_WELCOMEPAGE_TITLE ${LANG_ENGLISH} "Witcher Kings"
LangString MUI_WELCOMEPAGE_TEXT ${LANG_ENGLISH} "This installer will:$\r$\n \
1) Remove any previously installed version of the mod$\r$\n \
2) Clean the mod gfx cache$\r$\n \
3) Install the mod to your mod folder$\r$\n"
LangString MUI_DIRECTORYPAGE_TEXT_DESTINATION ${LANG_ENGLISH} "Please select your CK2 mod folder"
LangString MUI_FINISHPAGE_TITLE ${LANG_ENGLISH} "The mod has been installed"
LangString MUI_FINISHPAGE_TEXT ${LANG_ENGLISH} "To play:$\r$\n \
- Open CK2 launcher.$\r$\n \
- Select the mod 'Witcher Kings' in the Mod tab of the launcher.$\r$\n \
- Enjoy !$\r$\n"
LangString MUI_FINISHPAGE_SHOWREADME_TEXT ${LANG_ENGLISH} "Open the Changelog"
LangString MUI_FINISHPAGE_LINK ${LANG_ENGLISH} "Go to the mod wiki page"

; French
LangString MUI_WELCOMEPAGE_TITLE ${LANG_FRENCH} "Witcher Kings"
LangString MUI_WELCOMEPAGE_TEXT ${LANG_FRENCH} "Cet installateur va:$\r$\n \
1) Supprimer toute ancienne version du mod prec�dement install�e$\r$\n \
2) Vider votre cache de gfx du mod$\r$\n \
3) Installer le mod dans votre r�pertoire de mods$\r$\n"
LangString MUI_DIRECTORYPAGE_TEXT_DESTINATION ${LANG_FRENCH} "Merci de s�lectionner votre r�pertoire de mods CK2"
LangString MUI_FINISHPAGE_TITLE ${LANG_FRENCH} "Witcher Kings a �t� install�"
LangString MUI_FINISHPAGE_TEXT ${LANG_FRENCH} "Pour jouer:$\r$\n \ 
- Lancez CK2.$\r$\n \
- S�lectionnez le mod 'Witcher Kings' dans la section Mod.$\r$\n \
- Profitez !$\r$\n"
LangString MUI_FINISHPAGE_SHOWREADME_TEXT ${LANG_FRENCH} "Ouvrir le Changelog (en anglais)"
LangString MUI_FINISHPAGE_LINK ${LANG_FRENCH} "Acc�der � la page wiki du mod (en anglais)"

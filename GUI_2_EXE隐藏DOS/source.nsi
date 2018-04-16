SilentInstall silent

; The name of the NSIS install program you're creating
Name "NotSeen"

; The file that NSIS writes
OutFile "suppress.exe"

Section "Ignore"
  ; Change this exe file to the name of the exe you created
  ReadINIStr $1 "$EXEDIR\suppress.ini" "LoadProgram" "Name"
  nsExec::Exec "cmd /C $1"
SectionEnd

  {pkgs }:

  pkgs.writeShellScriptBin "ibus-toggle-layout" ''
    engine=$(ibus engine)
  
    if [ "$engine" == "xkb:us::eng" ]; then
      ibus engine OpenBangla - OpenBangla Keyboard 

    else
      ibus engine xkb:us::eng - English

    fi  ''

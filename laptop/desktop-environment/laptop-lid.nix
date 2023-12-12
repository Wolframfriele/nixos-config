{ pkgs }:

pkgs.writeShellScriptBin "laptop-lid" ''
${pkgs.notify-send}/bin/notify-send Script executed
''

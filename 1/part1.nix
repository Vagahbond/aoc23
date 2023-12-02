{lib, ...}: let
  input = builtins.readFile ./input;

  lines = lib.strings.splitString "\n" input;

  filteredNumbers = builtins.map (x: let
    chars = lib.strings.stringToCharacters x;
    linesWithOnlyNumbers = builtins.filter (char: (builtins.match "[0-9]" char) != null) chars;

    length = builtins.length linesWithOnlyNumbers;
    firstDigit =
      if length > 0
      then builtins.elemAt linesWithOnlyNumbers 0
      else "0";
    secondDigit =
      if length > 0
      then builtins.elemAt linesWithOnlyNumbers (length - 1)
      else "0";
  in
    lib.strings.toIntBase10 (firstDigit + secondDigit))
  lines;
in
  lib.lists.foldl (a: b: a + b) 0 filteredNumbers

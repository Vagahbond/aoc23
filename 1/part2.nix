{lib, ...}: let
  input = builtins.readFile ./input;

  lines = lib.strings.splitString "\n" input;

  reverseString = string: builtins.concatStringsSep "" (lib.lists.reverseList (lib.strings.stringToCharacters string));

  filteredNumbers = builtins.map (x: let
    withWordsReplacedLTR = builtins.replaceStrings ["one" "two" "three" "four" "five" "six" "seven" "eight" "nine" "zero"] ["1" "2" "3" "4" "5" "6" "7" "8" "9" "0"] x;
    charsLTR = lib.strings.stringToCharacters withWordsReplacedLTR;
    linesWithOnlyNumbersLTR = builtins.filter (char: (builtins.match "[0-9]" char) != null) charsLTR;

    rtl = reverseString x;
    withWordsReplacedRTL = builtins.replaceStrings ["eno" "owt" "eerht" "ruof" "evif" "xis" "neves" "thgie" "enin" "orez"] ["1" "2" "3" "4" "5" "6" "7" "8" "9" "0"] rtl;
    charsRTL = lib.strings.stringToCharacters withWordsReplacedRTL;
    linesWithOnlyNumbersRTL = builtins.filter (char: (builtins.match "[0-9]" char) != null) charsRTL;

    lengthLTR = builtins.length linesWithOnlyNumbersLTR;
    firstDigit =
      if lengthLTR > 0
      then builtins.elemAt linesWithOnlyNumbersLTR 0
      else "0";

    lengthRTL = builtins.length linesWithOnlyNumbersRTL;
    secondDigit =
      if lengthRTL > 0
      then builtins.elemAt linesWithOnlyNumbersRTL 0
      else "0";
  in
    lib.strings.toIntBase10 (firstDigit + secondDigit))
  lines;
in
  lib.lists.foldl (a: b: a + b) 0 filteredNumbers

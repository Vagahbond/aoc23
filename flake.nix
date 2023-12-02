{
  description = "neoney's 2023 AOC solutions in Nix";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {nixpkgs, ...}: let
    lib = nixpkgs.lib;
  in {
    solutions = let
      directories = lib.attrsets.filterAttrs (name: type: type == "directory" && (builtins.match "[0-9]+" name) != null) (builtins.readDir ./.);
    in
      builtins.mapAttrs
      (name: _: {
        "1" = (import ./${name}/part1.nix) {inherit lib;};
        "2" = (import ./${name}/part2.nix) {inherit lib;};
      })
      directories;
  };
}

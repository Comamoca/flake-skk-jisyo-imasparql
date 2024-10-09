{
  description = "SKK dictionaries for idolm@aster";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";
  };

  outputs =
    inputs@{
      self,
      systems,
      nixpkgs,
      treefmt-nix,
      flake-parts,
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        treefmt-nix.flakeModule
        inputs.flake-parts.flakeModules.easyOverlay
      ];
      systems = import inputs.systems;

      perSystem =
        {
          config,
          pkgs,
          system,
          ...
        }:
        let
          stdenv = pkgs.stdenv;

	  generated = import ./_sources/generated.nix;
	  sources = generated { 
	    inherit (pkgs) fetchurl fetchgit fetchFromGitHub dockerTools;
	  };

          dict = stdenv.mkDerivation {
            pname = "skk-jisyo-imasparql";
            version = "master";
            src = sources.skk-dict.src;

            installPhase = ''
            install -D SKK-JISYO.im@sparql.all.utf8 $out/share/SKK-JISYO.im@sparql.all.utf8
            install -D SKK-JISYO.im@sparql.idols.utf8 $out/share/SKK-JISYO.im@sparql.idols.utf8
            install -D SKK-JISYO.im@sparql.units.utf8 $out/share/SKK-JISYO.im@sparql.units.utf8
	    '';
          };
        in
        rec {
          treefmt = {
            projectRootFile = "flake.nix";
            programs = {
              nixfmt.enable = true;
            };

            settings.formatter = { };
          };

          devShells.default = pkgs.mkShell {
            packages = with pkgs; [
              nil
            ];
          };

          packages.default = dict;
        };
    };
}

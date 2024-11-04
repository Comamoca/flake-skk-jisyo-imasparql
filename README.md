<div align="center">

![Last commit](https://img.shields.io/github/last-commit/Comamoca/flake-skk-jisyo-imasparql?style=flat-square)
![Repository Stars](https://img.shields.io/github/stars/Comamoca/flake-skk-jisyo-imasparql?style=flat-square)
![Issues](https://img.shields.io/github/issues/Comamoca/flake-skk-jisyo-imasparql?style=flat-square)
![Open Issues](https://img.shields.io/github/issues-raw/Comamoca/flake-skk-jisyo-imasparql?style=flat-square)
![Bug Issues](https://img.shields.io/github/issues/Comamoca/flake-skk-jisyo-imasparql/bug?style=flat-square)

<img src="https://emoji2svg.deno.dev/api/🦊" alt="eyecatch" height="100">

# flake-skk-jisyo-imasparql

Nix flake support to SKK dictionaries for idolmaster.

<br>
<br>


</div>

> [!NOTE]
> This repository is archived.  
> Package was moved to [nur-packages](https://github.com/Comamoca/nur-packages)

## 🚀 How to use

```nix
# for all dictionaries.
".skk/SKK-JISYO.im@sparql.all.utf8".source = "${skk-imas}/share/SKK-JISYO.im@sparql.all.utf8"; 

# idols name only.
".skk/SKK-JISYO.im@sparql.idols.utf8".source = "${skk-imas}/share/SKK-JISYO.im@sparql.idols.utf8";

# units name only.
".skk/SKK-JISYO.im@sparql.units.utf8".source = "${skk-imas}/share/SKK-JISYO.im@sparql.units.utf8"; 
```

## ⬇️  Install

When use home-manager.

```nix
inputs = {
  skk-imas.url = "github:Comamoca/flake-skk-jisyo-imasparql"
};

outputs =
  {
    self,
    nixpkgs,
    skk-imas
  }@inputs:
  let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;

    overlays = [
      nak.overlays.default
    ];
  in
  {
    homeConfigurations = {
      Home = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = import inputs.nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
        extraSpecialArgs = {
          inherit inputs;
        };
        modules = [
          {
            nixpkgs.overlays = overlays ++ [
              (final: prev: {
                skk-imas = inputs.skk-imas.packages.x86_64-linux.default;
              })
            ];
          }
        ];
      };
    };
  }
```

## ⛏️   Development

```sh
# format
nix fmt

# build
nix build
```
## 📝 Todo

## 📜 License

zlib

### 🧩 Modules

- [flake-parts](https://flake.parts/)

## 💕 Special Thanks

- [skk-jisyo-imasparql](https://github.com/banjun/skk-jisyo-imasparql)

{
  lib,
  stdenvNoCC,
  fetchurl,
}:

let
  sources = import ./sources.nix;

  mkFamily =
    name:
    { family, sha256 }:
    stdenvNoCC.mkDerivation {
      pname = name;
      version = sources.release; # already encodes iosevkaVersion + short_sha

      src = fetchurl {
        url = "https://github.com/${sources.buildRepo}/releases/download/${sources.release}/${name}-${sources.iosevkaVersion}.tar.gz";
        inherit sha256;
      };

      dontUnpack = true;

      installPhase = ''
        runHook preInstall
        mkdir -p $out/share/fonts/truetype/${name}
        tar -xzf $src -C $out/share/fonts/truetype/${name}
        runHook postInstall
      '';

      meta = {
        description = "Custom Iosevka build (${family})";
        homepage = "https://github.com/${sources.buildRepo}";
        license = lib.licenses.ofl;
        platforms = lib.platforms.all;
      };
    };
in
lib.mapAttrs mkFamily sources.families

{ pkgs, ... }:

let
  speedynote = pkgs.stdenv.mkDerivation rec {
    pname = "speedynote";
    version = "1.2.1";
    src = pkgs.fetchurl {
      url= "https://github.com/alpha-liu-01/SpeedyNote/releases/download/v1.2.1-2/speedynote_1.2.1-1_amd64.deb";
      sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
    };

    nativeBuildInputs = with pkgs; [
      dpkg
      autoPatchelfHook
      qt6.wrapQtAppsHook
    ];

    buildInputs = with pkgs; [
      stdenv.cc.cc.lib
      zlib
      qt6.qtbase
      qt6.qtsvg
      qt6.qtwayland
      libjpeg8
      gumbo
      mujs
      openjpeg
      jbig2dec
    ];

    unpackPhase = "dpkg -x $src .";

    installPhase = ''
      mkdir -p $out
      cp -r usr/* $out/
      mkdir -p $out/lib
      
      ln -sf ${pkgs.gumbo}/lib/libgumbo.so $out/lib/libgumbo.so.2
      ln -sf ${pkgs.mujs}/lib/libmujs.so $out/lib/libmujs.so.3
    '';

    postFixup = ''
      patchelf --add-rpath $out/lib $out/bin/speedynote
    '';

    meta = with pkgs.lib; {
      description = "SpeedyNote";
      platforms = [ "x86_64-linux" ];
      license = licenses.free;
    };
  };

in
{
  home.packages = [
    speedynote
  ];
}

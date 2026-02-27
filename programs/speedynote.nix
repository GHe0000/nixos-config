{ pkgs, ... }:

let
  speedynote = pkgs.stdenv.mkDerivation rec {
    pname = "speedynote";
    version = "1.2.5";

    src = pkgs.fetchFromGitHub {
      owner = "alpha-liu-01";
      repo = "SpeedyNote";
      rev = "v${version}";
      hash = "sha256-3NhTcqqk4PNBkMELt9oWVZq5DYXiOeM31U4hUe/N8N4=";
    };

    nativeBuildInputs = with pkgs; [
      cmake
      pkg-config
      qt6.wrapQtAppsHook
      qt6.qttools
    ];

    buildInputs = with pkgs; [
      # Qt 依赖
      qt6.qtbase
      qt6.qtsvg
      qt6.qtwayland
      
      mupdf
      gumbo
      mujs
      harfbuzz
      freetype
      libjpeg
      openjpeg
      jbig2dec
      zlib
      brotli
    ];

    meta = with pkgs.lib; {
      description = "SpeedyNote";
      homepage = "https://github.com/alpha-liu-01/SpeedyNote";
      platforms = platforms.linux;
      license = licenses.free;
      mainProgram = "speedynote";
    };
  };

in
{
  home.packages = [
    speedynote
  ];
}

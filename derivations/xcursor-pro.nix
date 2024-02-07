{ stdenv, lib, fetchurl, variants ? [ "Dark" "Light" "Red" ] }:
stdenv.mkDerivation rec {
  pname = "xcursor-pro";
  version = "2.0.1";
  srcs = map
    (variant: fetchurl {
      url = "https://github.com/ful1e5/XCursor-pro/releases/download/v${version}/XCursor-Pro-${variant}.tar.gz";
      hash = {
        "Dark" = "sha256-N0zyNRYephVz2GT2xTGojtLLSc/5RAkL/34mUPDXb3c=";
        "Light" = "sha256-WB7U/ej/RFQCQQchuavaCbCEGgNHYRPy3soLRpRI1a8=";
        "Red" = "sha256-5PVBOMA0J6ILMl0NP3sPIvDE2fbfj+vr9trWxD3fSN8=";
      }."${variant}";
    })
    variants;

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall

    for theme in XCursor-Pro-{${lib.concatStringsSep "," variants}}; do
      mkdir -p $out/share/icons/$theme/cursors
      cp -a $theme/cursors/* $out/share/icons/$theme/cursors/
      install -m644 $theme/index.theme $out/share/icons/$theme/index.theme
    done

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://github.com/ful1e5/XCursor-pro";
    description = "Modern XCursors";
    platforms = platforms.all;
    license = licenses.gpl3;
  };
}

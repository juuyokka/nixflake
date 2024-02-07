{ stdenv, lib, fetchgit, variants ? [ "Black" "White" "Gray" ] }:
stdenv.mkDerivation rec {
  pname = "notwaita-cursor-theme";
  version = "1.0.0";
  src = fetchgit {
    url = "https://gitlab.com/donut2/notwaita-cursor-theme.git";
    rev = "fefc86d3aaab7fbab363277b1c46729694a1dcbc";
    hash = "sha256-W+qfHAWOtGBux9UwypP1yieolKvHLcrrOLft8l2ER5s=";
  };

  installPhase = ''
    runHook preInstall

    for variant in ${lib.concatStringsSep " " variants}; do
      themedir="Notwaita $variant Cursors"
      theme="Notwaita-$variant"

      mkdir -p $out/share/icons/$theme/cursors
      cp -a "$themedir/$theme"/cursors/* $out/share/icons/$theme/cursors/
      install -m644 "$themedir/$theme"/index.theme $out/share/icons/$theme/index.theme
    done

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://gitlab.com/donut2/notwaita-cursor-theme";
    description = "A cursor theme based off of Adwaita icons from the GNOME Project";
    platforms = platforms.all;
    license = licenses.cc-by-sa-30;
  };
}

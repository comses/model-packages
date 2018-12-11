let nixpkgs = import ./pinned.nix;
mesa = with (nixpkgs.lib.mergeAttrs nixpkgs.pkgs.python36Packages { stdenv = nixpkgs.stdenv; }); callPackage ./mesa.nix { };
boltzmann-raw = ../../src;
boltzmann-src = nixpkgs.runCommand "mesa_src" {} ''
  mkdir -p "$out/app/src"
  cp -r ${boltzmann-raw}/* "$out/app/src"
'';
in 
nixpkgs.pkgs.dockerTools.buildImage {
  name = "boltzmann-nix";
  tag = "latest";
  # `with nixpkgs.pkgs` brings all top level nix packages into scope
  contents = (with nixpkgs.pkgs; [
    bashInteractive
    coreutils
    glibcLocales
    # we're ignoring pinned versions specified in requirements.txt
    (python36.withPackages (p: [
      p.networkx
      p.matplotlib
      mesa
    ]))
  ] ++ [
    boltzmann-src
  ]); 
  config = {
    Env = ["LANG=en_US.UTF8"
           "LOCALE_ARCHIVE=${nixpkgs.pkgs.glibcLocales}/lib/locale/locale-archive"];
    Cmd = ["mesa" "runserver"];
    WorkingDir = "/app/src";
  };
}

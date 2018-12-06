let nixpkgs = import ./pinned.nix;
mesa = with (nixpkgs.lib.mergeAttrs nixpkgs.pkgs.python36Packages { stdenv = nixpkgs.stdenv; }); callPackage ./mesa.nix { };
p = nixpkgs.pkgs.python36Packages;
mesa-raw = ../../src;
mesa-src = nixpkgs.runCommand "mesa_src" {} ''
  mkdir -p "$out/app/src"
  cp -r ${mesa-raw}/* "$out/app/src"
'';
in 
nixpkgs.pkgs.dockerTools.buildImage {
  name = "boltzmann-nix";
  contents = [
    nixpkgs.pkgs.bashInteractive
    nixpkgs.pkgs.coreutils
    nixpkgs.pkgs.glibcLocales
    p.python
    p.networkx
    p.matplotlib
    mesa
    mesa-src
  ];
  config = {
    Env = ["LANG=en_US.UTF8"
           "LOCALE_ARCHIVE=${nixpkgs.pkgs.glibcLocales}/lib/locale/locale-archive"];
    Cmd = "bash";
    WorkingDir = "/app";
  };
}

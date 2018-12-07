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
  tag = "latest";
  contents = (with nixpkgs.pkgs; [
    bashInteractive
    coreutils
    glibcLocales
    (python36.withPackages (p: with p; [
      p.networkx
      p.matplotlib
      mesa
    ]))
  ] ++ [
    mesa-src
  ]); 
  config = {
    Env = ["LANG=en_US.UTF8"
           "LOCALE_ARCHIVE=${nixpkgs.pkgs.glibcLocales}/lib/locale/locale-archive"];
    Cmd = "mesa runserver";
    WorkingDir = "/app/src";
  };
}

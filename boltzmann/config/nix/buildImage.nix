let nixpkgs = import <nixpkgs> { overlays = 
  [
    # jupyter builds with tornado 5 by default and mesa doesn't support tornado 5 yet
    # so build jupyter with tornado 4 for compatibility
    (self: super: let myOverride = { 
      packageOverrides = self: super: {
        tornado = super.tornado_4;
      };
    };
  
    in { python36 = super.python36.override myOverride; })
  ]; 
};
mesa = with (nixpkgs.lib.mergeAttrs nixpkgs.pkgs.python36Packages { stdenv = nixpkgs.stdenv; }); callPackage ./mesa.nix { };
p = nixpkgs.pkgs.python36Packages;
mesa-raw = ./mesa;
mesa-src = nixpkgs.runCommand "mesa_src" {} ''
  mkdir -p "$out/mesa"
  cp -r ${mesa-raw}/* "$out/mesa"
'';
in 
nixpkgs.pkgs.dockerTools.buildImage {
  name = "boltzmann-nix";
  contents = [
    nixpkgs.pkgs.bashInteractive
    nixpkgs.pkgs.coreutils
    nixpkgs.pkgs.glibcLocales
    p.networkx
    p.matplotlib
    mesa
    mesa-src
  ];
  config = {
    Env = ["LANG=en_US.UTF8"
           "LOCALE_ARCHIVE=${nixpkgs.pkgs.glibcLocales}/lib/locale/locale-archive"];
    Cmd = "bash";
    WorkingDir = "/mesa/examples/boltzmann_wealth_model_network";
  };
}

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
in 
nixpkgs.stdenv.mkDerivation {
  name = "boltzmann-model";
  buildInputs = [
    p.networkx
    p.matplotlib
    mesa
  ];
}

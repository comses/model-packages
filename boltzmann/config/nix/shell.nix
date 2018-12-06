let nixpkgs = import ./pinned.nix; 
mesa = with (nixpkgs.lib.mergeAttrs nixpkgs.pkgs.python36Packages { stdenv = nixpkgs.stdenv; }); callPackage ./mesa.nix { };
in 
nixpkgs.stdenv.mkDerivation {
  name = "boltzmann-model";
  buildInputs = [
    (nixpkgs.pkgs.python36.withPackages (p: [
      p.networkx
      p.matplotlib
      mesa
    ]))
  ];
}

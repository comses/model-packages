import (builtins.fetchGit {
  name = "nixos-unstable-2018-12-06";
  url = https://github.com/nixos/nixpkgs/;
  rev = "ae49c73644c05f1eaf8fbd5e88d0971e3dd6a8c5";
}) { overlays = 
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
}

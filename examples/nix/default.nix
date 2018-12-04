# { buildPythonPackage, fetchPypi, stdenv }:
with import <nixpkgs> { overlays = 
  [
    (self: super: let myOverride = { 
      packageOverrides = self: super: {
        tornado = super.tornado_4;
      };
    };
  
    in { python36 = super.python36.override myOverride; })
  ]; 
};

let buildPythonPackage = python36Packages.buildPythonPackage;
    fetchPypi = python36Packages.fetchPypi;
    p = python36Packages;

in
buildPythonPackage rec {
  pname = "Mesa";
  version = "0.8.5";

  src = fetchPypi {
    inherit pname version;
    sha256 = "497d139966a8cf5d064be1547b747e1e86636a6e47947e75677df6c6c44192c8";
  };

  propagatedBuildInputs = [
    p.python
    p.click
    p.tornado_4
    p.cookiecutter
    p.jupyter
    p.networkx
    p.numpy
    p.pandas
    p.tqdm
  ];

  meta = {
    homepage = "https://mesa.readthedocs.io/en/latest/index.html";
    description = "Mesa is an Apache2 licensed agent-based modeling (or ABM) framework in Python.";
    # license = stdenv.lib.licenses.apache2;
  };
}

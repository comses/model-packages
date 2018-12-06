{ stdenv,
  python, click, tornado, cookiecutter, jupyter, networkx, numpy, pandas, tqdm,
  buildPythonPackage, fetchPypi }:

buildPythonPackage rec {
  pname = "Mesa";
  version = "0.8.5";

  src = fetchPypi {
    inherit pname version;
    sha256 = "497d139966a8cf5d064be1547b747e1e86636a6e47947e75677df6c6c44192c8";
  };

  propagatedBuildInputs = [
    python
    click
    tornado
    cookiecutter
    jupyter
    networkx
    numpy
    pandas
    tqdm
  ];

  meta = {
    homepage = "https://mesa.readthedocs.io/en/latest/index.html";
    description = "Mesa is an Apache2 licensed agent-based modeling (or ABM) framework in Python.";
    license = stdenv.lib.licenses.asl20;
  };
}

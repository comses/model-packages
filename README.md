# Packaging a Mesa Geo Model using different packaging formats

This repository explores some different technologies that could be used for
packaging computational models using Docker, Nix and ReproZip. Examples are
built in docker images where possible so that you don't have to install all 
the packages on your computer.

This is still very preliminary. The Mesa example chosen for packaging would
package still requires compiling some packages (such as `pandas`) and tools
git to download the mesa repo. 

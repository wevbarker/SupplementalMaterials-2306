# Supplemental Materials to arXiv:2306:XXXXX
W. E. V. Barker and S. Zell

## About

These materials are designed to supplement our manuscript. They provide complete, step-by-step derivations of the field equations, manipulation of these field equations to obtain our key results, and also our complete nonlinear Hamiltonian analyses.

## Installation

#### Requirements 
These supplemental materials have been tested in the following environment(s):
- Linux x86 (64-bit), specifically Manjaro, Arch, CentOS, Scientific Linux and Ubuntu
- Mathematica v 11.3.0.0
- xAct v 1.2.0
#### Install 
1. Make sure you have [installed xAct](http://www.xact.es/download.html).
2. Download this repository:
	```bash, git
	git clone https://github.com/wevbarker/SupplementalMaterials-arXiv:2306.XXXXX
	cd SupplementalMaterials-arXiv:2306.XXXXX
	```
3. Place the contents of the `SupplementalMaterials-arXiv:2306.XXXXX/PackagesForMathematica_v13.2.0.0/xAct` directory (i.e. the three new packages HiGGS, GeoHiGGS and xPlain) relative to your xAct install. A global install might have ended up at: 
	```bash
	/usr/share/Mathematica/Applications/xAct
	```
## How to use 

- You may decide to interact with the supplement at various levels. 
- Having decided whether you wish to explore the Hamiltonian analysis or the field equations, you should pick a sub-directory accordingly. 
- Then, you can read the `SupplementalMaterials.pdf` file. 
- If you wish to reproduce the calculations, or if you find some problem with the formatting of the pdf (the Mathematica pdf export is not flawless), you can explore the `SupplementalMaterials.nb` notebook file. 
- If you wish to re-run the notebook, then you can execute the single executable cell at the top, which reads:
```wolfram
Get@FileNameJoin@{NotebookDirectory[],"SupplementalMaterials.m"};
```
- If there is any ambiguity over the calculation, you can always read the `SupplementalMaterials.m` Wolfram Language file, and any files to which it refers, and by construction these will tell you **exactly** what is being done at each step.

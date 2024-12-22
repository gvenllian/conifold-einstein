
<!-- 
    Some basic tutorials on the Markdown text:
    https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax
    https://www.markdownguide.org/basic-syntax/
-->



# GR computations

This *Mathematica* package provides some basic functions for GR computations, 
as well as the notebooks that were used for computations in the project [1]. 

Package contents:
- `ChristoffelRiemann.wl`: provides functions for computing certain tensors in GR:
  - `getChristoffelSymbols[metric,coordFull]` takes the `metric` as a square matrix and `coordFull` as an iterable with all the coordinates. Returns Christoffel symbols.
  - `getRiemannTensor[metric,coordFull,ChristoffelSymbols]` takes the `metric`, `coordFull`, `ChristoffelSymbols` and returns Riemann tensor with lowered indices.
  - `getRicciTensor[metric,RiemannTensor]` takes the `metric`, `RiemannTensor` and returns Ricci tensor.
  - `doGenericPowerSubstitution[systemOfEquations,warpFactor1,warpFactor2,warpFactor3,warpFactor4,r0]` takes `systemOfEquations` (or just equation) with `warpFactor1`, ... `warpFactor4`. Returns systemOfEquation with power-like substitution for warpFactors in the point (r-`r0`).
- `01 compute cristoffels and ricci.nb` is a notebook that computes Christoffel symbols and Ricci tensor, runs some basic consistency checks and saves the results to files. 
The files are saved into a folder `data` (created automatically if necessary).
- `02 build ein eq and power-like sub.nb` is a notebook that constructs Einstein's equations using `ricci.json`. The system is then simplified and the power-like substitution is performed. It also finds the general solution for a particular case. The files are saved into a folder `data`.



## References

[1] E. Ievlev, P. Pichugina and A. Yung, *Search for NS 3-form Flux Induced Vacua for the
Critical Non-Abelian Vortex String*, to appear

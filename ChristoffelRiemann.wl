(* ::Package:: *)

(* ::Text:: *)
(*Short "how - to" on creating a package file: https://reference.wolfram.com/language/workflow/CreateAPackageFile.html.en*)


(* ::Text:: *)
(*For additional documentation on this package see the enclosed file "README.md"*)


BeginPackage["ChristoffelRiemann`"];


ChristoffelRiemannPackageDescription::usage = "ChristoffelRiemannPackageDescription[] gives a brief package description";


getChristoffelSymbols::usage = "getChristoffelSymbols[metric,coordFull]";


getRiemannTensor::usage = "getRiemannTensor[metric,coordFull,ChristoffelSymbols]";


getRicciTensor::usage = "getRicciTensor[metric,RiemannTensor]";


doGenericPowerSubstitution::usage = "doGenericPowerSubstitution[systemOfEquations, warpFactor1, warpFactor2, warpFactor3, warpFactor4, r0]";


Begin["`Private`"];


ChristoffelRiemannPackageDescription[]:="You have loaded a set of routines for computations in general relativity. This code was created by Evgenii I. and Pavlina P., with the help of Sergey P.";


(* This function convolutes two indices number c1 and c2 in the tensor sp *)
sv[sp_,c1_,c2_]:=Tr[Transpose[sp,Insert[Insert[Table[i,{i,3,Length[Dimensions[sp]]}],1,c1],2,c2]],Plus,2]


(* This function computes a tensor product of two tensors ten1 and ten2 *)
prt[ten1_,ten2_]:=Outer[Times,ten1,ten2]


(* This function computes a tensor product of two tensors ten1 and ten2 and simultaneously convolutes two indices number c1 and c2 in the resulting tensor *)
prts[ten1_,ten2_,c1_,c2_]:=sv[Outer[Times,ten1,ten2],c1,c2]


(* This function computes a derivative of the tensor ten_ with respect to the set of coordinates coordFull_ of length n_ (the new index is put first) *)
dif[ten_,coordFull_]:=Table[D[ten,coord],{coord,coordFull}]


(* kr[[\[Alpha],\[Mu],\[Nu]]] -> Christoffel symbols Subsuperscript[\[CapitalGamma], \[Mu]\[Nu], \[Alpha]] *)
getChristoffelSymbols[metric_,coordFull_]:=Module[{dg,ginv,krn,kr},
	dg=dif[metric,coordFull];(* Derivative of the metric *)
	ginv=Simplify[Inverse[metric]];(*Inverse metric*)
	krn=Simplify[(Transpose[dg,{2,3,1}]+Transpose[dg,{3,2,1}]-dg)/2];(*Christoffel symbols with the first index in the lower position Subscript[\[CapitalGamma], \[Alpha],\[Mu]\[Nu]] *)
	kr=Simplify[prts[ginv,krn,2,3]];(* Raise the first index *)
	answer=kr
]


(* rim[[\[Mu],\[Nu],\[Alpha],\[Beta]]] -> Riemann tensor with lowered indices Subscript[R, \[Mu]\[Nu]\[Alpha]\[Beta]] *)
getRiemannTensor[metric_,coordFull_,ChristoffelSymbols_]:=Module[{rimns,rim},
	rimns=Transpose[dif[ChristoffelSymbols,coordFull],{3,1,2,4}]+Transpose[prts[ChristoffelSymbols,ChristoffelSymbols,2,4],{1,3,2,4}]//Simplify;
	rim=Simplify[prts[metric,(rimns-Transpose[rimns,{1,2,4,3}]),2,3]];
	answer=rim
]


(* ric[[\[Mu],\[Nu]]] -> Ricci tensor Subscript[R, \[Mu]\[Nu]] *)
getRicciTensor[metric_,RiemannTensor_]:=Module[{ginv,ric},
	ginv=Simplify[Inverse[metric]];(*Inverse metric*)
	ric=Simplify[sv[prts[ginv,RiemannTensor,1,4],1,4]];
	answer=ric
]


(* systemOfEquations -> systemOfEquations with power substitution *)
doGenericPowerSubstitution[systemOfEquations_,f1_, f2_, f3_, f4_, r0_]:=Module[{power},
	power=systemOfEquations/.{f1->Function[{r},Subscript[C,f1]*(r-r0)^Subscript[Global`\[Alpha],f1]],f2->Function[{r},Subscript[C,f2]*(r-r0)^Subscript[Global`\[Alpha],f2]],f3->Function[{r},Subscript[C,f3]*(r-r0)^Subscript[Global`\[Alpha],f3]],f4->Function[{r},Subscript[C, f4]*(r-r0)^Subscript[Global`\[Alpha],f4]]};
	answer=power
]


End[];


EndPackage[];

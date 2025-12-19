File
{
*INPUT FILES
Grid ="n1_presimulation_fps.tdr"
* physical parameters
Parameter = "sdevice.par"

*OUTPUT FILES
Plot = "n@node@_des.tdr"
* electrical characteristics at the electrodes
Current= "n@node@_des.plt"
}

Electrode
{
{ name="source" Voltage=0.0 }
{ name="drain" Voltage=0.0 }
{ name="gate" Voltage=0.0 }
{ name="substrate" Voltage=0.0}
}

Thermode
{
{ Name = "source" Temperature = 300 }
{ Name = "drain" Temperature = 300 }
{ Name = "gate" Temperature = 300 }
{ Name = "substrate" Temperature = 300 }
}

Physics
{
	EffectiveIntrinsicDensity(NoBandGapNarrowing)
	Mobility(DopingDependence,HighFieldSaturation)
	Recombination(SRH)
	Temperature=300
}

Plot
{
	Potential ElectricField/Vector
	eEparallel eEnormal
	hEparallel hEnormal
	eDensity hDensity SpaceCharge
	Affinity IntrinsicDensity
	eCurrent/Vector hCurrent/Vector TotalCurrentDensity/Vector 
	eMobility hMobility eVelocity hVelocity
	Doping DonorConcentration AcceptorConcentration
	DonorPlusConcentration AccepMinusConcentration 
	ConductionBandEnergy ValenceBandEneergy
	eQuasiFermiEnergy hQuasiFermiEnergy
	eAvalancheGeneration hAvalancheGeneration
    BandGap DielectricConstant
}


Math
{
	Extrapolate
	* use full derivatives in Newton method
	Derivatives
	* control on relative errors
	RelErrControl
	* relative error= 10^(-Digits)
	Digits=5
	* maximum number of iteration at each step
	Iterations=100
	ExitOnFailure 
}


Solve
{
 	# initial equilibrium solution
	Poisson
	Coupled { Poisson Electron Hole  } 
	Plot(FilePrefix="equil")
	Load(FilePrefix="equil")
	
	
NewCurrentPrefix= "IDVD_VD1_"
quasistationary (InitialStep=0.005 MaxStep = 0.1 MinStep=0.01
Goal {name= "drain" voltage = -1})
{coupled { Poisson  Electron Hole }
CurrentPlot ( Time = (range = (0 1) intervals = 20)) 
Plot(FilePrefix = "IDVD" Time=(1.0))}

NewCurrentPrefix= "IDVG_VD1_"
quasistationary (InitialStep=0.005 MaxStep = 0.1 MinStep=0.01
Goal {name= "gate" voltage = -1})
{coupled { Poisson Electron Hole } 
CurrentPlot ( Time = (range = (0 1) intervals = 20)) 
Plot(FilePrefix = "IDVG" Time=(1))}

Load(FilePrefix="equil")
NewCurrentPrefix= "IDVD_VD0d1_"
quasistationary (InitialStep=0.005 MaxStep = 0.1 MinStep=0.01
Goal {name= "drain" voltage = -0.1})
{coupled { Poisson  Electron Hole }
CurrentPlot ( Time = (range = (0 1) intervals = 20)) 
Plot(FilePrefix = "IDVD_VD0d1" Time=(1.0))}

NewCurrentPrefix= "IDVG_VD0d1_"
quasistationary (InitialStep=0.005 MaxStep = 0.1 MinStep=0.01
Goal {name= "gate" voltage = -1})
{coupled { Poisson Electron Hole } 
CurrentPlot ( Time = (range = (0 1) intervals = 20)) 
Plot(FilePrefix = "IDVG_VD0d1" Time=(1))}
}




math coord.ucs

line x location= 75.0<nm> spacing= 2.5<nm>  tag= OxBottom
line x location= 225.0<nm> spacing= 100<nm>        
line x location= 300.0<nm>  spacing= 0.5<um>                                             
line x location= 400.0<nm> spacing= 2.0<um>  tag= SiBottom 

line y location= 0.0      spacing= 25.0<nm> tag= Mid         
line y location= 0.20<um> spacing= 25.0<nm>  tag= Right

region Silicon xlo= OxBottom xhi= SiBottom ylo= Mid yhi= Right

init concentration= 1.0e+15<cm-3> field= Boron !DelayFullD

AdvancedCalibration 

struct tdr=n@node@_PMOS_substrate0; #substrate 

deposit material= {Oxide} type= fill coord= {25<nm>}

struct tdr=n@node@_PMOS_substrate1; #substrate 
deposit material= {Silicon} type= fill coord= {0<nm>} fields.values= {Boron= 1e15}

struct tdr=n@node@_PMOS_substrate2; #substrate 

diffuse temperature= 850<C> time= 10.0<min> 
struct tdr=n@node@_PMOS_substrate3; #substrate 

implant Arsenic dose= 1.0e13<cm-2>   energy=   10<keV> tilt= 0 rotation= 0
#implant Arsenic dose= 1.0e12<cm-2>   energy=   2<keV> tilt= 0 rotation= 0

SetPlxList {AsTotal}
WritePlx n@node@_PMOS_nwell3.plx y=0.0 Silicon
struct tdr=n@node@_PMOS_nwell3;

diffuse temperature= 1000<C> time= 60.0<s>
SetPlxList {AsTotal}
WritePlx n@node@_PMOS_substrate1.plx y=0.0 Silicon
struct tdr=n@node@_PMOS_substrate1;

diffuse temperature= 850<C> time= 10.0<min> O2

struct tdr=n@node@_PMOS_substrate2;

deposit material= {PolySilicon} type= anisotropic time= 1 rate= {0.08}
mask name= gate_mask left=-1 right= 40<nm>

etch material= {PolySilicon} type= anisotropic time= 1 rate= {0.08} \
  mask= gate_mask

struct tdr= n@node@_PMOS1;

etch material= {Oxide}       type= anisotropic time= 1 rate= {0.005}

struct tdr= n@node@_PMOS2;

diffuse temperature= 900<C> time= 10.0<min> O2

struct tdr= n@node@_PMOS3;

refinebox Silicon min= {0.0 0.01} max= {0.06 0.06} xrefine= {0.001 0.001 0.001} \
                                                  yrefine= {0.01 0.01 0.01} add
grid remesh

implant Boron dose= 4e14<cm-2> energy= 1<keV> tilt= 0<degree> rotation= 0<degree>
struct tdr= n@node@_PMOS4 ; # LDD Implant

diffuse temperature= 950<C> time= 0.1<s> ; # Quick activation

struct tdr= n@node@_PMOS5;   # quick activation

deposit material= {Nitride} type= isotropic  time= 1 rate= {0.03}

struct tdr= n@node@_NMOS11 ; # Spacer deposition

etch    material= {Nitride} type= anisotropic time = 1 rate= {0.042} \
				isotropic.overetch= 0.01

struct tdr= n@node@_NMOS12 ; # Spacer etch				
				
etch    material= {Oxide}   type= anisotropic time= 1 rate= {0.01} 

struct tdr= n@node@_NMOS13 ; # Spacer oxide removal

refinebox Silicon min= {0.0 0.04} max= {0.06 0.1} xrefine= {0.001 0.001 0.001} \
                                                  yrefine= {0.01 0.01 0.01} add
grid remesh

## ---------- p HDD Extension implantation -----------------------
implant Boron dose= TEST  energy= 2<keV> tilt= 7<degree> rotation= -90<degree>

struct tdr= n@node@_PMOS14 ; # P+ implantation


diffuse temperature= 1000<C> time= 5<s> 

struct tdr= n@node@_PMOS15 ; # Final RTA


deposit material= {Aluminum} type= isotropic time= 1 rate= {0.009}

struct tdr= n@node@_PMOS16 ; # Aluminium deposition

mask name= contacts_mask left= 0.12<um> right= 0.2<um>
etch material= {Aluminum} type= anisotropic time= 1 rate= {0.25} \
     mask= contacts_mask
     
struct tdr= n@node@_PMOS17 ; # Aluminium etching 1   

mask name= gate_mask2 left=-1 right= 26<nm> negative
deposit material= {Aluminum} type= anisotropic time= 1 rate= {0.009} \
     mask= gate_mask2 

struct tdr= n@node@_PMOS18 ; # Gate contact creation

transform reflect left 

struct tdr= n@node@_PMOS20 ; # Final

SetPlxList   {AsTotal NetActive}
WritePlx n@node@_PMOS_channel.plx  y=0.0 Silicon

SetPlxList   {AsTotal BTotal NetActive}
WritePlx n@node@_PMOS_ldd.plx y=0.05 Silicon

SetPlxList   {AsTotal BTotal NetActive}
WritePlx n@node@_PMOS_sd.plx y=0.19 Silicon

contact bottom name = substrate Silicon

contact name = gate x = -0.085 y = 0.0 Aluminum

contact name = source x = -0.0019 y = -0.16 Aluminum

contact name = drain x = -0.0019 y = 0.16 Aluminum

struct tdr= n@node@_presimulation

exit








## THIS IS A MACHINE GENERATED COMMAND FILE FOR INSPECT


# proj_load /home/ist25.10/Desktop/prova2_sgro/tmp/g_integratedsystemstech.openstack.polito_2533548_0.tmp/IDVG_VD0d1_n2_des.plt IDVG_VD0d1_n2_des
proj_load IDVG_VD0d1_n@node@_des.plt IDVG_VD0d1_n2_des
proj_load IDVG_VD1_n@node@_des.plt IDVG_VD1_n2_des
cv_createDS NO_NAME {IDVG_VD1_n2_des gate OuterVoltage} {IDVG_VD1_n2_des drain TotalCurrent} y
cv_createWithFormula curve_01 "vecmax(-<TotalCurrent_drain>)" A A
cv_createWithFormula curve_02 "vecmin(-<TotalCurrent_drain>)" A A
cv_createWithFormula curve_1 "vecvalx(diff(diff(-<TotalCurrent_drain>)),vecmax(diff(diff(-<TotalCurrent_drain>))))" A A 
cv_createWithFormula curve_2 "log10(-<TotalCurrent_drain>)" A A 
cv_createWithFormula curve_3 "diff(<curve_2>)" A A 
cv_createWithFormula curve_4 "1/vecmin(<curve_3>)" A A

# cv_delete TotalCurrent_drain
cv_createDS NO_NAME {IDVG_VD0d1_n2_des gate OuterVoltage} {IDVG_VD0d1_n2_des drain TotalCurrent} y
cv_createWithFormula curve_5 "vecvalx(diff(diff(-<TotalCurrent_drain.1>)),vecmax(diff(diff(-<TotalCurrent_drain.1>))))" A A 


logSubname="uselessTest"
logSubname2="serialTest2"


make inspect \
ARSENIC_DOSE=10.0e12 \
ARSENIC_ENERGY=10 \
BORON_DOSE_LDD=4e14 \
BORON_ENERGY_LDD=1 \
BORON_DOSE_HDD=4.5e15 \
BORON_ENERGY_HDD=2 \
FINAL_RTA_TIME=3 \
FINAL_RTA_TEMP=1000 \
LOG_SUBNAME=${logSubname}

wait
cat  log/Project_matte_$logSubname.log | mail -s "IST: simulations $logSubname are over" $1 

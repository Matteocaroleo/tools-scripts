logSubname="serialTest1"
logSubname2="serialTest2_higherTime"

echo "RUNNING $logSubname..."
make mos \
ARSENIC_DOSE=10.0e12 \
ARSENIC_ENERGY=8 \
BORON_DOSE_LDD=4e14 \
BORON_ENERGY_LDD=1 \
BORON_DOSE_HDD=4.5e15 \
BORON_ENERGY_HDD=2 \
FINAL_RTA_TIME=5 \
FINAL_RTA_TEMP=1000 \
LOG_SUBNAME=${logSubname}
[ $? -eq 0 ] && echo "sim $logSubname over" || exit $?

wait
cat  log/Project_matte_$logSubname.log | mail -s "IST: simulations $logSubname are over" $1 

echo "RUNNING $logSubname2..."
make mos \
ARSENIC_DOSE=10.0e12 \
ARSENIC_ENERGY=10 \
BORON_DOSE_LDD=4e14 \
BORON_ENERGY_LDD=1 \
BORON_DOSE_HDD=4.5e15 \
BORON_ENERGY_HDD=2 \
FINAL_RTA_TIME= 10\
FINAL_RTA_TEMP=1000 \
LOG_SUBNAME=${logSubname2} 
[ $? -eq 0 ] && echo "sim $logSubname2 over" || exit $?

wait
cat  log/Project_matte_$logSubname2.log | mail -s "IST: simulations $logSubname2 are over" $1 

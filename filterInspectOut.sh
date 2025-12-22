# $1 = source path
# $2 = source name
# $3 = python script path

# uses awk programming language
full_output=$(tail -n +15 "$1/$2" | awk '
  BEGIN { 
    fields[1]="Ion:\t"; 
    fields[2]="Ioff:\t"; 
    fields[3]="Vth1:\t";
    fields[4]="SS:\t";
    fields[5]="Vth2:\t";
  }
  { 
    prefix = (fields[NR] ? fields[NR] : "other");
    print prefix $NF 
  }
')
output=$(tail -n +17 "$1/$2" | awk '{print $NF}' | tr '\n' ' ' )
Vths=$(echo "$output" | awk '{print $1" "$3}')
echo "$full_output"
python3 $3/sub.py $Vths


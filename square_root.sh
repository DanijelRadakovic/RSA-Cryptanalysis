#!/bin/bash
#
#SBATCH --job-name=square_root
#SBATCH --output=square_root.out

#SBATCH --ntasks=64 # change this to more appropriate value
#SBATCH --time=8:00:00 # processing one dependency vector requires 8 hours
#SBATCH --mem-per-cpu=2048 # change this to more appropriate value

# Number that needs to be factored
N=1000000000000000000000000000000000000000000130000000000000000000000000000000000000000001089

# Path to MSIEVE binary
MSIEVE=./msieve

# Number of processes should be same as number of tasks
NUM_PROC=64


for (( i=0; i<${NUM_PROC}; i++ ))
  do
    srun -N1 -n1 -c1 --exclusive ${MSIEVE} -s "${i}msieve.dat" -ns ${i},$(( ${i} + 1 )) ${N} &
  done
wait


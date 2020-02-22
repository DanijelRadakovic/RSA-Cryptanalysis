#!/bin/bash
#
#SBATCH --job-name=poly_select_dist
#SBATCH --output=poly_select.out

#SBATCH --ntasks=2 # change this to more appropirate value
#SBATCH --time=01:00:00
#SBATCH --mem-per-cpu=100 # change this to more appropirate value

# Number that needs to be factored
N=1000000000000000000000000000000000000000000130000000000000000000000000000000000000000001089

# Path to MSIEVE binary
MSIEVE=./msieve

# Number of seconds that will be spent for polynominal selection
# Should be less than allowed time duration for job execution
# 0 means search forever
POLY_DEADLINE=3600

# Number of processes should be same as nubmer of tasks
NUM_PROC=2

b_min=1
b_max=100000
b_avg=$(((b_max - b_min) / NUM_PROC))

for (( i=0; i<${NUM_PROC}; i++ ))
  do
    b_start=$((i * b_avg))
    b_end=$(((i+1) * b_avg))
    srun -N1 -n1 -c1 --exclusive ${MSIEVE} -s "${i}msieve.dat" \
      -np "${b_start},${b_end} poly_deadline=${POLY_DEADLINE}" ${N} &

  done
wait

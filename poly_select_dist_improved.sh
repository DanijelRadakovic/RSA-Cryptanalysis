#!/bin/bash
#
#SBATCH --job-name=poly_select_dist
#SBATCH --output=poly_select.out

#SBATCH --ntasks=2 # change this to more appropriate value
#SBATCH --time=01:00:00
#SBATCH --mem-per-cpu=2048 # change this to more appropriate value

# Number that needs to be factored
N=1000000000000000000000000000000000000000000130000000000000000000000000000000000000000001089

# Path to MSIEVE binary
MSIEVE=./msieve

# Number of seconds that will be spent for polynomial selection
# Should be less than allowed time duration for job execution
# 0 means search forever
POLY_DEADLINE=20

# Number of processes should be same as number of tasks
NUM_PROC=2

b_min=1
b_max=100000
b_avg=$(( (b_max - b_min) / NUM_PROC ))

for (( i=0; i<${NUM_PROC}; i++ ))
  do
    b_start=$(( i * b_avg ))
    b_end=$(( (i+1) * b_avg ))
    srun -N1 -n1 -c1 --exclusive ${MSIEVE} -s "${i}msieve" \
      -np1 -nps "${b_start},${b_end} poly_deadline=${POLY_DEADLINE}" ${N} &
  done
wait

# Merge generated ${i}msieve.ms files into msieve.ms file
# This works only if all processes have been run on a single machine, otherwise
# you need merge file across multiple machines. Use scp tool or any other tool
# you feel comfortable with for solving this issue.
cat *.ms > msieve.dat.ms

srun -N1 -n1 -c1 --exclusive ${MSIEVE} -npr "poly_deadline=${POLY_DEADLINE}" ${N}

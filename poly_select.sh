#!/bin/bash
#
#SBATCH --job-name=poly_select
#SBATCH --output=poly_select.out
#
#SBATCH --ntasks=1
#SBATCH --time=01:00:00
#SBATCH --mem-per-cpu=2048 # change this to more appropriate value

# Number that needs to be factored
N=1000000000000000000000000000000000000000000130000000000000000000000000000000000000000001089

# Path to MSIEVE binary
MSIEVE=./msieve

# Number of seconds that will be spent for polynomial selection
# Should be less than allowed time duration for job execution
# 0 means search forever
POLY_DEADLINE=3600

srun ${MSIEVE} -np "poly_deadline=${POLY_DEADLINE}" ${N}

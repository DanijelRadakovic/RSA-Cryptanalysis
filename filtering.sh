#!/bin/bash
#
#SBATCH --job-name=filtering
#SBATCH --output=filtering.out
#
#SBATCH --ntasks=1
#SBATCH --time=01:00:00
#SBATCH --mem-per-cpu=2048 # change this to more appropriate value

# Number that needs to be factored
N=1000000000000000000000000000000000000000000130000000000000000000000000000000000000000001089

# Path to MSIEVE binary
MSIEVE=./msieve

srun ${MSIEVE} -nc1 "" ${N}
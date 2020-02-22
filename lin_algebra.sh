#!/bin/bash
#
#SBATCH --job-name=lin_algebra
#SBATCH --output=lin_algebra.out
#
#SBATCH --ntasks=2 # change this to more appropriate value
#SBATCH --cpus-per-task=4 # change this to more appropriate value
#SBATCH --mem-per-cpu=2048 # change this to more appropriate value

# Number that needs to be factored
N=1000000000000000000000000000000000000000000130000000000000000000000000000000000000000001089

# Path to MSIEVE binary
MSIEVE=./msieve

# Split a matrix on an X x Y grid of MPI processes
# Max value for X and Y is 35
X=30
Y=30

# Number of threads for single process
T=4

module load OpenMPI

srun ${MSIEVE} -t ${T} -nc2 ${X},${Y} ${N}
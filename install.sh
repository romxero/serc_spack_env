#!/bin/bash

compilers=(
    %gcc
    %intel
    %pgi
)

mpis=(
    openmpi+psm~verbs
    openmpi~psm+verbs
    mvapich2+psm~mrail
    mvapich2~psm+mrail
    mpich+verbs
)

for compiler in "${compilers[@]}"
do
    # Serial installs
    spack install szip           $compiler
    spack install hdf            $compiler
    spack install hdf5           $compiler
    spack install netcdf         $compiler
    spack install netcdf-fortran $compiler
    spack install ncview         $compiler

    # Parallel installs
    for mpi in "${mpis[@]}"
    do
        spack install $mpi            $compiler
        spack install hdf5~cxx+mpi    $compiler ^$mpi
        spack install parallel-netcdf $compiler ^$mpi
    done
done

#!/bin/bash
#SBATCH --job-name=SpackBuilds
#SBATCH --output=SpackBuilds_%A_%a.out
#SBATCH --error=SpackBuilds_%A_%a.err
#SBATCH --time=1-00:00:00
#SBATCH --ntasks=1 # how to scale the following to multiple tasks?
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=2G
#SBATCH -p serc,normal

#
#
#set -x #debug
#global variables
CORECOUNT=8 #main core count for compiling jobs

echo "This is the current directory we are working on : $PWD"

#make the build directory
mkdir -p charlesxBuild

#change directories
cd charlesxBuild

#purge the modules first
ml purge


#load these defacto modules
ml load cmake/3.23.1 gcc/10.1.0 openmpi/4.1.2 

#clone spack
git clone -c feature.manyFiles=true https://github.com/spack/spack.git



#backup old yaml files
mv spack/etc/spack/defaults/packages.yaml spack/etc/spack/defaults/packages.yaml_bak
mv spack/etc/spack/defaults/modules.yaml spack/etc/spack/defaults/modules.yaml_bak

#copy over the configuration files:
cp defaults/modules.yaml spack/etc/spack/defaults/modules.yaml
cp defaults/packages.yaml spack/etc/spack/defaults/packages.yaml


#source the spack environment
source spack/share/spack/setup-env.sh



#find the external libraries
#spack external find --all -p /share/software/user/open/icu/59.1
#spack external find --all -p /share/software/user/open/openmpi/4.1.2
#spack external find --all -p /share/software/user/open/libfabric/1.14.0
#spack external find --all -p /share/software/user/open/ucx/1.12.1
#spack external find --all -p /share/software/user/open/gcc/10.1.0
#spack external find --all -p /share/software/user/open/sqlite/3.37.2
#spack external find --all -p /share/software/user/open/tcltk/8.6.6
#spack external find --all -p /share/software/user/open/libressl/3.2.1
#spack external find --all -p /share/software/user/open/cmake/3.23.1
#spack external find --all -p /share/software/user/open/curl/7.81.0
#spack external find --all -p /share/software/user/open/openssl/3.0.2
#spack external find --all -p /share/software/user/open/libffi/3.2.1
#spack external find --all -p /share/software/user/open/readline/7.0
#spack external find --all -p /share/software/user/open/zlib/1.2.11

#redundant, but make sure the compiler is on file
spack compiler find /share/software/user/open/gcc/10.1.0


#############SOFTWARE/LIBRARY INSTALLS########################

#time to install dependencies
spack install sundials hdf5 boost eigen cantera parmetis



#################END_OF_SOFTWARE/LIBRARY_INSTALLS####################################


#have spack regenerate module files:

spack module lmod refresh --delete-tree -y


exit 0

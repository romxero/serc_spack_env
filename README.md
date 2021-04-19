# The SERC Spack environment

This is the Spack environment for SERC users on the Sherlock HPC System @ Stanford University.

By launching the install script it will; clone spack, copy over the configuration files, download and compile the needed compilers, and install software. 

It has an lmod Core based hierarchy that is helpful for many different packages.

## Files that may need to be modified

The install script should be modified for your platform of choice. Currently its hard coded for gcc 4.8.5 as its core compiler (CentOS 7).

The other file that definitely needs to be modified is the "modules.yaml" file within the defaults directory. The core compiler here is also gcc 4.8.5 which is based on CentOS 7. 

The packages.yaml can and should be modified to your given needs on the platform. 

seismic_melts Readme
===========

This directory contains the MATLAB source and support files for 
the MATLAB Seismic Melts Toolkit. To install and use the toolkit, 
follow the instructions below.

License and copyright
---------------------

Seismic_melts is distributed under the terms of a MIT style license. This 
means you can redistribute the toolkit as long as you follow three simple 
rules outlined near the top of each Matlab source file.  Copyright remains 
with the authors, Amicia Lee and Andrew Walker with other copyright holders 
named in individual source files. 

Installing
----------

To use seismic_melts you first need to install the MTEX and MSAT toolboxes.

MTEX
****

Download MTEX from the following link:
http://mtex-toolbox.github.io/download
1. download and extract the zip file to an arbitrary folder
2. start Matlab (version 2012b or newer required - older versions have not 
been tested)
3. change the current folder in Matlab to the folder where MTEX is installed
4. type startup_mtex into the command window

MSAT
****

Download MSAT from the following link:
https://www1.gly.bris.ac.uk/MSAT/
1. uncompress the distributed tar file 
2. installation is completed by telling Matlab where to find the source code 
and documentation. 
3. Start up Matlab and use the "Set Path..." option from the File menu to 
open the path setting dialogue. 
4. Use the "Add Folder..." button to open a file browser, navigate the msat 
subdirectory (of the directory containing this file), select it and choose 
"open". This adds the MSAT functions and documentation to your path. 
5. Choose "Save" to make this change permanent.  

To use seismic_melts, simply navigate to the directory and run the 
SeismicMelts test script

Documentation
-------------

Once seismic_melts has been installed documentation on all functions can be 
found by typing "help MS_funcname" at the Matlab command prompt. Documentation can 
also be found using the Matlab help browser and clicking on the MSAT Toolbox 
section of the contents page.

Further help
------------

For additional assistance contact the authors, Amicia Lee
<earall@leeds.ac.uk> and Andrew Walker <a.walker@leeds.ac.uk>.


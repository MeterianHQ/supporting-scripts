# supporting-scripts
A set of supporting scripts to use in conjunction with Meterian to work around specific scenarios 

## ant-unpack.sh
This script can be run targeting any war/ear file. It will export in the current directory (or in the directory specified)
all the jar files contained in the archive, plus a dummy build.xml file so that Meterian can be launched for the analysis


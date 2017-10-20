#############################################################################################################################
#
#  Program to read TOB3 binary files from the Campbell Scientific memory cards.
# The TOB3 is a proprietary fromat therefore is ts better to use the tools that Campbell Scientific has already developed
# The Loggernet software utility by Campbell, come with a C program to convert the TOB3 format to other formats.
# its documentation can be found on section B.4 "Converting Binary File Formats" of the Loggernet Manual.
# B.4.5 TOB32.EXE
#
# The TOB32.EXE command line utility is installed by default in the LoggerNet
# program directory at C:\Program Files\Campbellsci\Loggernet\tob32.exe. The
# output is similar to CardConvert. Command line switches are used to determine
# the new file format that will be created. Some of the basic switches available
# are listed below:
#   -h or -? | Help
# -a | ASCII (TOA5) Generates CSI Table Oriented ASCII version 5
# format files
# -b | Binary (TOB1) Generates CSI Table Oriented Binary version 1
# format files
# Some examples using these switches include:
#   tob32.exe -a mydata.dat (converts mydata.dat to TOA5 format)
# tob32.exe -b mydata.dat (converts mydata.dat to TOB1 format)
# 
# The idea of calling the Cprogram TOB32.EXE from R came from  Darren Wilkinson's research blog "Calling C code from R" at:
# https://darrenjw.wordpress.com/2010/12/30/calling-c-code-from-r/
#
# Other Sources are:
# https://cran.r-project.org/doc/manuals/r-release/R-exts.html
# http://www.biostat.jhsph.edu/~rpeng/docs/interface.pdf
# 
# 
#
#  Felipe Montes,  2017/08/02
#
##############################################################################################################################


############################### Record Time To start##########################################################



TimeStart<-Sys.time()  ;



###############################################################################################################
#                          Loading Packages and setting up working directory                        
###############################################################################################################



#  Tell the program where the package libraries are  #####################


.libPaths("C:/Felipe/Sotware&Coding/R_Library/library")  ;

#  Set Working directory


setwd("C:\\Felipe\\Willow_Project\\Willow_Experiments\\Willow_Rockview\\EddyCovarianceData_Felipe\\RCode\\TOB3intoR") ; 



###############################################################################################################
#                         Call packages needed to process the data 
#                             
###############################################################################################################



###############################################################################################################
#                        Example from "Calling C code from R"
###############################################################################################################

#   Cprogram

# #include <stdio.h>
# #include <math.h>
# #include <stdlib.h>
# #include <gsl/gsl_rng.h>
# #include <gsl/gsl_randist.h>
# 
# int main(int argc, char *argv[])
# {
#   if (argc!=4) {
#     fprintf(stderr,"Usage: %s <Iters> <Thin> <Seed>\n",argv[0]);
#     exit(EXIT_FAILURE);
#   }
#   long N=(long) atoi(argv[1]);
#   long thin=(long) atoi(argv[2]);
#   long seed=(long) atoi(argv[3]);
#   long i,j;
#   gsl_rng *r = gsl_rng_alloc(gsl_rng_mt19937);
#   gsl_rng_set(r,seed);
#   double x=0;
#   double y=0;
#   printf("Iter x y\n");
#   for (i=0;i<N;i++) {
#     for (j=0;j<thin;j++) {
#       x=gsl_ran_gamma(r,3.0,1.0/(y*y+4));
#       y=1.0/(x+1)+gsl_ran_gaussian(r,1.0/sqrt(x+1));
#     }
#     printf("%ld %f %f\n",i,x,y);
#   }
#   exit(EXIT_SUCCESS);
# }

# R code to call the c program
# 
# standalone<-function(N=10000,thin=500,
#                      seed=trunc(runif(1)*1e6),
#                      exec=file.path(".","standalone"),
#                      tmpfile=tempfile())
# {
#   command=paste(exec,N,thin,seed,">",tmpfile)
#   system(command)
#   read.table(tmpfile,header=TRUE)
# }

###############################################################################################################
#                        Using TOB32.exe from R
###############################################################################################################

# TOB32.exe

# C:\Program Files (x86)\Campbellsci\LoggerNet>.\tob32 -H
# .\tob32 -H
# v12.00
# Switches:
#   H|Help gives this message
# ?|?    gives this message
# d|DaDisp Sets output file format to DaDisp
# a|ASCII  (TOA5)  Output CSI Table Oriented ASCII version 5 format
# b|binary (TOB1) Output CSI Table Oriented Binary version 1 format
# e|EASE   Output EASE format(not implemented)
# f|check discontinuities, and fill missing floating data with NaN
# with scan_sec &scan_nano inputs
# i|ID2000  Output ID2000 format
# n|notime do not output timestamps on TOA5 output
# m ?| blank: create one output file per file marker,
# 0: don't care,        1: per file mark,
# 2: per removal mark,  3: per either mark
# 
# o|create output on specified path
# r|output record number
# s|check discontinuities, and start new files for them
# with scan_sec &scan_nano inputs
# v|verbose output to CSIDebug.log
# 
# examples:
# tob32 -d mydata.dat --converts to DaDisp format
# tob32 -a mydata.dat --converts to TOA5 format
# tob32 -b mydata.dat --converts to TOB1 format
# tob32 -f 0;0 -b mydata.dat --TOB1 format with discontinuities check
# tob32 -i mydata.dat --converts to ID2000 format
# tob32 -a -o d:\outpath\  mydata.dat --converts "mydata.dat",
# to TOA5 format, in directory \outputpath\


###############################################################################################################
#                        Program
###############################################################################################################



# Path C:\Felipe\Willow Project\Willow Experiments\Willow Rockview\EddyCovarianceData_Felipe\
# 2017\Willow\WillowOpenPathEddyCovarianceData\EC_W_OP_20170519


#######  get a list of the directories that have the files with the data



TOB3.Directories<-list.dirs("C:\\Felipe\\Willow_Project\\Willow_Experiments\\Willow_Rockview\\EddyCovarianceData_Felipe\\2017\\Corn\\CornClosedPathEddyCovarianceData", recursive=T) ;

#  C:\Felipe\Willow_Project\Willow_Experiments\Willow_Rockview\EddyCovarianceData_Felipe\2017\Corn\CornClosedPathEddyCovarianceData

#  C:\Felipe\Willow_Project\Willow_Experiments\Willow_Rockview\EddyCovarianceData_Felipe\2017\Corn\CornOpenPathEddyCovarianceData

#  C:\\Felipe\\Willow_Project\\Willow_Experiments\\Willow_Rockview\\EddyCovarianceData_Felipe\\2017\\Willow\\WillowOpenPathEddyCovarianceData

#######  From each directory get the file list and get the flux file 

TOB3.file<-list.files(TOB3.Directories[7])[grep("lux", list.files(TOB3.Directories[7]), value=F)] ;

######  create the name of the output file after convesion to TOA5


#  Create directory name for the output 

Dir.name<-paste0("./",strsplit(TOB3.Directories[7],split="/")[[1]][2]) ;


#TOA5.file<-paste(Dir.name,unlist(strsplit(TOB3.file,split="[.]"))[2],"TOA5",sep="_") ;


dir.create(Dir.name)


# tob32.exe
# -a -o
# ./6358.Fluxxx.TOA5
# paste(TOB3.Directories[2],TOB3.file, sep="\\")
# "C:\\Felipe\\Willow Project\\Willow Experiments\\Willow Rockview\\EddyCovarianceData_Felipe\\2017\\Willow\
# \WillowOpenPathEddyCovarianceData/EC_W_OP_20170519\\6463.flux.dat\
# 


TOB3toTOA5inst<-paste0('tob32.exe -a -o ',Dir.name,"/ ", paste(TOB3.Directories[7],TOB3.file, sep="\\"))

######  Pass the file information to Tob32.exe   ############


system(TOB3toTOA5inst) ;

system("tob32.exe --?");


####### Add plots of the data to diagnose possible data errors based on the Rcode InspectFlux_OpenPath



#######Get the name of the table that is going to  be ploted

Name.parts<-strsplit(TOB3.file,'[.]')  ;


assign('Flux.names', read.csv( paste0(Dir.name,"/",Name.parts[[1]][1],".",Name.parts[[1]][2], ".TOA") , skip=1,header=F,nrows=1,as.is=T));

assign('Flux.units', read.csv( paste0(Dir.name,"/",Name.parts[[1]][1],".",Name.parts[[1]][2], ".TOA") , skip=2,header=F,nrows=1,as.is=T)); 

assign('Flux.units2', read.csv(paste0(Dir.name,"/",Name.parts[[1]][1],".",Name.parts[[1]][2], ".TOA") , skip=3,header=F,nrows=1,as.is=T));

Flux.data<-read.csv( paste0(Dir.name,"/",Name.parts[[1]][1],".",Name.parts[[1]][2], ".TOA"), skip=6,header=F,as.is=T,col.names=Flux.names)





assign('Flux.names', read.csv(paste(TOB3.Directories[7],TOB3.file, sep="\\"),skip=1,header=F,nrows=1,as.is=T));

assign('Flux.units', read.csv(paste(TOB3.Directories[7],TOB3.file, sep="\\"),skip=2,header=F,nrows=1,as.is=T));      

assign('Flux.units2', read.csv(paste(TOB3.Directories[7],TOB3.file, sep="\\"),skip=3,header=F,nrows=1,as.is=T));

#Read the Flux Files to compare


Flux.data<-read.csv(paste(TOB3.Directories[7],TOB3.file, sep="\\"), skip=6,header=F,as.is=T,col.names=Flux.names)


# Plot the different fluxes


Npoints_1<-seq((dim(Flux.data_1)[1]-1100),dim(Flux.data_1)[1]) ;

Npoints_2<-seq((dim(Flux.data_2)[1]-1100),dim(Flux.data_2)[1]) ;
#Npoints<-seq(1:200);

plot(as.POSIXct(Flux.data_1$TIMESTAMP[Npoints_1]),Flux.data_1$CO2_wpl_LE[Npoints_1],type="l",col="GREEN", ylim=c(-0.5,0.5));
points(as.POSIXct(Flux.data_1$TIMESTAMP[Npoints_1]),Flux.data_1$CO2_wpl_H[Npoints_1],type="l",col="BLUE" );
points(as.POSIXct(Flux.data_1$TIMESTAMP[Npoints_1]),Flux.data_1$CO2_wpl_H[Npoints_1]+Flux.data_1$CO2_wpl_LE[Npoints_1],type="l",col="RED"  );

plot(as.POSIXct(Flux.data_2$TIMESTAMP[Npoints_2]),Flux.data_2$CO2_wpl_LE[Npoints_2],type="l",col="GREEN", ylim=c(-0.5,0.5));
points(as.POSIXct(Flux.data_2$TIMESTAMP[Npoints_2]),Flux.data_2$CO2_wpl_H[Npoints_2],type="l",col="BLUE" );
points(as.POSIXct(Flux.data_2$TIMESTAMP[Npoints_2]),Flux.data_2$CO2_wpl_H[Npoints_2]+Flux.data_2$CO2_wpl_LE[Npoints_2],type="l",col="RED"  );

plot(as.POSIXct(Flux.data_3$TIMESTAMP[Npoints]),Flux.data_3$CO2_wpl_LE[Npoints],type="l",col="GREEN", ylim=c(-0.5,0.5));
points(as.POSIXct(Flux.data_3$TIMESTAMP[Npoints]),Flux.data_3$CO2_wpl_H[Npoints],type="l",col="BLUE" );
points(as.POSIXct(Flux.data_3$TIMESTAMP[Npoints]),Flux.data_3$CO2_wpl_H[Npoints]+Flux.data_3$CO2_wpl_LE[Npoints],type="l",col="RED"  );







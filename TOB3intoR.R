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


setwd("C:/Felipe/PIHM-CYCLES/PIHM/PIHM_Felipe/CNS/WE-38/WE38_Files_PIHM_Cycles20170208/SWATPIHMRcode") ; 


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



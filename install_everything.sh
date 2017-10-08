#######################################
##	Programs setup
#######################################

##	Update and Upgrade ##

sudo apt update
sudo apt upgrade

##	CMake	##

sudo apt install cmake

##	Git	##

sudo apt install git

##	SVN 	##

sudo apt install subversion

##	Build Essentials ##

sudo apt install build-essential

########################################
##	  Setup Driectories
#######################################

##	Programs 	##

mkdir ~/programs

##	Working	##

mkdir ~/sigma

#######################################
##		GCC
######################################

cd ~/programs/
mkdir gcc
cd gcc
mkdir srcdir
mkdir objdir
mkdir dist

svn co svn://gcc.gnu.org/svn/gcc/trunk srcdir

cd $HOME/programs/gcc/objdir

sudo apt install libgmp-dev libmpc-dev libmpfr-dev fastjar zip

.$HOME/programs/gcc/srcdir/configure --prefix=$HOME/programs/gcc/dist --enable-languages=c,c++ --disable-multilib

make -j 8

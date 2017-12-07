# Note, requires:
#    libgmp-dev libmpc-dev libmpfr-dev fastjar zip

if [ -z "$1" ]; then
    echo "Usage: $0 <install_location>"
    exit -1
fi

execute() {
    echo "$1"
    $1
    if [ $? -ne 0 ]; then
        printf "\n** FAILED **\n"
        exit $?
    fi
}

execute "cd $1"
INSTALL_DIR=$PWD
GCC_TRUNK="svn://gcc.gnu.org/svn/gcc/trunk"
CPU_CORES="$(grep -c ^processor /proc/cpuinfo)"
GCC_DIR="$INSTALL_DIR/gcc"
SRC_DIR="$GCC_DIR/src"
BUILD_DIR="$GCC_DIR/build"
DIST_DIR="$GCC_DIR/dist"

# Directory setup
execute "mkdir $GCC_DIR"
execute "mkdir $SRC_DIR"
execute "mkdir $BUILD_DIR"
execute "mkdir $DIST_DIR"

# Checkout source
execute "svn co $GCC_TRUNK $SRC_DIR"

# Configuration
execute "cd $BUILD_DIR"
execute "$SRC_DIR/./configure --prefix=$DIST_DIR --enable-languages=c,c++ --disable-multilib"

# Build
execute "make -j $CPU_CORES"

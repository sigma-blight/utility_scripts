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
CPU_CORES="$(grep -c ^processor /proc/cpuinfo)"
CLANG_TRUNK="http://llvm.org/svn/llvm-project/llvm/trunk"
LLVM_DIR="$INSTALL_DIR/llvm"
BUILD_DIR="$INSTALL_DIR/llvm_build"

printf "\n** LLVM CLANG INSTALL **\n\n"

# Check out LLVM
execute "svn co http://llvm.org/svn/llvm-project/llvm/trunk $LLVM_DIR"

# Check out Clang
execute "cd $LLVM_DIR/tools"
execute "svn co http://llvm.org/svn/llvm-project/cfe/trunk clang"

# Check out extra Clang tools
execute "cd $LLVM_DIR/tools/clang/tools"
execute "svn co http://llvm.org/svn/llvm-project/clang-tools-extra/trunk extra"

# Check out Compiler-RT
execute "cd $LLVM_DIR/projects"
execute "svn co http://llvm.org/svn/llvm-project/compiler-rt/trunk compiler-rt"

# Check out libcxx
execute "cd $LLVM_DIR/projects"
execute "svn co http://llvm.org/svn/llvm-project/libcxx/trunk libcxx"

# Build LLVM and Clang
execute "mkdir $BUID_DIR"
execute "cd $BUID_DIR"
execute "cmake -G \"Ninja\" -DCMAKE_BUILD_TYPE=Release $LLVM_DIR"
execute "make -j $CPU_CORES"

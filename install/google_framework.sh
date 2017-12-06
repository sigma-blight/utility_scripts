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

printf "\n** GOOGLE FRAMEWORK INSTALL **\n\n"

execute "cd $1"
INSTALL_DIR=$PWD
CMAKE_ARGS="-DCMAKE_BUILD_TYPE=Release"
MAKE_ARGS="-j"
GTEST_REPO="https://github.com/google/googletest.git"
GBENCH_REPO="https://github.com/google/benchmark.git"

printf "\n** INSTALLING GOOGLE TEST **\n\n"

GTEST_DIR="$INSTALL_DIR/googletest/googletest"
GMOCK_DIR="$INSTALL_DIR/googletest/googlemock"
GTEST_BUILD_DIR="$INSTALL_DIR/gtest_build"
GMOCK_BUILD_DIR="$INSTALL_DIR/gmock_build"
GTEST_LIB_DIR="$INSTALL_DIR/gtest_lib"
GTEST_INC_DIR="$INSTALL_DIR/gtest_include"

execute "cd $INSTALL_DIR"
execute "git clone $GTEST_REPO"

execute "mkdir $GTEST_BUILD_DIR"
execute "cd $GTEST_BUILD_DIR"
execute "cmake $GTEST_DIR $CMAKE_ARGS"
execute "make $MAKE_ARGS"

execute "mkdir $GTEST_LIB_DIR"
execute "mkdir $GTEST_INC_DIR"
execute "cp $GTEST_BUILD_DIR/*.a $GTEST_LIB_DIR/"
execute "cp -rf $GTEST_DIR/include/* $GTEST_INC_DIR/"

execute "mkdir $GMOCK_BUILD_DIR"
execute "cd $GMOCK_BUILD_DIR"
execute "cmake $GMOCK_DIR $CMAKE_ARGS"
execute "make $MAKE_ARGS"

execute "cp $GMOCK_BUILD_DIR/*.a $GTEST_LIB_DIR/"
execute "cp -rf $GMOCK_DIR/include/* $GTEST_INC_DIR/"

printf "\n** INSTALLING GOOGLE BENCHMARK **\n\n"

GBENCH_DIR="$INSTALL_DIR/benchmark"
GBENCH_BUILD_DIR="$INSTALL_DIR/gbench_build"
GBENCH_LIB_DIR="$INSTALL_DIR/gbench_lib"
GBENCH_INC_DIR="$INSTALL_DIR/gbench_include"

execute "cd $INSTALL_DIR"
execute "git clone $GBENCH_REPO"

execute "mkdir $GBENCH_BUILD_DIR"
execute "cd $GBENCH_BUILD_DIR"
execute "cmake $GBENCH_DIR $CMAKE_ARGS"
execute "make $MAKE_ARGS"

execute "mkdir $GBENCH_LIB_DIR"
execute "mkdir $GBENCH_INC_DIR"
execute "cp $GBENCH_BUILD_DIR/src/*.a $GBENCH_LIB_DIR"
execute "cp -rf $GBENCH_DIR/include/* $GBENCH_INC_DIR"

printf "\n** GOOGLE FRAMEWORK INSTALLED **\n"

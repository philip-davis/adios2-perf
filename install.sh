#!/bin/bash -e

MACHINE=${MACHINE:-summit}

INSTALL_DIR=${PWD}/install
ADIOS2_DIR=${INSTALL_DIR}/ADIOS2
LIBFABRIC_DIR=${INSTALL_DIR}/libfabric

if [ "${MACHINE}" == "cori" ] ; then
    module unload darshan
    module load cmake/3.14.4
    module load python/3.6-anaconda-4.4
    export CRAYPE_LINK_TYPE=dynamic
    export CC=cc
    export CXX=CC
    export FC=ftn
elif [ "${MACHINE}" == "theta" ] ; then
    module unload darshan
    module load cmake/3.14.5
    module load cray-python/3.6.5.3
    export CRAYPE_LINK_TYPE=dynamic
    export CC=cc
    export CXX=CC
    export FC=ftn
elif [ "${MACHINE}" == "summit" ] ; then
    module unload darshan-runtime
    module load cmake
    module load python/3.6.6-anaconda3-5.3.0
    export CC=mpicc
    export CXX=mpic++
    export FC=mpifort
fi

if [ ! -d ${INSTALL_DIR} ] ; then
    mkdir ${INSTALL_DIR}
fi

if [ ! -d ${LIBFABRIC_DIR} ] ; then
    mkdir ${LIBFABRIC_DIR}
fi
cd libfabric
./autogen.sh
./configure --prefix=${LIBFABRIC_DIR} --disable-usnic --disable-verbs CC=${CC}
make clean
make
make install
cd ..

export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:${LIBFABRIC_DIR}/lib/pkgconfig

if [ ! -d ${ADIOS2_DIR} ] ; then
    mkdir ${ADIOS2_DIR}
fi
if [ "${MACHINE}" == "summit" ] ; then
    MACHINE_CMAKE_FLAGS="-DCMAKE_BUILD_TYPE=Debug"
fi
cd ADIOS2
if [ ! -d build ] ; then
    mkdir build
fi
cd build
rm -f CMakeCache.txt
cmake .. -DCMAKE_C_COMPILER=${CC} -DCMAKE_CXX_COMPILER=${CXX} -DCMAKE_Fortran_COMPILER=${FC} -DCMAKE_BUILD_TYPE=shared -DCMAKE_INSTALL_PREFIX=${ADIOS2_DIR} -DADIOS2_USE_PNG=Off -DADIOS2_USE_BZIP=Off ${MACHINE_CMAKE_FLAGS}
make -j
make install

export PYTHONPATH=$PYTHONPATH:${ADIOS2_DIR}/lib64/python3.6/site-packages
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${ADIOS2_DIR}/lib64
cd ../../adiosvm/Tutorial/gray-scott
rm -rf build
mkdir build
cd build
cmake .. -DADIOS2_DIR=${ADIOS2_DIR}/lib64/cmake/adios2 #-DUSE_TIMERS=Yes
make -j

cd ../../../..
cd tau2
./configure -mpi -pthread -bfd=download
make install
cd ..

./createenv.sh

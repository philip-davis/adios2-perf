MACHINE=cori

ADIOS2_DIR=${PWD}/install/ADIOS2

if [ "${MACHINE}" == "cori" ] ; then
    module unload darshan
    module load cmake/3.14.4
    module load python/3.6-anaconda-4.4
    export CRAYPE_LINK_TYPE=dynamic
fi

if [ ! -d ${ADIOS2_DIR} ] ; then
    mkdir ${ADIOS2_DIR}
fi
cd ADIOS2
#rm -rf build
#mkdir build
cd build
#cmake .. -DCMAKE_C_COMPILER=cc -DCMAKE_CXX_COMPILER=CC -DCMAKE_Fortran_COMPILER=ftn -DCMAKE_BUILD_TYPE=shared -DCMAKE_INSTALL_PREFIX=${ADIOS2_DIR}
#make
#make install

#export PYTHONPATH=$PYTHONPATH:${ADIOS2_DIR}/lib64/python3.6/site-packages
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${ADIOS2_DIR}/lib64
cd ../../adiosvm/Tutorial/gray-scott
rm -rf build
mkdir build
cd build
cmake .. -DADIOS2_DIR=${ADIOS2_DIR}/lib64/cmake/adios2
make

#----------------------------------------------------------------
# Generated CMake target import file for configuration "shared".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "adios2::sst" for configuration "shared"
set_property(TARGET adios2::sst APPEND PROPERTY IMPORTED_CONFIGURATIONS SHARED)
set_target_properties(adios2::sst PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_SHARED "adios2::taustubs"
  IMPORTED_LOCATION_SHARED "${_IMPORT_PREFIX}/lib64/libadios2_sst.so.2.4.0"
  IMPORTED_SONAME_SHARED "libadios2_sst.so.2"
  )

list(APPEND _IMPORT_CHECK_TARGETS adios2::sst )
list(APPEND _IMPORT_CHECK_FILES_FOR_adios2::sst "${_IMPORT_PREFIX}/lib64/libadios2_sst.so.2.4.0" )

# Import target "adios2::adios2" for configuration "shared"
set_property(TARGET adios2::adios2 APPEND PROPERTY IMPORTED_CONFIGURATIONS SHARED)
set_target_properties(adios2::adios2 PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_SHARED "adios2::taustubs;adios2::sst"
  IMPORTED_LOCATION_SHARED "${_IMPORT_PREFIX}/lib64/libadios2.so.2.4.0"
  IMPORTED_SONAME_SHARED "libadios2.so.2"
  )

list(APPEND _IMPORT_CHECK_TARGETS adios2::adios2 )
list(APPEND _IMPORT_CHECK_FILES_FOR_adios2::adios2 "${_IMPORT_PREFIX}/lib64/libadios2.so.2.4.0" )

# Import target "adios2::taustubs" for configuration "shared"
set_property(TARGET adios2::taustubs APPEND PROPERTY IMPORTED_CONFIGURATIONS SHARED)
set_target_properties(adios2::taustubs PROPERTIES
  IMPORTED_LOCATION_SHARED "${_IMPORT_PREFIX}/lib64/libtaustubs.so"
  IMPORTED_SONAME_SHARED "libtaustubs.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS adios2::taustubs )
list(APPEND _IMPORT_CHECK_FILES_FOR_adios2::taustubs "${_IMPORT_PREFIX}/lib64/libtaustubs.so" )

# Import target "adios2::adios2_f" for configuration "shared"
set_property(TARGET adios2::adios2_f APPEND PROPERTY IMPORTED_CONFIGURATIONS SHARED)
set_target_properties(adios2::adios2_f PROPERTIES
  IMPORTED_LOCATION_SHARED "${_IMPORT_PREFIX}/lib64/libadios2_f.so"
  IMPORTED_SONAME_SHARED "libadios2_f.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS adios2::adios2_f )
list(APPEND _IMPORT_CHECK_FILES_FOR_adios2::adios2_f "${_IMPORT_PREFIX}/lib64/libadios2_f.so" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)

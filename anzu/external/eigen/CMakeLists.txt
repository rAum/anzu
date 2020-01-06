# TODO(rAum): make system Eigen as optional and try to ship with source

find_package(Eigen3 QUIET)

if(NOT TARGET Eigen3::Eigen)
    if (EIGEN3_INCLUDE_DIRS)
        message("Eigen is missing correct package, but headers are found.. Fixing.")
        message(STATUS "Eigen workaround: imported library with include dir: ${EIGEN3_INCLUDE_DIRS}")
        add_library(Eigen INTERFACE IMPORTED GLOBAL)
        target_include_directories(Eigen SYSTEM INTERFACE "${EIGEN3_INCLUDE_DIRS}")
        add_library(Eigen3::Eigen ALIAS Eigen)
    else()
        add_library(Eigen INTERFACE IMPORTED GLOBAL)
        target_include_directories(Eigen SYSTEM INTERFACE "${CMAKE_CURRENT_LIST_DIR}/include/eigen3.3.7")
        add_library(Eigen3::Eigen ALIAS Eigen)
    endif()
else()
    message(STATUS "Using system Eigen")
endif()
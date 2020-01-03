cmake_minimum_required(VERSION 3.15)
include("${CMAKE_CURRENT_SOURCE_DIR}/meta-info.cmake")
project(anzu
        VERSION ${project_version}
        DESCRIPTION ${project_description}
        HOMEPAGE_URL ${project_homepage}
        LANGUAGES CXX) #CUDA

add_subdirectory(libanzu)

add_executable(anzu-main main.cpp)
target_link_libraries(anzu-main PRIVATE libanzu)


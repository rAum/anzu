cmake_minimum_required(VERSION 3.15)
include("${CMAKE_CURRENT_SOURCE_DIR}/meta-info.cmake")
project(libanzu
        VERSION ${project_version}
        DESCRIPTION ${project_description}
        HOMEPAGE_URL ${project_homepage}
        LANGUAGES CXX)

add_library(${PROJECT_NAME}
        src/lib.cpp
)
target_include_directories(${PROJECT_NAME} PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include/>
        $<INSTALL_INTERFACE:include/>)
target_include_directories(${PROJECT_NAME} PRIVATE $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/src/include/>)
set_target_properties(${PROJECT_NAME} PROPERTIES
        CXX_VISIBILITY_PRESET hidden
        VISIBILITY_INLINES_HIDDEN 1)
target_link_libraries(${PROJECT_NAME} PRIVATE
        anzu_build_flags
)

#################################

install(TARGETS ${PROJECT_NAME}
        EXPORT ${PROJECT_NAME}-export
        COMPONENT libanzu-dev)

install(DIRECTORY include/
        DESTINATION include/
        COMPONENT libanzu-dev)

install(EXPORT ${PROJECT_NAME}-export
        FILE ${PROJECT_NAME}Config.cmake
        DESTINATION share/${PROJECT_NAME}
        COMPONENT libanzu-dev)

include(CMakePackageConfigHelpers)
write_basic_package_version_file("${PROJECT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
        VERSION ${PROJECT_VERSION}
        COMPATIBILITY AnyNewerVersion )
install(FILES
        "${PROJECT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
        DESTINATION share/${PROJECT_NAME}
        COMPONENT libanzu-dev)

export(TARGETS ${PROJECT_NAME} FILE ${PROJECT_NAME}Targets.cmake)
export(PACKAGE ${PROJECT_NAME})

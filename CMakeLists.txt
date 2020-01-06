cmake_minimum_required(VERSION 3.15)
project(anzu-all
	VERSION 0.0.0
	LANGUAGES NONE)

option(ANZU_ALL_CPACK "Turns on/off cpack package generation for whole project." OFF)

add_subdirectory(anzu)

# A reason behind keeping cpack behind option is if someone wants
# to use anzu inside other project, by embedding it inside existing 
# cmake project - and the project uses cpack as well - it will mix
# variables which is bad (from experience)
# CPack does not support multiple include(CPack) calls.
if (ANZU_ALL_CPACK)
message(STATUS "CPACK enabled for all anzu libs/apps.")

set(CPACK_PACKAGE_VENDOR "Anzu")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Anzu is an experimental library with building blocks for vision/graphics/other applications and other apps")
set(CPACK_PACKAGE_CONTACT "https://github.com/rAum/anzu/")
set(CPACK_DEBIAN_PACKAGE_MAINTAINER "https://github.com/rAum/anzu/")
set(CPACK_PACKAGE_VERSION_MAJOR ${PROJECT_VERSION_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR ${PROJECT_VERSION_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH ${PROJECT_VERSION_PATCH})
set(CPACK_SOURCE_IGNORE_FILES
        /.git
        /.*build.*
        )
#set(CPACK_STRIP_FILES 1)
set(CPACK_PACKAGE_FILE_NAME "${PROJECT_NAME}_${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.${PROJECT_VERSION_PATCH}-${CPACK_SYSTEM_NAME}")
set(CPACK_DEBIAN_PACKAGE_LICENSE "MIT")
set(CPACK_RESOURCE_FILE_LICENSE ${CMAKE_CURRENT_LIST_DIR}/LICENSE)

include(CPack)
endif()

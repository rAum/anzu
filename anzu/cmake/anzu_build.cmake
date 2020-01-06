# For development it is important to have warnings enabled, preferable with
# Werror to ensure that all problems are fixed or correctly suppressed.
# However in downstream projects it's not desirable - for example due to different
# compiler a different set of warnings is used and library fails to build.
# Therefore it is important to suppress such noise as this should not be something
# bothering end user.

# This is a common target which contains flags that should be used to build anzu projects.
# It is strongly requested to use this target only as PRIVATE dependency to prevent leaks.
add_library(anzu_build_flags INTERFACE)

#TODO: Flags are for gcc/clang. Extend for other compilers.
option(ANZU_WITH_WARNINGS "Turns on/off warnings" ON)
if (ANZU_WITH_WARNINGS AND NOT WIN32)
    message("Warnings are enabled")
    target_compile_options(anzu_build_flags INTERFACE -Wall -Wpedantic -Wextra)
endif()

option(ANZU_WITH_WERROR "Turns on/off treating warnings as errors" OFF)
if (ANZU_WITH_WERROR AND NOT WIN32)
    message("Warnings as errors are enabled.")
    target_compile_options(anzu_build_flags INTERFACE -Werror)
endif()

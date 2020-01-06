# For development it is important to have warnings enabled, preferable with
# Werror to ensure that all problems are fixed or correctly suppressed.
# However in downstream projects it's not desirable - for example due to different
# compiler a different set of warnings is used and library fails to build.
# Therefore it is important to suppress such noise as this should not be something
# bothering end user.

# This is a common target which contains flags that should be used to build anzu projects.
# It is strongly requested to use this target only as PRIVATE dependency to prevent leaks.
# Now, why INTERFACE IMPORTED?
# INTERFACE - means we don't need to compile or link anything, OBJECT has different semantic.
# IMPORTED - this is only set because if cmake is really stubborn and errors when one try to
#            export a library which link to this target, even if it is private..
#            see https://gitlab.kitware.com/cmake/cmake/issues/17357
add_library(anzu_build_flags INTERFACE IMPORTED)

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

# TODO(rAum): think of what can be enabled on msvc
option(ANZU_NATIVE_RELEASE_BUILD "Turns on/off native build optimization flags" OFF)
if(ANZU_NATIVE_RELEASE_BUILD)
    if (NOT WIN32)
        message("Native build is enabled")
        set(ReleaseFlags "-march=native -mtune=native")
        target_compile_options(anzu_build_flags INTERFACE $<$<CONFIG:RELEASE>:${ReleaseFlags}>)
    else()
        message(WARNING "Currently only non-windows platforms are supported for ANZU_NATIVE_RELEASE_BUILD")
    endif()
endif()
# To speed up recompilation one can use ccache.
# However it makes little sense to use if your not actively developing library
# because first compilation is slow due to cost to create cache.
#
# Below is quite transparent way to allow ccache to be used if:
# * ccache is installed
# * user requested to use ccache by setting cmake flag
# * is not on Windows platform
#
if (ANZU_USE_CCACHE)
  message(STATUS "recompilation speedup is requested. Looking for ccache..")
  find_program(CCACHE_PROGRAM ccache)
  if(CCACHE_PROGRAM)
    message(STATUS "ccache is present and enabled for compile and link [${CCACHE_PROGRAM}]")
    set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE "${CCACHE_PROGRAM}")
    set_property(GLOBAL PROPERTY RULE_LAUNCH_LINK "${CCACHE_PROGRAM}")
    set(ANZU_COMPILER_IS_CCACHE TRUE)
  else()
    message(WARNING "ccache is not found.")
    set(ANZU_COMPILER_IS_CCACHE FALSE)
    # TODO(rAum): ccache is present on unix platforms, what to do about Windows?
    # This check is not the greatest because it might be possible to get ccache work there
    # or there are other tools...
    if (WIN32)
      message("Note: ccache is not available on Windows platform.")
    else()
      message("Check if it's installed and can be found in PATH.")
    endif()
  endif()
else()
  set(ANZU_COMPILER_IS_CCACHE FALSE)
endif()

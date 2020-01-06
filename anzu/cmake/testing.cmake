# This helper modules adds functions to simplify adding tests based on doctest framework

if(BUILD_TESTING)
  option(ANZU_BUILD_TESTS "Turns on/off building of tests" ON)
  if (ANZU_BUILD_TESTS)
      if (NOT TARGET doctest) # this should not ever happen!
          message(SEND_ERROR "Failed to locate doctest framework.")
      endif()
      message(STATUS "Tests are enabled")

      # TODO(rAum): extend with named args to allow defining more options
      function (cxx_test NAME SOURCES LIBS)
          set(TEST_NAME "test_${NAME}")
          add_executable(${TEST_NAME} ${SOURCES})
          target_link_libraries(${TEST_NAME} doctest::doctest ${LIBS})
          add_test(${TEST_NAME} ${TEST_NAME})
          target_compile_definitions(${TEST_NAME} PRIVATE TESTDATA_DIR="${CMAKE_SOURCE_DIR}/testdata" )
      endfunction()
  else()
      message(AUTHOR_WARNING "Testing is enabled but anzu tests are disabled. Setup cmake with ANZU_BUILD_TESTS=ON")
      function (cxx_test NAME SOURCES LIBS)
      endfunction()
  endif()
else()
  message(STATUS "Tests are not enabled. Set cmake BUILD_TESTING=ON")
  function (cxx_test NAME SOURCES LIBS)
  endfunction()
endif()
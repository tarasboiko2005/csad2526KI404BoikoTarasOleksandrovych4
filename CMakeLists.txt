cmake_minimum_required(VERSION 3.14)

project(HelloProject LANGUAGES CXX)

# Allow the user to override the executable name via -DEXE_NAME=...
if(NOT DEFINED EXE_NAME)
	set(EXE_NAME hello CACHE STRING "Name of the executable to build")
endif()

# Set a sensible default C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Prefer Release if no build type provided
if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
	set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Choose the type of build." FORCE)
endif()

# Public include directory
set(PUBLIC_INCLUDE_DIR ${CMAKE_SOURCE_DIR}/include)
include_directories(${PUBLIC_INCLUDE_DIR})

# Collect source files from src/ (non-recursive)
file(GLOB SRC_FILES ${CMAKE_SOURCE_DIR}/src/*.cpp ${CMAKE_SOURCE_DIR}/src/*.cxx ${CMAKE_SOURCE_DIR}/src/*.cc)

if(NOT SRC_FILES)
	message(WARNING "No source files found in ${CMAKE_SOURCE_DIR}/src. Create .cpp files there or update CMakeLists.txt.")
endif()

# Create a library target for math operations if implementation exists at project root or src/
set(MATH_SRC "${CMAKE_SOURCE_DIR}/math_operations.cpp")
if(EXISTS ${MATH_SRC})
	add_library(math_operations STATIC ${MATH_SRC})
	target_include_directories(math_operations PUBLIC ${PUBLIC_INCLUDE_DIR})
else()
	# If no central math_operations.cpp present, but src files exist, create a library from src/
	if(SRC_FILES)
		add_library(math_operations STATIC ${SRC_FILES})
		target_include_directories(math_operations PUBLIC ${PUBLIC_INCLUDE_DIR})
	endif()
endif()

# If there's a main executable in src/, create it
if(EXISTS ${CMAKE_SOURCE_DIR}/src/main.cpp)
	add_executable(${EXE_NAME} ${CMAKE_SOURCE_DIR}/src/main.cpp)
	target_link_libraries(${EXE_NAME} PRIVATE math_operations)
	target_include_directories(${EXE_NAME} PRIVATE ${PUBLIC_INCLUDE_DIR})
endif()

# Installation rules
include(GNUInstallDirs)
if(TARGET ${EXE_NAME})
	install(TARGETS ${EXE_NAME}
					RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})
endif()

if(EXISTS ${PUBLIC_INCLUDE_DIR})
	install(DIRECTORY ${PUBLIC_INCLUDE_DIR}/
					DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
					FILES_MATCHING PATTERN "*.h*")
endif()

# Option to build tests
option(BUILD_TESTS "Build tests" OFF)

message(STATUS "Configured project '${PROJECT_NAME}' (executable: ${EXE_NAME})")

if(BUILD_TESTS)
	include(FetchContent)
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
	# Use a known release of googletest
	FetchContent_Declare(
		googletest
		URL https://github.com/google/googletest/archive/refs/tags/release-1.12.1.zip
	)
	FetchContent_MakeAvailable(googletest)

	enable_testing()

	# Determine test source (prefer root unit_tests.cpp, fall back to tests/unit_tests.cpp)
	if(EXISTS ${CMAKE_SOURCE_DIR}/unit_tests.cpp)
		set(TEST_SRC ${CMAKE_SOURCE_DIR}/unit_tests.cpp)
	else()
		set(TEST_SRC ${CMAKE_SOURCE_DIR}/tests/unit_tests.cpp)
	endif()

	add_executable(${PROJECT_NAME}_tests ${TEST_SRC})

	# Link against the math_operations library if available, otherwise add math implementation directly
	if(TARGET math_operations)
		target_link_libraries(${PROJECT_NAME}_tests PRIVATE math_operations gtest_main)
	else()
		# If no library, compile math_operations.cpp into the test target if it exists
		if(EXISTS ${MATH_SRC})
			target_sources(${PROJECT_NAME}_tests PRIVATE ${MATH_SRC})
		endif()
		target_link_libraries(${PROJECT_NAME}_tests PRIVATE gtest_main)
	endif()

	target_include_directories(${PROJECT_NAME}_tests PRIVATE ${PUBLIC_INCLUDE_DIR})

	add_test(NAME ${PROJECT_NAME}_add_tests COMMAND ${PROJECT_NAME}_tests)
endif()


cmake_minimum_required(VERSION 3.10)

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

# Add include directory for public headers
include_directories(${CMAKE_SOURCE_DIR}/include)

# Collect source files from src/ (non-recursive)
file(GLOB SRC_FILES ${CMAKE_SOURCE_DIR}/src/*.cpp ${CMAKE_SOURCE_DIR}/src/*.cxx ${CMAKE_SOURCE_DIR}/src/*.cc)

if(NOT SRC_FILES)
	message(WARNING "No source files found in ${CMAKE_SOURCE_DIR}/src. Create .cpp files there or update CMakeLists.txt.")
endif()

add_executable(${EXE_NAME} ${SRC_FILES})

# Expose include directory to consumers of the target
target_include_directories(${EXE_NAME} PRIVATE ${CMAKE_SOURCE_DIR}/include)

# Installation rules
include(GNUInstallDirs)
install(TARGETS ${EXE_NAME}
				RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})

install(DIRECTORY ${CMAKE_SOURCE_DIR}/include/
				DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
				FILES_MATCHING PATTERN "*.h*")

# Optional: provide a CMake option to build tests in future
option(BUILD_TESTS "Build tests" OFF)

message(STATUS "Configured project '${PROJECT_NAME}' (executable: ${EXE_NAME})")


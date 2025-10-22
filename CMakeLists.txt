cmake_minimum_required(VERSION 3.14)

project(HelloProject LANGUAGES CXX)

# Ім'я виконуваного файлу
if(NOT DEFINED EXE_NAME)
    set(EXE_NAME hello CACHE STRING "Name of the executable to build")
endif()

# C++ стандарт
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Build type
if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
    set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Choose the type of build." FORCE)
endif()

# Папка з заголовками — зараз це корінь проекту
set(PUBLIC_INCLUDE_DIR ${CMAKE_SOURCE_DIR})
include_directories(${PUBLIC_INCLUDE_DIR})

# Джерела з src/ (якщо є)
file(GLOB SRC_FILES ${CMAKE_SOURCE_DIR}/src/*.cpp ${CMAKE_SOURCE_DIR}/src/*.cxx ${CMAKE_SOURCE_DIR}/src/*.cc)

# main.cpp лежить в корені
set(MAIN_SRC "")
if(EXISTS ${CMAKE_SOURCE_DIR}/main.cpp)
    set(MAIN_SRC ${CMAKE_SOURCE_DIR}/main.cpp)
endif()

# Створюємо бібліотеку math_operations
set(MATH_SRC "${CMAKE_SOURCE_DIR}/math_operations.cpp")
if(EXISTS ${MATH_SRC})
    add_library(math_operations STATIC ${MATH_SRC})
    target_include_directories(math_operations PUBLIC ${PUBLIC_INCLUDE_DIR})
endif()

# Створюємо виконуваний файл, якщо є main.cpp
if(MAIN_SRC)
    add_executable(${EXE_NAME} ${MAIN_SRC})
    if(TARGET math_operations)
        target_link_libraries(${EXE_NAME} PRIVATE math_operations)
    endif()
    target_include_directories(${EXE_NAME} PRIVATE ${PUBLIC_INCLUDE_DIR})
endif()

# Правила встановлення
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

# Опція для тестів
option(BUILD_TESTS "Build tests" OFF)

message(STATUS "Configured project '${PROJECT_NAME}' (executable: ${EXE_NAME})")

if(BUILD_TESTS)
    include(FetchContent)
    set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
    FetchContent_Declare(
        googletest
        URL https://github.com/google/googletest/archive/refs/tags/release-1.12.1.zip
    )
    FetchContent_MakeAvailable(googletest)

    enable_testing()

    # Джерела тестів
    if(EXISTS ${CMAKE_SOURCE_DIR}/unit_tests.cpp)
        set(TEST_SRC ${CMAKE_SOURCE_DIR}/unit_tests.cpp)
    else()
        set(TEST_SRC ${CMAKE_SOURCE_DIR}/tests/unit_tests.cpp)
    endif()

    add_executable(${PROJECT_NAME}_tests ${TEST_SRC})

    if(TARGET math_operations)
        target_link_libraries(${PROJECT_NAME}_tests PRIVATE math_operations gtest_main)
    else()
        if(EXISTS ${MATH_SRC})
            target_sources(${PROJECT_NAME}_tests PRIVATE ${MATH_SRC})
        endif()
        target_link_libraries(${PROJECT_NAME}_tests PRIVATE gtest_main)
    endif()

    target_include_directories(${PROJECT_NAME}_tests PRIVATE ${PUBLIC_INCLUDE_DIR})

    add_test(NAME ${PROJECT_NAME}_add_tests COMMAND ${PROJECT_NAME}_tests)
endif()

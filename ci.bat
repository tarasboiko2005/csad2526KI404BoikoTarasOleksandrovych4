@echo off
REM ci.bat - Build and test CMake project on Windows

setlocal enabledelayedexpansion

echo === CI Script: Build and Test ===

REM Create build directory if it doesn't exist
echo [1/5] Ensuring build directory exists...
if not exist build (
    mkdir build
    if errorlevel 1 (
        echo ERROR: Failed to create build directory.
        exit /b 1
    )
) else (
    echo build directory already exists.
)

REM Change into build directory
echo [2/5] Changing into build directory...
cd build
if errorlevel 1 (
    echo ERROR: Failed to change directory to build.
    exit /b 1
)

REM Configure project with CMake
echo [3/5] Configuring project with CMake (cmake ..)...
cmake .. -G "Visual Studio 17 2022" -A x64 -DCMAKE_BUILD_TYPE=Debug
if errorlevel 1 (
    echo ERROR: CMake configuration failed.
    exit /b 1
)

REM Build the project
echo [4/5] Building project (cmake --build . --config Debug)...
cmake --build . --config Debug
if errorlevel 1 (
    echo ERROR: Build failed.
    exit /b 1
)

REM Run tests
echo [5/5] Running tests (ctest --output-on-failure -C Debug)...
ctest --output-on-failure -C Debug
if errorlevel 1 (
    echo ERROR: Some tests failed.
    exit /b 1
)

echo All steps completed successfully.
endlocal
exit /b 0

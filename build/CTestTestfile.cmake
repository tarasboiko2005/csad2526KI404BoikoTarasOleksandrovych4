# CMake generated Testfile for 
# Source directory: C:/Users/Admin/Desktop/csad2526KI404BoikoTarasOleksandrovych4
# Build directory: C:/Users/Admin/Desktop/csad2526KI404BoikoTarasOleksandrovych4/build
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
if(CTEST_CONFIGURATION_TYPE MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
  add_test(HelloProject_add_tests "C:/Users/Admin/Desktop/csad2526KI404BoikoTarasOleksandrovych4/build/Debug/HelloProject_tests.exe")
  set_tests_properties(HelloProject_add_tests PROPERTIES  _BACKTRACE_TRIPLES "C:/Users/Admin/Desktop/csad2526KI404BoikoTarasOleksandrovych4/CMakeLists.txt;98;add_test;C:/Users/Admin/Desktop/csad2526KI404BoikoTarasOleksandrovych4/CMakeLists.txt;0;")
elseif(CTEST_CONFIGURATION_TYPE MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
  add_test(HelloProject_add_tests "C:/Users/Admin/Desktop/csad2526KI404BoikoTarasOleksandrovych4/build/Release/HelloProject_tests.exe")
  set_tests_properties(HelloProject_add_tests PROPERTIES  _BACKTRACE_TRIPLES "C:/Users/Admin/Desktop/csad2526KI404BoikoTarasOleksandrovych4/CMakeLists.txt;98;add_test;C:/Users/Admin/Desktop/csad2526KI404BoikoTarasOleksandrovych4/CMakeLists.txt;0;")
elseif(CTEST_CONFIGURATION_TYPE MATCHES "^([Mm][Ii][Nn][Ss][Ii][Zz][Ee][Rr][Ee][Ll])$")
  add_test(HelloProject_add_tests "C:/Users/Admin/Desktop/csad2526KI404BoikoTarasOleksandrovych4/build/MinSizeRel/HelloProject_tests.exe")
  set_tests_properties(HelloProject_add_tests PROPERTIES  _BACKTRACE_TRIPLES "C:/Users/Admin/Desktop/csad2526KI404BoikoTarasOleksandrovych4/CMakeLists.txt;98;add_test;C:/Users/Admin/Desktop/csad2526KI404BoikoTarasOleksandrovych4/CMakeLists.txt;0;")
elseif(CTEST_CONFIGURATION_TYPE MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
  add_test(HelloProject_add_tests "C:/Users/Admin/Desktop/csad2526KI404BoikoTarasOleksandrovych4/build/RelWithDebInfo/HelloProject_tests.exe")
  set_tests_properties(HelloProject_add_tests PROPERTIES  _BACKTRACE_TRIPLES "C:/Users/Admin/Desktop/csad2526KI404BoikoTarasOleksandrovych4/CMakeLists.txt;98;add_test;C:/Users/Admin/Desktop/csad2526KI404BoikoTarasOleksandrovych4/CMakeLists.txt;0;")
else()
  add_test(HelloProject_add_tests NOT_AVAILABLE)
endif()
subdirs("_deps/googletest-build")

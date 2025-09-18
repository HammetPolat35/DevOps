# CMake generated Testfile for 
# Source directory: /home/bmcotonom1/DevOps (second copy )/src/cpp_pubsub
# Build directory: /home/bmcotonom1/DevOps (second copy )/build/cpp_pubsub
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(test_my_node "/usr/bin/python3" "-u" "/opt/ros/foxy/share/ament_cmake_test/cmake/run_test.py" "/home/bmcotonom1/DevOps (second copy )/build/cpp_pubsub/test_results/cpp_pubsub/test_my_node.gtest.xml" "--package-name" "cpp_pubsub" "--output-file" "/home/bmcotonom1/DevOps (second copy )/build/cpp_pubsub/ament_cmake_gtest/test_my_node.txt" "--command" "/home/bmcotonom1/DevOps (second copy )/build/cpp_pubsub/test_my_node" "--gtest_output=xml:/home/bmcotonom1/DevOps (second copy )/build/cpp_pubsub/test_results/cpp_pubsub/test_my_node.gtest.xml")
set_tests_properties(test_my_node PROPERTIES  LABELS "gtest" REQUIRED_FILES "/home/bmcotonom1/DevOps (second copy )/build/cpp_pubsub/test_my_node" TIMEOUT "60" WORKING_DIRECTORY "/home/bmcotonom1/DevOps (second copy )/build/cpp_pubsub" _BACKTRACE_TRIPLES "/opt/ros/foxy/share/ament_cmake_test/cmake/ament_add_test.cmake;118;add_test;/opt/ros/foxy/share/ament_cmake_gtest/cmake/ament_add_gtest_test.cmake;86;ament_add_test;/opt/ros/foxy/share/ament_cmake_gtest/cmake/ament_add_gtest.cmake;93;ament_add_gtest_test;/home/bmcotonom1/DevOps (second copy )/src/cpp_pubsub/CMakeLists.txt;45;ament_add_gtest;/home/bmcotonom1/DevOps (second copy )/src/cpp_pubsub/CMakeLists.txt;0;")
subdirs("gtest")

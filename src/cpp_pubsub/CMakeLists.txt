cmake_minimum_required(VERSION 3.5)
project(cpp_pubsub)

# Default to C++14
option(ENABLE_COVERAGE "Enable coverage reporting" OFF)

if(NOT CMAKE_CXX_STANDARD)
  set(CMAKE_CXX_STANDARD 14)
endif()

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

find_package(ament_cmake REQUIRED)
find_package(rclcpp REQUIRED)
find_package(std_msgs REQUIRED)

add_executable(talker src/publisher_member_function.cpp)
ament_target_dependencies(talker rclcpp std_msgs)

add_executable(listener src/subscriber_member_function.cpp)
ament_target_dependencies(listener rclcpp std_msgs)

# Now apply coverage flags AFTER targets exist
if(ENABLE_COVERAGE)
  target_compile_options(talker PUBLIC --coverage -O0 -g)
  target_link_libraries(talker gcov)

  target_compile_options(listener PUBLIC --coverage -O0 -g)
  target_link_libraries(listener gcov)
endif()

install(TARGETS
  talker
  listener
  DESTINATION lib/${PROJECT_NAME})

if(BUILD_TESTING)
  find_package(ament_lint_auto REQUIRED)
  ament_lint_auto_find_test_dependencies()

  find_package(ament_cmake_gtest REQUIRED)

  ament_add_gtest(test_my_node test/test_my_node.cpp)

  target_include_directories(test_my_node PUBLIC
    ${rclcpp_INCLUDE_DIRS}
  )

  ament_target_dependencies(test_my_node
    rclcpp
    std_msgs
  )
endif()

ament_package()


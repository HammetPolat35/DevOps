#include <gtest/gtest.h>
#include <rclcpp/rclcpp.hpp>
#include <std_msgs/msg/string.hpp>
#include <chrono>
#include <memory>

using namespace std::chrono_literals;

class PubSubTest : public ::testing::Test
{
protected:
  static void SetUpTestCase()
  {
    rclcpp::init(0, nullptr);
  }

  static void TearDownTestCase()
  {
    rclcpp::shutdown();
  }
};

TEST_F(PubSubTest, publisher_subscriber_works)
{
  auto node = std::make_shared<rclcpp::Node>("test_node");

  std::string received_msg;
  auto sub = node->create_subscription<std_msgs::msg::String>(
    "topic", 10,
    [&received_msg](std_msgs::msg::String::UniquePtr msg) {
      received_msg = msg->data;
    });

  auto pub = node->create_publisher<std_msgs::msg::String>("topic", 10);

  // Publish once
  auto message = std_msgs::msg::String();
  message.data = "Hello, test!";
  pub->publish(message);

  // Spin for a short while to process callback
  auto start = std::chrono::steady_clock::now();
  while ((std::chrono::steady_clock::now() - start) < 1s && received_msg.empty()) {
    rclcpp::spin_some(node);
  }

  ASSERT_FALSE(received_msg.empty());
  EXPECT_EQ(received_msg, "Hello, test!");
}


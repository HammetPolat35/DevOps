import launch_testing
import launch
import launch_ros
import pytest
import rclpy
import unittest
from std_msgs.msg import String
from threading import Event



@pytest.mark.rostest
def generate_test_description():
    # Start your C++ publisher and subscriber nodes
    talker = launch_ros.actions.Node(
        package='cpp_pubsub',
        executable='talker',   # your publisher executable
        name='talker'
    )

    listener = launch_ros.actions.Node(
        package='cpp_pubsub',
        executable='listener', # your subscriber executable
        name='listener'
    )

    return (
        launch.LaunchDescription([
            talker,
            listener,
            launch_testing.actions.ReadyToTest(),
        ]),
        {'talker': talker, 'listener': listener}
    )


class TestPubSubIntegration(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        rclpy.init()
        cls.node = rclpy.create_node('test_node')
        cls.msg_received = Event()

        def callback(msg: String):
            print(f"[TEST] Got message: {msg.data}")
            cls.msg_received.set()

        cls.subscription = cls.node.create_subscription(
            String,
            'topic',   # must match your publisher
            callback,
            10
        )

    @classmethod
    def tearDownClass(cls):
        cls.node.destroy_subscription(cls.subscription)
        cls.node.destroy_node()
        rclpy.shutdown()

    def test_message_received(self):
        # Spin up to 5 seconds waiting for a message
        for _ in range(50):
            rclpy.spin_once(self.node, timeout_sec=0.1)
            if self.msg_received.is_set():
                break
        self.assertTrue(self.msg_received.is_set(), "No message received from talker")


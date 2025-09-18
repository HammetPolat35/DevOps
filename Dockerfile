FROM ros:humble

RUN apt-get update && apt-get install -y \
    python3-colcon-common-extensions build-essential \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /Devops (second copy)/src
COPY src ./src

WORKDIR /workspace

RUN /bin/bash -c "source /opt/ros/humble/setup.bash && \
  colcon build --packages-select cpp_pubsub \
    --cmake-clean-cache \
    --cmake-args -DENABLE_COVERAGE=ON -DCMAKE_BUILD_TYPE=Debug"


CMD ["bash", "-c", "source /opt/ros/humble/setup.bash && exec bash"]


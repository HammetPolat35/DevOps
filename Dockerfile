FROM ros:humble

# Install build tools
RUN apt-get update && apt-get install -y \
    python3-colcon-common-extensions build-essential \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /workspace

# Copy the full workspace (assume your workspace root contains 'src/')
COPY . /workspace

# Build the package
RUN /bin/bash -c "source /opt/ros/humble/setup.bash && \
    colcon build --packages-select cpp_pubsub --cmake-args -DCMAKE_BUILD_TYPE=Debug"

# Start a bash shell with ROS and workspace sourced
SHELL ["/bin/bash", "-c"]
CMD source /opt/ros/humble/setup.bash && \
    source /workspace/install/setup.bash && \
    exec bash


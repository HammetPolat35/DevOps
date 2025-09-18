FROM ros:humble

RUN apt-get update && apt-get install -y \
    python3-colcon-common-extensions build-essential \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace/src
COPY src ./src

WORKDIR /workspace

RUN /bin/bash -c "source /opt/ros/humble/setup.bash && colcon build"

CMD ["/bin/bash"]


ros() {
    docker ps | grep -q "ros-humble-env"
    if [ "$?" = 1 ]; then
        docker start ros-humble-env
    fi
    docker exec -ti  ros-humble-env bash
}

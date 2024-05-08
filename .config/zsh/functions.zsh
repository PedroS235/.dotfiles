# Force apt to use nala instead
apt() {
    command nala "$@"
}

sudo() {
    if [ "$1" = "apt" ]; then
        shift
        command sudo nala "$@"
    else
        command sudo "$@"
    fi
}

ros() {
    docker ps | grep -q "ros-humble-env"
    if [ "$?" = 1 ]; then
        docker start ros-humble-env
    fi
    docker exec -ti  ros-humble-env bash
}

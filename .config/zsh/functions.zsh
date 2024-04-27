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
    docker ps | grep -q "ros2_iron"
    if [ "$?" = 1 ]; then
        docker start ros2_iron
    fi
    docker exec -ti ros2_iron bash
}

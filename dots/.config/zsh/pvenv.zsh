VENV_FOLDER_NAME=".venv"

# Check if virtual environment is active
is_using_env() {
    VENV_PATH="$PWD/$VENV_FOLDER_NAME"
    if [[ -n "$VIRTUAL_ENV" ]]; then
        echo "1"
    else
        echo "0"
    fi
}

# Create virtual environment
create_venv() {
    VENV_PATH="$PWD/$VENV_FOLDER_NAME"
    python3 -m venv "$VENV_PATH"
}

# Activate virtual environment
activate_venv() {
    source "$VENV_PATH/bin/activate"
}

# Deactivate virtual environment
deactivate_venv() {
    deactivate
}

# Remove virtual environment
remove_venv() {
    VENV_PATH="$PWD/$VENV_FOLDER_NAME"
    if [ -d $VENV_PATH ]; then
        echo "Deleting virtual environment at $VENV_PATH."
        echo -n "Are you sure? (y/n): "  # -n keeps the cursor on the same line
        read confirm
        if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
            rm -rf "$VENV_PATH"
        fi
    fi
}

penv(){
    VENV_PATH="$PWD/$VENV_FOLDER_NAME"
    while getopts ":adr" opt; do
        case $opt in
            a)
                if [[ $(is_using_env) -eq 0 ]]; then
                    if [ ! -d "$VENV_PATH" ]; then
                        echo "Virtual environment not found. Creating one."
                        create_venv
                    fi
                    echo "Activating virtual environment."
                    activate_venv
                else
                    echo "Virtual environment is already active."
                fi
                ;;
            d)
                if [[ $(is_using_env) -eq 1 ]]; then
                    echo "Deactivating virtual environment."
                    deactivate_venv
                else
                    echo "No virtual environment is active."
                fi
                ;;
            r)
                remove_venv
                ;;
            \?)
                echo "Invalid option: -$OPTARG" >&2
                ;;
        esac
    done
}

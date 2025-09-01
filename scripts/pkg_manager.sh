#! /bin/bash

# Fetch and install or unsintall and delete project dependencies.
# It is used to not fill the git project with nonsense

pkgm_log() {
    # Echos messages with proper settings
    echo "[PKG_MNG]: " $@
}

pkgm_check_reqs() {
    # Returns 0 if all programs required to download and install the depencies
    # are available. Returns > 0 otherwise
    # Log events in std_out

    pkgm_log "Checking if all required programs are available"
    RETURN_VALUE=0

    curl --version &> /dev/null
    if [[ $? -ne 0 ]]; then
        pkgm_log "Curl unavaliable"
        pkgm_log "Install python3 (if using apt: apt-get install curl)"
        RETURN_VALUE=$(($RETURN_VALUE + 1))
    fi

    python3 --version &> /dev/null
    if [[ $? -ne 0 ]]; then
        pkgm_log "Python3 unavaliable"
        pkgm_log "Install python3 (if using apt: apt-get install python3)"
        RETURN_VALUE=$(($RETURN_VALUE + 2))
    fi

    python3 -m venv -h &> /dev/null
    if [[ $? -ne 0 ]]; then
        pkgm_log "Python3 Virtual Env (venv) unavaliable"
        pkgm_log "Install venv (if using apt: apt-get install python3-venv)"
        RETURN_VALUE=$(($RETURN_VALUE + 4))
    fi
    return $RETURN_VALUE
}

pkgm_install_gdtoolkit() {
    pkgm_log "Installing gdtoolkit"
    (cd ..; source .venv/bin/activate; .venv/bin/pip3 install -q gdtoolkit)
}

pkgm_install_venv() {
    pkgm_log "Installing venv"
    rm -rf ../.venv
    python3 -m venv ../.venv
}

pkgm_install_gut() {
    pkgm_log "Installing GUT"
    curl -s https://codeload.github.com/bitwes/Gut/tar.gz/refs/tags/9.3.1 --output gut.tar.gz > /dev/null
    tar xzf gut.tar.gz > /dev/null
    mkdir -p ../game/addons/
    rm -rf ../game/addons/gut
    mv Gut-9.3.1/addons/gut ../game/addons/
    rm gut.tar.gz
    rm -rf Gut-9.3.1
}

pkgm_uninstall_gdtoolkit() {
    pkgm_log "Unistalling gdtoolkit"
    (cd ..; source .venv/bin/activate; .venv/bin/pip3 uninstall gdtoolkit -y -q)
}

pkgm_uninstall_venv() {
    pkgm_log "Unistalling venv"
    rm -rf ../.venv
}

pkgm_uninstall_gut() {
    pkgm_log "Uninstalling GUT"
    mkdir -p ../game/addons/
    rm -rf ../game/addons/gut
}

pkgm_install() {
    pkgm_install_gut
    pkgm_install_venv
    pkgm_install_gdtoolkit
}

pkgm_uninstall() {
    pkgm_uninstall_gdtoolkit
    pkgm_uninstall_venv
    pkgm_uninstall_gut
}

pkgm_cmd_install() {
    pkgm_log "Installing dependencies"
    pkgm_check_reqs
    if [[ $? -ne 0 ]]; then
        pkgm_log "Aborting install. System do not fill requirements"
        return 1
    fi

    pkgm_install
    pkgm_log "Done !"
}

pkgm_cmd_uninstall() {
    pkgm_log "Uninstalling dependencies"
    pkgm_uninstall
    pkgm_log "Done !"
}

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $SCRIPT_DIR

if [[ $1 == "install" ]]; then
    pkgm_cmd_install
elif [[ $1 == "uninstall" ]]; then
    pkgm_cmd_uninstall
else
    pkgm_log "Correct usage: $0 <install/uninstall>"
fi

#!/usr/bin/env bash

ROOT_DIR=$(dirname "$0")

set -x

make DEBUG=1 psw_install_pkg sdk_install_pkg || exit -1

[ ! -f /opt/intel/sgxpsw/uninstall.sh ] || sudo /opt/intel/sgxpsw/uninstall.sh
[ ! -f /opt/intel/sgxsdk/uninstall.sh ] || sudo /opt/intel/sgxsdk/uninstall.sh

v=$(awk '/STRFILEVER/ {print $3}' ${ROOT_DIR}/common/inc/internal/se_version.h|sed 's/^\"\(.*\)\"$/\1/')

sudo ${ROOT_DIR}/linux/installer/bin/sgx_linux_x64_psw_${v}.bin
sudo ${ROOT_DIR}/linux/installer/bin/sgx_linux_x64_sdk_${v}.bin --prefix=/opt/intel

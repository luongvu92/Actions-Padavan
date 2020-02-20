#!/bin/bash
#=================================================
# https://github.com/kingyan/Actions-Padavan
# Description: DIY script
# Lisence: MIT
# Author: kingyan
#=================================================
cd /opt/rt-n56u/trunk

cp -a configs/boards/PSG1218 configs/boards/K2
sed -i 's/PSG1218/K2/g' configs/boards/K2/board.h
sed -i 's/PSG1218/K2/g' configs/boards/K2/board.mk

cp -f configs/templates/PSG1218.config configs/templates/K2.config
sed -i 's/PSG1218/K2/g' configs/templates/K2.config

cp -f configs/templates/PSG1218_nano.config configs/templates/K2_nano.config
sed -i 's/PSG1218/K2/g' configs/templates/K2_nano.config

sed -i '5,11d' build_firmware_modify

if [ ! -f configs/templates/$TNAME.config ] ; then
    echo "configs/templates/$TNAME.config not found "
    exit 1
fi

cp -f configs/templates/$TNAME.config .config

if  echo ${TNAME} | grep -qi "nano" ; then
    #====================================================================================#
    #自定义添加其它功能请参考源码configs/templates/目录下的config文件，按照下面的格式添加即可。#
    #sed -i '/自定义项/d' .config                                                         #
    #====================================================================================#
    sed -i '/CONFIG_FIRMWARE_INCLUDE_DOGCOM/d' .config
    sed -i '/CONFIG_FIRMWARE_INCLUDE_MINIEAP/d' .config
    sed -i '/CONFIG_FIRMWARE_INCLUDE_NJIT_CLIENT/d' .config
    sed -i '/CONFIG_FIRMWARE_INCLUDE_VLMCSD/d' .config
    #====================================================================================#
    #以下选项是定义你需要的功能（y=集成,n=忽略），重新写入到.config文件。                     #
    #echo "自定义项=y" >> .config                                                         #
    #====================================================================================#
    echo "CONFIG_FIRMWARE_INCLUDE_DOGCOM=n" >> .config
    echo "CONFIG_FIRMWARE_INCLUDE_MINIEAP=n" >> .config
    echo "CONFIG_FIRMWARE_INCLUDE_NJIT_CLIENT=n" >> .config
    echo "CONFIG_FIRMWARE_INCLUDE_VLMCSD=n" >> .config
    #====================================================================================#
fi

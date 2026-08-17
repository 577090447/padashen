#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
# 加载files自定义配置文件
#if [ -d "$GITHUB_WORKSPACE/files" ]; then
#    cp -r $GITHUB_WORKSPACE/files openwrt/
#fi

# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
# ===================== 第三方插件统一拉取（先删旧残留） =====================
rm -rf package/OpenAppFilter
git clone --depth 1 -b v6.1.8 https://github.com/destan19/OpenAppFilter package/OpenAppFilter

rm -rf package/luci-app-store
git clone --depth=1 https://github.com/linkease/istore.git package/luci-app-store

rm -rf package/luci-app-gecoosac
git clone --depth=1 https://github.com/laipeng668/luci-app-gecoosac package/luci-app-gecoosac

rm -rf tmp/openwrt-app-actions package/luci-app-wan-mac
git clone --depth=1 https://github.com/linkease/openwrt-app-actions tmp/openwrt-app-actions
mv tmp/openwrt-app-actions/applications/luci-app-wan-mac package/luci-app-wan-mac
rm -rf tmp/openwrt-app-actions
# 添加 luci-app-tcpdump 抓包插件
git clone https://github.com/KFERMercer/luci-app-tcpdump.git ./package/luci-app-tcpdump
# 更新并安装插件源
./scripts/feeds update -a
./scripts/feeds install -a

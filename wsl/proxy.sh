#!/bin/bash

# WSL2 代理配置函数
setup_wsl_proxy() {
    # 检测是否在 WSL 环境中
    if ! grep -qi microsoft /proc/version 2>/dev/null; then
        echo "❌ This script is only for WSL environment"
        return 1
    fi

    # 默认代理端口
    local proxy_port=${1:-7890}

    # 检测宿主机 IP
    local host_ip=$(cat /etc/resolv.conf 2>/dev/null | grep nameserver | awk '{print $2}')

    # 验证是否成功获取 IP
    if [ -z "$host_ip" ]; then
        echo "❌ Failed to detect Windows host IP"
        echo "   Please check if /etc/resolv.conf exists and contains nameserver"
        return 1
    fi

    # 导出环境变量
    export WIN_HOST_IP="$host_ip"
    export http_proxy="http://${host_ip}:${proxy_port}"
    export https_proxy="http://${host_ip}:${proxy_port}"
    export HTTP_PROXY="http://${host_ip}:${proxy_port}"
    export HTTPS_PROXY="http://${host_ip}:${proxy_port}"
    export all_proxy="http://${host_ip}:${proxy_port}"
    export ALL_PROXY="http://${host_ip}:${proxy_port}"

    # 设置不使用代理的地址
    export no_proxy="localhost,127.0.0.1,*.local,*.lan,192.168.*,10.*,172.16.*,172.17.*,172.18.*,172.19.*,172.20.*,172.21.*,172.22.*,172.23.*,172.24.*,172.25.*,172.26.*,172.27.*,172.28.*,172.29.*,172.30.*,172.31.*"
    export NO_PROXY="$no_proxy"

    echo "✓ WSL proxy configured successfully!"
    echo "  Windows Host IP: ${host_ip}"
    echo "  Proxy Port: ${proxy_port}"
    echo "  HTTP_PROXY: http://${host_ip}:${proxy_port}"
}

# 清除代理的函数
unset_wsl_proxy() {
    unset WIN_HOST_IP
    unset http_proxy https_proxy HTTP_PROXY HTTPS_PROXY
    unset all_proxy ALL_PROXY
    unset no_proxy NO_PROXY

    echo "✓ WSL proxy cleared"
}

# 显示当前代理状态
show_wsl_proxy() {
    if [ -n "$http_proxy" ]; then
        echo "Current proxy configuration:"
        echo "  WIN_HOST_IP: ${WIN_HOST_IP:-not set}"
        echo "  http_proxy: ${http_proxy:-not set}"
        echo "  https_proxy: ${https_proxy:-not set}"
        echo "  no_proxy: ${no_proxy:-not set}"
    else
        echo "No proxy configured"
    fi
}

# 如果直接执行此脚本，则自动配置代理
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    setup_wsl_proxy "$@"
fi

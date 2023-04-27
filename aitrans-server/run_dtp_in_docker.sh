#!/bin/bash

# 默认地址和端口
DEFAULT_ADDR="127.0.0.1"
DEFAULT_PORT="5555"

if [ "$1" == "-s" ]; then
    # 如果用户指定了地址和端口，则使用用户的设置，否则使用默认设置
    if [ -n "$2" ] && [ -n "$3" ]; then
        ADDR="$2"
        PORT="$3"
    else
        ADDR="$DEFAULT_ADDR"
        PORT="$DEFAULT_PORT"
    fi
    LD_LIBRARY_PATH=./lib ./bin/dtp_server "$ADDR" "$PORT" 'trace/block_trace/aitrans_block.txt' &>./log/dtp_server_err.log &
    echo "Server 已启动"
elif [ "$1" == "-c" ]; then
    # 如果用户指定了地址和端口，则使用用户的设置，否则使用默认设置
    if [ -n "$2" ] && [ -n "$3" ]; then
        ADDR="$2"
        PORT="$3"
    else
        ADDR="$DEFAULT_ADDR"
        PORT="$DEFAULT_PORT"
    fi
    LD_LIBRARY_PATH=./lib ./dtp_client "$ADDR" "$PORT" --no-verify &>dtp_client_err.log
    echo "运行结束，请查看dtp_client.log"
elif [ "$1" == "test" ]; then
    LD_LIBRARY_PATH=./lib ./bin/dtp_server "$DEFAULT_ADDR" "$DEFAULT_PORT" 'trace/block_trace/aitrans_block.txt' &>./log/dtp_server_err.log &
    sleep 0.1
    LD_LIBRARY_PATH=./lib ./dtp_client "$DEFAULT_ADDR" "$DEFAULT_PORT" --no-verify &>dtp_client_err.log
    echo "运行结束，请查看dtp_client.log"
else
    echo "用法：$0 [-s|-c|test]"
    echo "  -s  [ADDR PORT] 启动 server"
    echo "       ADDR: 服务端地址，默认为 $DEFAULT_ADDR"
    echo "       PORT: 服务端端口，默认为 $DEFAULT_PORT"
    echo "  -c  [ADDR PORT] 启动 client"
    echo "       ADDR: 服务端地址，默认为 $DEFAULT_ADDR"
    echo "       PORT: 服务端端口，默认为 $DEFAULT_PORT"
    echo "  test  启动 server 和 client，测试用"
fi

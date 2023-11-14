#!/bin/bash

# 跟踪的根目录
root_directory="$HOME/task_management_tool"  # 使用$HOME代替波浪号

# 上次提交的时间戳
last_commit_time=0

# 检查周期（秒）
check_interval=600  # 10分钟

# 提交延迟（秒）
commit_delay=1800  # 半小时

# 推送延迟（秒）
push_delay=3600  # 一小时

echo "开始监听目录：$root_directory"

# 开始监听
fswatch -o "$root_directory" | while read num ; do
    current_time=$(date +%s)
    time_since_last_commit=$((current_time - last_commit_time))

    echo "检测到变化，正在检查是否需要提交或推送..."

    # 如果自上次提交以来已超过提交延迟时间
    if [ "$time_since_last_commit" -ge "$commit_delay" ]; then
        echo "进行自动提交..."
        cd "$root_directory"
        git add .
        git commit -m "自动提交"
        last_commit_time=$(date +%s)
        echo "提交完成。"
    fi

    # 如果自上次提交以来已超过推送延迟时间
    if [ "$time_since_last_commit" -ge "$push_delay" ]; then
        echo "进行自动推送..."
        git push
        echo "推送完成。"
    fi

    # 等待下一次检查
    echo "等待下一次检查..."
    sleep "$check_interval"
done

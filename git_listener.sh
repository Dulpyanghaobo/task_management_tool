#!/bin/bash

# 跟踪的根目录
root_directory="$HOME/task_management_tool"

# 上次提交的时间戳
last_commit_time=0

# 检查周期（秒）
check_interval=10 # 10分钟

# 提交延迟（秒）
commit_delay=20 # 半小时

# 推送延迟（秒）
push_delay=1 # 一小时

echo "开始监听目录：$root_directory"

# 开始监听
fswatch -o "$root_directory" | while read num ; do
    echo "开始执行"
    current_time=$(date +%s)
    time_since_last_commit=$((current_time - last_commit_time))

    # 如果自上次提交以来已超过提交延迟时间
    if [ "$time_since_last_commit" -ge "$commit_delay" ]; then
        # Git 提交
        cd "$root_directory"
        git add .
        git commit -m "自动提交"
        last_commit_time=$(date +%s)
        echo "自动提交"
    fi

    # 如果自上次提交以来已超过推送延迟时间
    if [ "$time_since_last_commit" -ge "$push_delay" ]; then
        # Git 推送
        git push
        echo "push"
    fi

    # 等待下一次检查
    sleep "$check_interval"
done

#!/bin/bash

# 检查命令行参数
if [ "$#" -ne 1 ]; then
    echo "使用方法: $0 <repo_name>"
    exit 1
fi

repo_name=$1

# 创建 GitHub 仓库
echo "正在创建 GitHub 仓库: $repo_name"
gh repo create "$repo_name" --public

#!/bin/bash

# 检查命令行参数
if [ "$#" -ne 2 ]; then
    echo "使用方法: $0 <username> <repo_name>"
    echo "例如: $0 exampleUser exampleRepo"
    exit 1
fi

username=$1
repo_name=$2
full_repo_name="$username/$repo_name"

# 确认删除
read -p "您确定要删除仓库 $full_repo_name 吗？这个操作是不可逆的。[y/N] " confirmation
if [ "$confirmation" != "y" ] && [ "$confirmation" != "Y" ]; then
    echo "操作已取消。"
    exit 0
fi

# 删除 GitHub 仓库
echo "正在删除 GitHub 仓库: $full_repo_name"
gh repo delete $full_repo_name --confirm

if [ $? -eq 0 ]; then
    echo "仓库删除成功。"
else
    echo "删除仓库失败。"
fi

#!/bin/bash

# 检查 GitHub CLI 是否已安装
if ! command -v gh &> /dev/null
then
    echo "GitHub CLI 未安装，现在将其安装..."
    brew install gh

    if [ $? -ne 0 ]; then
        echo "安装 GitHub CLI 失败。"
        exit 1
    fi
else
    echo "GitHub CLI 已安装。"
fi

# 检查是否已登录 GitHub CLI
if ! gh auth status &> /dev/null
then
    echo "未登录 GitHub CLI，现在将进行登录..."
    gh auth login

    if [ $? -ne 0 ]; then
        echo "登录 GitHub CLI 失败。"
        exit 1
    fi
else
    echo "已登录 GitHub CLI。"
fi

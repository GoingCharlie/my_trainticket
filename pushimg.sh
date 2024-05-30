#!/usr/bin/env bash
set -eu
echo
echo "Push images, Repo: habor.production.horsecoder.com/hybrid/ts-*:1.0.0"
echo
# 获取匹配的镜像列表
images=$(docker images --format "{{.Repository}}:{{.Tag}}" | grep "habor.production.horsecoder.com/hybrid/ts-" | grep ":1.0.0")
if [[ -n "$images" ]]; then
  # 推送匹配的镜像
  echo "$images" | xargs -I {} docker push {}
fi
#!/bin/bash

while read line; do
  # 使用tcping检测IP和端口
  IFS=':' read ip port <<< "${line}"
  # 这里我们默认tcping超时时间为3秒进行测试
  if ! tcping -t 3 $ip $port > /dev/null 2>&1; then
    # 如果tcping测试失败（即端口不通），打印这个信息
    echo "Removing $line because it's not reachable."
  else
    # 如果测试成功，则保留这个IP地址和端口
    echo $line >> linshi.txt
  fi
done < ip.txt

# 移动临时文件覆盖原ip.txt，仅保留可访问的IP
mv linshi.txt ip.txt

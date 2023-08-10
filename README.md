# Auto-Trim-Log-File
Automatically clean log files under multiple specified paths, and only the last 10 files are kept.
## crontab configuration example
```bash
0 0 */3 * * /bin/trimlog /tmp /var/log 2>&1 &
```
This means that the log file in the path of /tmp /var/log is cleaned every 3 days.
# log文件清理助手
自动清理多个指定路径下的log文件，只保留后10条。
## crontab 配置示例
```bash
0 0 */3 * * /bin/trimlog /tmp /var/log 2>&1 &
```
这表示每3天清理一次/tmp /var/log路径下的log文件。

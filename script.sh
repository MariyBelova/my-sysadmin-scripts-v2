#!/bin/bash

# Сборщик логов: черновик (draft) — просто фильтрует syslog

LOGFILE="/var/log/syslog"
REPORT="report.txt"
KEYWORDS="error failed"

grep -iE "$(echo $KEYWORDS | tr ' ' '|')" "$LOGFILE" > "$REPORT"

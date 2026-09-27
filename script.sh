#!/usr/bin/env bash
set -euo pipefail
LOGFILE="${LOGFILE:-/var/log/syslog}"
REPORT="/var/www/report.txt"
KEYWORDS="error failed"
mkdir -p /var/www
if [ ! -f "$LOGFILE" ]; then
  echo "Лог не найден: $LOGFILE (изоляция контейнера)" > "$REPORT"
  echo "Отчёт сохранён в $REPORT"
  cat "$REPORT"
  exit 0
fi
echo "=== Отчёт по логу: $LOGFILE ===" > "$REPORT"
echo "Дата: $(date)" >> "$REPORT"
echo "Ключевые слова: $KEYWORDS" >> "$REPORT"
echo "--- Найденные строки ---" >> "$REPORT"
grep -iE "$(echo "$KEYWORDS" | tr ' ' '|')" "$LOGFILE" >> "$REPORT" 2>/dev/null || true
echo "Отчёт сохранён в $REPORT"
cat "$REPORT"

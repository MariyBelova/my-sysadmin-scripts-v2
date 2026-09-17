#!/bin/bash

# Сборщик логов: читает syslog/auth.log, аильтрует по ключевым словам, делает отчет

LOGFILE="/var/log/syslog"
REPORT="report.txt
cat > script.sh << 'EOF'
#!/bin/bash

# Сборщик логов: читает syslog/auth.log, фильтрует по ключевым словам, делает отчёт

LOGFILE="/var/log/syslog"
REPORT="report.txt"
KEYWORDS="error failed warning deny refused critical"

# Если syslog нет — пробуем auth.log
if [ ! -f "$LOGFILE" ]; then
    LOGFILE="/var/log/auth.log"
fi

# Проверка: файл существует?
if [ ! -f "$LOGFILE" ]; then
    echo "Ошибка: ни /var/log/syslog, ни /var/log/auth.log не найдены." | tee "$REPORT"
    exit 1
fi

# Проверка: есть ли права на чтение?
if [ ! -r "$LOGFILE" ]; then
    echo "Ошибка: нет прав на чтение $LOGFILE. Запускай через sudo." | tee "$REPORT"
    exit 1
fi

# Заголовок отчёта
{
    echo "=== Отчёт по логам: $LOGFILE ==="
    echo "Дата формирования: $(date '+%Y-%m-%d %H:%M:%S')"
    echo "Ключевые слова: $KEYWORDS"
    echo ""
} > "$REPORT"

# Фильтрация (регистронезависимо)
grep -iE "$(echo $KEYWORDS | tr ' ' '|')" "$LOGFILE" >> "$REPORT" 2>/dev/null

# Подсчёт
COUNT=$(grep -icE "$(echo $KEYWORDS | tr ' ' '|')" "$LOGFILE" 2>/dev/null)

echo "" >> "$REPORT"
echo "Всего найдено совпадений: $COUNT" >> "$REPORT"

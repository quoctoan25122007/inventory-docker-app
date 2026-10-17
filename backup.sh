#!/bin/bash
docker exec inventory_db mysqldump --default-character-set=utf8mb4 -uroot -p123456 inventory_db > backup.sql
if [ $? -eq 0 ]; then
  echo "✅ Backup thanh cong ra file backup.sql!"
else
  echo "❌ Backup that bai! Hay kiem tra container inventory_db da chay chua."
  exit 1
fi

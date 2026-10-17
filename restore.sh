#!/bin/bash
docker exec -i inventory_db mysql --default-character-set=utf8mb4 -uroot -p123456 inventory_db < backup.sql
if [ $? -eq 0 ]; then
  echo "✅ Restore thanh cong tu file backup.sql!"
else
  echo "❌ Restore that bai!"
  exit 1
fi

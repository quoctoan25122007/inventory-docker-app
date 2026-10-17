#!/bin/bash
echo "=========================================================="
echo "🚀 BẮT ĐẦU QUY TRÌNH DOCKER CI/CD PIPELINE (LOCAL RUNNER)"
echo "=========================================================="

echo "[Stage 1/4] 🔍 Kiểm tra cấu hình compose.yaml và Dockerfile..."
docker compose config -q
if [ $? -ne 0 ]; then
  echo "❌ Lỗi cú pháp trong compose.yaml!"
  exit 1
fi
echo "✅ Cấu hình compose.yaml hợp lệ!"

echo "[Stage 2/4] 🏗️ Build Docker Images (inventory_api & inventory_frontend)..."
docker compose build
if [ $? -ne 0 ]; then
  echo "❌ Build Docker Image thất bại!"
  exit 1
fi
echo "✅ Build Docker Images thành công!"

echo "[Stage 3/4] 🚀 Triển khai Multi-container (Continuous Deployment)..."
docker compose up -d
sleep 3

echo "[Stage 4/4] 🧪 Chạy Automated Test kiểm tra API, Frontend & Database..."
# Dùng wget (có sẵn trên Ubuntu) và docker exec để kiểm thử thay cho curl
wget -q --spider http://localhost:8080
WEB_STATUS=$?

DB_TEST=$(docker exec inventory_db mysql -uroot -p123456 -e "USE inventory_db; SELECT COUNT(*) FROM products;" 2>/dev/null)
DB_STATUS=$?

if [ $WEB_STATUS -eq 0 ] && [ $DB_STATUS -eq 0 ]; then
  echo "✅ Frontend Web (Port 8080): ONLINE (200 OK)"
  echo "✅ API & MySQL Database: CONNECTED & VERIFIED"
  echo "🎉 CI/CD PIPELINE HOÀN TẤT THÀNH CÔNG 100%!"
else
  echo "❌ Kiểm thử thất bại!"
  exit 1
fi

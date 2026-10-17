SET NAMES utf8mb4;
CREATE DATABASE IF NOT EXISTS inventory_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE inventory_db;

DROP TABLE IF EXISTS products;
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(15, 2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO products (name, quantity, price) VALUES 
('Laptop ASUS Vivobook 16 RTX 4050', 12, 22990000),
('Máy ảnh Sony Alpha A7S II Body', 5, 28500000),
('Gimbal chống rung DJI RS 2 Pro Combo', 8, 16500000),
('Bàn phím cơ không dây Keychron K8 Pro', 30, 2450000),
('Chuột gaming Logitech G Pro X Superlight', 45, 2990000),
('Màn hình đồ họa Dell UltraSharp 27 inch 4K', 15, 13800000),
('Ổ cứng SSD Samsung 990 PRO NVMe 1TB', 60, 2650000),
('RAM Kingston Fury Beast DDR5 16GB', 40, 1550000),
('Tai nghe kiểm âm Audio-Technica ATH-M50x', 20, 3890000),
('Thẻ nhớ SD SanDisk Extreme Pro 128GB', 100, 650000),
('Vợt cầu lông Yonex Astrox 100ZZ', 10, 4200000),
('Bộ lắp ráp LEGO Technic Siêu xe', 7, 8900000);

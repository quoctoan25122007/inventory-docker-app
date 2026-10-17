const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');

const app = express();
app.use(express.json());
app.use(cors());

const db = mysql.createPool({
  host: process.env.DB_HOST || 'db',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || '123456',
  database: process.env.DB_NAME || 'inventory_db',
  charset: 'utf8mb4',
  waitForConnections: true,
  connectionLimit: 10
});

app.get('/api/products', (req, res) => {
  db.query('SELECT * FROM products ORDER BY id DESC', (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    res.setHeader('Content-Type', 'application/json; charset=utf-8');
    res.json(results);
  });
});

app.post('/api/products', (req, res) => {
  const { name, quantity, price } = req.body;
  db.query(
    'INSERT INTO products (name, quantity, price) VALUES (?, ?, ?)',
    [name, quantity || 0, price || 0],
    (err, result) => {
      if (err) return res.status(500).json({ error: err.message });
      res.json({ message: 'Đã thêm sản phẩm', id: result.insertId });
    }
  );
});

app.put('/api/products/:id', (req, res) => {
  const { id } = req.params;
  const { name, quantity, price } = req.body;
  db.query(
    'UPDATE products SET name = ?, quantity = ?, price = ? WHERE id = ?',
    [name, quantity, price, id],
    (err) => {
      if (err) return res.status(500).json({ error: err.message });
      res.json({ message: 'Đã cập nhật sản phẩm' });
    }
  );
});

app.delete('/api/products/:id', (req, res) => {
  const { id } = req.params;
  db.query('DELETE FROM products WHERE id = ?', [id], (err) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json({ message: 'Đã xóa sản phẩm' });
  });
});

const PORT = 3000;
app.listen(PORT, '0.0.0.0', () => {
  console.log(`API CRUD đang chạy tại cổng ${PORT}`);
});

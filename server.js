// server.js
const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

// MongoDB холболт
mongoose.connect('mongodb://127.0.0.1:27017/flutter_login', {
  // Шинэ Mongoose хувилбарын тохиргоо шаардлагагүй
}).then(() => console.log("MongoDB холбогдлоо"))
  .catch(err => console.log(err));

// Хэрэглэгчийн Schema
const userSchema = new mongoose.Schema({
  name: String,
  email: { type: String, unique: true },
  password: String,
});

const User = mongoose.model('User', userSchema);

// Signup endpoint
app.post('/signup', async (req, res) => {
  const { name, email, password } = req.body;
  try {
    const userExists = await User.findOne({ email });
    if (userExists) return res.status(400).json({ success: false, message: 'Email аль хэдийн бүртгэгдсэн.' });

    const user = new User({ name, email, password });
    await user.save();
    res.status(201).json({ success: true, message: 'Бүртгэл амжилттай.' });
  } catch (err) {
    res.status(500).json({ success: false, message: err.message });
  }
});

// Login endpoint
app.post('/login', async (req, res) => {
  const { email, password } = req.body;
  try {
    const user = await User.findOne({ email, password });
    if (!user) return res.status(400).json({ success: false, message: 'И-мэйл эсвэл нууц үг буруу байна.' });
    res.status(200).json({ success: true, message: 'Амжилттай нэвтэрлээ.' });
  } catch (err) {
    res.status(500).json({ success: false, message: err.message });
  }
});

app.listen(3000, () => {
  console.log('Server 3000 порт дээр ажиллаж байна');
});

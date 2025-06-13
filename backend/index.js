const express = require('express');
const app = express();
const port = 3000;

app.use(express.json());

// Lista simples de usuários em memória
const users = [];

// Endpoint para registrar novo usuário
app.post('/register', (req, res) => {
    const { email, password } = req.body;
    if (!email || !password) {
        return res.status(400).json({ success: false, message: "Email e senha são obrigatórios." });
    }
    if (users.find(u => u.email === email)) {
        return res.status(409).json({ success: false, message: "Email já cadastrado." });
    }
    users.push({ email, password });
    res.json({ success: true, message: "Usuário registrado com sucesso." });
});

// Endpoint de login simples
app.post('/login', (req, res) => {
    const { email, password } = req.body;
    const user = users.find(u => u.email === email && u.password === password);
    if (user) {
        // Autenticado com sucesso
        res.json({ success: true, message: "Login realizado com sucesso." });
    } else {
        // Falha na autenticação
        res.status(401).json({ success: false, message: "Email ou senha inválidos." });
    }
});

app.listen(port, () => {
    console.log(`Servidor rodando na porta ${port}`);
});


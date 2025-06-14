const express = require('express');
const app = express();
const port = 3000;

app.use(express.json());

// Lista simples de usuários em memória
const users = [];

// Endpoint para registrar novo usuário
app.post('/register', (req, res) => {
    const { email, password, name } = req.body;
    if (!email || !password || !name) {
        return res.status(400).json({ success: false, message: "Email, senha e nome do usuário são obrigatórios." });
    }
    if (users.find(u => u.email === email)) {
        return res.status(409).json({ success: false, message: "Email já cadastrado." });
    }
    users.push({ email, password , name});
    res.json({ success: true, message: "Usuário registrado com sucesso. name :" + name});
});

// Endpoint de login simples
app.post('/login', (req, res) => {
    const { email, password } = req.body;
    const user = users.find(u => u.email === email && u.password === password);
    if (user) {
        res.json({ success: true, message: "Login realizado com sucesso.", email: user.email, name: user.name });
    } else {
        // Falha na autenticação
        res.status(401).json({ success: false, message: "Email ou senha inválnameos." });
    }
});

app.listen(port, () => {
    console.log(`Servnameor rodando na porta ${port}`);
});


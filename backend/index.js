const express = require('express');
const app = express();
const port = 3000;

app.use(express.json());

const users = [];

app.post('/register', (req, res) => {
    const { email, password, name } = req.body;
    if (!email || !password || !name) {
        return res.status(400).json({ success: false, message: "Email, senha e nome do usuário são obrigatórios." });
    }
    if (users.find(u => u.email === email)) {
        return res.status(409).json({ success: false, message: "Email já cadastrado." });
    }
    users.push({ email, password , name, pet: null }); // Adiciona campo pet: null
    res.json({ success: true, message: "Usuário registrado com sucesso. name :" + name});
});

app.post('/login', (req, res) => {
    const { email, password } = req.body;
    const user = users.find(u => u.email === email && u.password === password);
    if (user) {
        var havePet;
        if (user.pet)
            havePet = true;
        else
            havePet = false;

        res.json({ success: true, message: "Login realizado com sucesso.", email: user.email, name: user.name, havePet: havePet });
    } else {
        res.status(401).json({ success: false, message: "Email ou senha inválnameos." });
    }
});

app.post('/registerPet', (req, res) => {
    const { email, name, idade , type} = req.body;
    if (!email || !name || !idade || !type) {
        return res.status(400).json({ success: false, message: "Email e informações do pet são obrigatórios." });
    }
    const user = users.find(u => u.email === email);
    if (!user) {
        return res.status(404).json({ success: false, message: "Usuário não encontrado." + email + "lista de usuários: " + JSON.stringify(users) });
    }
    if (user.pet) {
        return res.status(409).json({ success: false, message: "Usuário já possui um pet registrado." });
    }
    user.pet = { name, idade , type};
    res.json({ success: true, message: "Pet registrado com sucesso.", pet: user.pet });
});

app.get('/pet', (req, res) => {
    const { email } = req.query;
    if (!email) {
        return res.status(400).json({ success: false, message: "Email é obrigatório." });
    }
    const user = users.find(u => u.email === email);
    if (!user) {
        return res.status(404).json({ success: false, message: "Usuário não encontrado." });
    }
    res.json({ success: true, pet: user.pet });
});

app.listen(port, () => {
    console.log(`Servidor rodando no link http://localhost:${port}/`);
});


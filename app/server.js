const express = require('express');
const app = express();
const port = 80;

app.use(express.static('public'));

//Opcional: redirigir raíz a public/index.html
app.get('/', (req, res) => {
  res.sendFile(__dirname + '/public/index.html');
});


app.listen(port, () => {
  console.log(`✅ Servidor en http://localhost:${port}`);
});
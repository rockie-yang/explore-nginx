const express = require('express')
const app = express()
const port = 3001

app.get('/', (req, res) => res.send('This is a model hyper parameter seaching application!'))

app.listen(port, () => console.log(`Example app listening on port ${port}!`))


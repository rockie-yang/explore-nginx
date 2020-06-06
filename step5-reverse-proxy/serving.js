const http = require('http')
const port = 3000

const requestHandler = (request, response) => {
  console.log(request.url)
  response.writeHeader(200, {"Content-Type": "text/html"});
  response.write('Hello, This is machine learning model serving application! <a href="a-link-from-serving">serving</a>');
  response.end()
}

const server = http.createServer(requestHandler)

server.listen(port, (err) => {
  if (err) {
    return console.log('something bad happened', err)
  }

  console.log(`server is listening on ${port}`)
})
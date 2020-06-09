const http = require('http')
const port = 3000

const requestHandler = (request, response) => {
  console.log(request.url)
  response.writeHeader(200, {"Content-Type": "text/html"});
  //  http://localhost:3000/a-link-from-serving
  //  http://localhost:8080/serving/a-link-from-serving

  response.write("Hello, This is machine learning model serving application! <br>" );
  response.write(`request url ${request.url}  <a href="relative-path">relative-path</a> and <a href="/absolute-path">absolute-path</a>`);
  response.end()
}

const server = http.createServer(requestHandler)

server.listen(port, (err) => {
  if (err) {
    return console.log('something bad happened', err)
  }

  console.log(`server is listening on ${port}`)
})
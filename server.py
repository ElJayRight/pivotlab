import http.server
import socketserver

class CustomRequestHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        client_ip = self.client_address[0]
        host_header_port = self.headers.get('Host', '').split(":")[1]
        if client_ip=="127.0.0.1" and host_header_port=="8080":
            self.send_response(404)
            self.send_header('Content-type', 'text/html')
            self.end_headers()
            self.wfile.write(b"HEY THATS CHEATING.\nPlease stop.\nI wrote a custom GET python server just so you can't do this.\nGood job for trying tho!\n")
        else:
            super().do_GET()

if __name__ == "__main__":
    host = "127.0.0.1"  # Loopback address
    port = 8080

    with socketserver.TCPServer((host, port), CustomRequestHandler) as httpd:
        print(f"Server listening on http://{host}:{port}")
        httpd.serve_forever()

"""
Production web server for Render deployment
Serves Moharain Electronics Marmat Center (index.html and assets)
"""
import http.server
import socketserver
import os
import sys

PORT = int(os.environ.get("PORT", 10000))

class ProductionHandler(http.server.SimpleHTTPRequestHandler):
    def end_headers(self):
        # Enable CORS and disable aggressive caching for fresh updates
        self.send_header("Access-Control-Allow-Origin", "*")
        self.send_header("Cache-Control", "no-cache, must-revalidate")
        super().end_headers()

    def do_GET(self):
        # Serve index.html for root path
        if self.path == "/" or self.path == "":
            self.path = "/index.html"
        return super().do_GET()

if __name__ == "__main__":
    # Ensure working directory is the script directory
    script_dir = os.path.dirname(os.path.abspath(__file__))
    os.chdir(script_dir)

    print(f"[*] Moharain Electronics server starting on 0.0.0.0:{PORT}...")
    # Allow address reuse
    socketserver.TCPServer.allow_reuse_address = True
    with socketserver.TCPServer(("", PORT), ProductionHandler) as httpd:
        print(f"[+] Server successfully running at http://0.0.0.0:{PORT}")
        sys.stdout.flush()
        httpd.serve_forever()

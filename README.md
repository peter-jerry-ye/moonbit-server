# MoonBit Server

httpd (CGI) + WasmEdge + MoonBit. WASI Preview 1 based.

## Usage

- `podman build . -t localhost/moonbit-server`
- `podman run -p 8080:80 --rm -dit localhost/moonbit-server`
- `curl --output - 'localhost:8080/cgi-bin/main?a=b'`
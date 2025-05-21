import socket
import json

HOST = '0.0.0.0'     # Listen on all interfaces
PORT = 5000          # Port must match with Flutter

def handle_client(conn, addr):
    print(f"[CONNECTED] {addr}")
    buffer = ""

    while True:
        data = conn.recv(1024).decode()
        if not data:
            break

        buffer += data

        while '\n' in buffer:
            message, buffer = buffer.split('\n', 1)

            try:
                payload = json.loads(message)
                print(f"[RECEIVED] {payload}")

                # Example response
                response = {
                    "status": 200,
                    "message": f"Received command from {payload.get('user')}, state: {payload.get('state')}"
                }

                conn.sendall((json.dumps(response) + '\n').encode())

            except json.JSONDecodeError:
                error_response = {"status": 400, "error": "Invalid JSON"}
                conn.sendall((json.dumps(error_response) + '\n').encode())

    conn.close()
    print(f"[DISCONNECTED] {addr}")


def start_server():
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as server:
        server.bind((HOST, PORT))
        server.listen()
        print(f"[LISTENING] Server on {HOST}:{PORT}")

        while True:
            conn, addr = server.accept()
            handle_client(conn, addr)

if __name__ == "__main__":
    start_server()

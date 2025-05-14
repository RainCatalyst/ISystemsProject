# serial_bridge.py
import socket
import serial
import threading

# Setup serial
ser = serial.Serial('COM3', 9600)  # Adjust to your Arduino port and baudrate

# Setup socket server
HOST = 'localhost'
PORT = 65432

def serial_to_socket(client_socket):
    while True:
        data = ser.readline().decode().strip()
        if data:
            print(f"[Arduino -> Python] {data}")
            client_socket.sendall((data + '\n').encode())

def socket_to_serial(client_socket):
    while True:
        data = client_socket.recv(1024).decode().strip()
        if data:
            print(f"[Godot -> Python] {data}")
            ser.write((data + '\n').encode())

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as server_socket:
    server_socket.bind((HOST, PORT))
    server_socket.listen(1)
    print(f"Waiting for Godot on {HOST}:{PORT}")
    client_socket, addr = server_socket.accept()
    print(f"Connected by {addr}")

    threading.Thread(target=serial_to_socket, args=(client_socket,), daemon=True).start()
    socket_to_serial(client_socket)  # Blocking call

import 'dart:convert';
import 'dart:io';
import 'dart:async';

class SocketService {
  late Socket socket;
  final StreamController<Map<String, dynamic>> _controller = StreamController.broadcast();

  Future<Map<String, dynamic>> remoteServerConnect() async {
    try {
      socket = await Socket.connect('x', 5000); 

      socket.listen((data) {
        final message = utf8.decode(data).trim();
        try {
          final decoded = jsonDecode(message);
          _controller.add(decoded); 
        } catch (e) {
          _controller.add({
            "status": 500,
            "error": "Invalid response from server"
          });
        }
      });

      return {
        "status": 200,
        "message": "Socket connected!"
      };
    } catch (e) {
      return {
        "status": 500,
        "error": "Error 1"
      };
    }
  }

  Future<Map<String, dynamic>> remoteServerDisconnect() async {
    try {
      socket.destroy();
      return {
        "status": 200,
        "message": "Socket gracefully disconnected"
      };
    } catch (e) {
      return {
        "status": 500,
        "message": e
      };
    }
  }

  Future<Map<String, dynamic>> sendData(Map<String, dynamic> command) async {
    try {
      socket.write(jsonEncode(command) + '\n');
      return {
        "status": 200,
        "message": "Data sent!"
      };
    } catch (e) {
      return {
        "status": 500,
        "error": e.toString()
      };
    }
  }

  Future<Map<String, dynamic>> getData() async {
    return await _controller.stream.first;
  }
}

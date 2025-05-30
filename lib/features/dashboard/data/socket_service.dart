import 'dart:async';
import 'dart:convert';
import 'dart:io';

class WebSocketService {
  WebSocket? _socket;
  final _controller = StreamController<Map<String, dynamic>>.broadcast();

  Future<Map<String, dynamic>> connect(String username) async {
    try {
      final uri = Uri.parse('ws://x:5000/ws/$username/lock/locking');

      _socket = await WebSocket.connect(uri.toString());

      _socket!.listen(
        (data) {
          try {
            // If server sends plain string (not JSON), wrap it
            _controller.add({"status": 200, "message": data});
          } catch (e) {
            _controller.add({"status": 500, "error": "Invalid response"});
          }
        },
        onDone: () {
          print('WebSocket connection closed');
        },
        onError: (error) {
          print('WebSocket error: $error');
        },
      );

      return {"status": 200, "message": "WebSocket connected!"};
    } catch (e) {
      return {"status": 500, "error": "Connection failed: $e"};
    }
  }

  Future<Map<String, dynamic>> disconnect() async {
    try {
      await _socket?.close();
      return {"status": 200, "message": "WebSocket gracefully disconnected"};
    } catch (e) {
      return {"status": 500, "message": e.toString()};
    }
  }

  Future<Map<String, dynamic>> sendData(String command) async {
    try {
      _socket?.add(command);
      return {"status": 200, "message": "Command sent: $command"};
    } catch (e) {
      return {"status": 500, "error": e.toString()};
    }
  }

  Future<Map<String, dynamic>> getData() async {
    return await _controller.stream.first;
  }
}

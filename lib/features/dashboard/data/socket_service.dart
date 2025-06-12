import 'dart:async';
import 'dart:convert'; // For JSON
import 'dart:io';

class WebSocketService {
  WebSocket? _socket; // For locking/unlocking
  final _controller = StreamController<Map<String, dynamic>>.broadcast();
  String? _ipAddress;

  // Connect for lock/unlock
  Future<Map<String, dynamic>> connect(String ipAddress) async {
    try {
      _ipAddress = ipAddress;
      final uri = Uri.parse('ws://$ipAddress:5000/ws/oye123/lock/locking');

      _socket = await WebSocket.connect(uri.toString());

      _socket!.listen(
        (data) {
          final decoded = jsonDecode(data);
          _controller.add({"status": 200, "message": decoded});
        },
      );

      return {"status": 200, "message": "Locking WebSocket connected!"};
    } catch (e) {
      return {"status": 500, "error": "Connection failed: $e"};
    }
  }

  Future<Map<String, dynamic>> disconnect() async {
    try {
      await _socket?.close();
      return {"status": 200, "message": "Locking WebSocket gracefully disconnected"};
    } catch (e) {
      return {"status": 500, "message": e.toString()};
    }
  }

  Future<Map<String, dynamic>> sendData(String value) async {
    try {
      if (_socket == null) {
        return {"status": 500, "error": "Locking WebSocket not connected"};
      }
      final command = jsonEncode({
        "value": value
      });
      _socket!.add(command);
      return {"status": 200, "message": "Lock command sent: $value"};
    } catch (e) {
      return {"status": 500, "error": e.toString()};
    }
  }

  // New: separate status connection
  Future<Map<String, dynamic>> getStatus() async {
    if (_ipAddress == null) {
      return {"status": 500, "error": "IP address not set"};
    }

    try {
      final uri = Uri.parse('ws://$_ipAddress:5000/ws/oye123/lock/status');

      final statusSocket = await WebSocket.connect(uri.toString());

      // Receive one message
      final data = await statusSocket.first.timeout(Duration(seconds: 5));
      final decoded = jsonDecode(data);

      await statusSocket.close();

      return {"status": 200, "message": decoded};
    } catch (e) {
      return {"status": 500, "error": "Status request failed: $e"};
    }
  }

  Stream<Map<String, dynamic>> get stream => _controller.stream;
}

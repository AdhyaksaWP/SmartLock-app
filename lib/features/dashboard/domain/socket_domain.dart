import 'package:smartlock_app/features/dashboard/data/socket_service.dart';

class SocketDomain {
  final WebSocketService service;
  SocketDomain(this.service);

  Future<Map<String, dynamic>> sendCommand(Map<String, dynamic> command) async {
    if (command.containsKey("user") && command.containsKey("state")) {
      try {
        String cmd = command["state"].toString(); // "0" or "1"
        Map<String, dynamic> resCommand = await service.sendData(cmd);

        if (resCommand["status"] == 200) {
          Map<String, dynamic> resData = await service.getStatus();
          return resData;
        }

        return {
          "status": 500,
          "error": "Command sent but no response"
        };
      } catch (e) {
        return {
          "status": 500,
          "error": e.toString()
        };
      }
    } else {
      return {
        "status": 500,
        "error": "Json badly formatted"
      };
    }
  }
}

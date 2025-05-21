import 'package:smartlock_app/features/dashboard/data/socket_service.dart';
import 'dart:async';

class SocketDomain {
  final SocketService service;
  SocketDomain(this.service);

  Future<Map<String, dynamic>> sendCommand(Map<String,dynamic> command) async {
    if (command.containsKey("user") && command.containsKey("state")) {
      try {
        Map<String,dynamic> resCommand = await service.sendData(command);

        // Check the response given from the server when client send succeeds
        if (resCommand.containsKey("status") && resCommand["status"] == 200){
          Map<String,dynamic> resData = await service.getData();
          return resData;
        }
        return {
          "status": 500,
          "error": "Data was sent but could not fetch from server"
        };
      } catch (e) {
        return {
          "status": 500,
          "user": e
        };
      }
    } else {
      return {
        "status": 500,
        "user": "Json badly formatted"
      };
    }
  }
}
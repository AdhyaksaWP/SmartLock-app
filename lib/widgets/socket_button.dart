import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smartlock_app/features/dashboard/data/socket_service.dart';
import 'package:smartlock_app/features/dashboard/domain/socket_domain.dart';
import 'package:smartlock_app/widgets/button.dart';

class SocketButtons extends StatefulWidget {
  final String ipAddress; // New field

  const SocketButtons({super.key, required this.ipAddress}); // Update constructor

  @override
  State<SocketButtons> createState() => _SocketButtonState();
}

class _SocketButtonState extends State<SocketButtons> {
  final socketService = WebSocketService();
  late SocketDomain socketDomain;
  final FirebaseAuth auth = FirebaseAuth.instance;

  bool isLocked = false;
  String response = '';
  bool isConnected = false;

  late String ipAddress;

  @override
  void initState() {
    super.initState();
    ipAddress = widget.ipAddress; // Get IP from widget
    socketDomain = SocketDomain(socketService);
  }

  void onConnect() async {
    User? user = auth.currentUser;
    if (user == null) {
      setState(() {
        response = "User not logged in.";
      });
      return;
    }

    final result = await socketService.connect(ipAddress);

    setState(() {
      isConnected = result["status"] == 200;
      response = result.toString();
    });

    socketService.stream.listen((event) {
      setState(() {
        response = event['message'].toString();
      });
    });
  }

  void onDisconnect() async {
    final result = await socketService.disconnect();

    setState(() {
      isConnected = false;
      response = result.toString();
    });
  }

  void onData() async {
    if (!isConnected) {
      setState(() {
        response = "Please connect first.";
      });
      return;
    }

    User? user = auth.currentUser;

    final result = await socketDomain.sendCommand({
      "user": user?.email ?? 'anonymous',
      "state": isLocked ? 0 : 1,
    });

    setState(() {
      isLocked = !isLocked;
      response = result.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          isLocked ? "Status: Locked" : "Status: Unlocked",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: onData,
            child: Container(
              height: 200,
              width: 200,
              decoration: const BoxDecoration(
                color: Color(0xFFA1F0A2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  height: 180,
                  width: 180,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Container(
                      height: 160,
                      width: 160,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF35F5FF), Color(0xFFBDFDFF)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: const Image(image: AssetImage('images/Key-Image.png')),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Button(
          btnHeight: 55,
          onPressed: isConnected ? onDisconnect : onConnect,
          btnText: isConnected ? "Disconnect" : "Connect",
          colors: isConnected
              ? const [Color(0xFFFF5F5F), Color(0xFFFB3B3B)]
              : const [Color(0xFFA1F0A2), Color(0xFF60FF62)],
        ),
      ],
    );
  }
}

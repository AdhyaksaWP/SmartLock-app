import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:smartlock_app/widgets/button.dart';
import 'package:smartlock_app/widgets/socket_button.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState(); 
}

class _DashboardState extends State<Dashboard> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String errorMsg = "";
  String ipAddress = ''; // New IP Address

  User? get user => auth.currentUser;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showIpAddressDialog();
    });
  }

  void _showIpAddressDialog() {
    TextEditingController ipController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false, // Cannot dismiss without entering
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter IP Address'),
          content: TextField(
            controller: ipController,
            decoration: const InputDecoration(
              hintText: 'e.g. 192.168.1.1',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                setState(() {
                  ipAddress = ipController.text;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void logOut(context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, '/');
    } catch (e) {
      setState(() {
        errorMsg = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: Offset(0, 2),
                ),
              ],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF35F5FF),
                  Color(0xFF65F3D6),
                  Color(0xFFA1F0A2)
                ]
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: "Hello,\n",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: user?.email ?? "User",
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const TextSpan(
                        text: "\nWelcome to the lock\ncontrol page",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const Text(
                  "👋",
                  style: TextStyle(fontSize: 72),
                ),
              ],
            ),
          ),
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (errorMsg != "")
                    Text(
                      errorMsg,
                      style: const TextStyle(color: Color(0xFFFF0000)),
                    ),
                  if (ipAddress.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                      child: SocketButtons(ipAddress: ipAddress),
                    )
                  else
                    const Text(
                      "Waiting for IP Address...",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  Button(
                    btnHeight: 55,
                    onPressed: () {
                      logOut(context);
                    },
                    colors: const [
                      Color(0xFFFF5F5F),
                      Color(0xFFFB3B3B),
                    ],
                    btnText: "Log Out",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:smartlock_app/features/authentication/presentation/login_popup.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Top half
          Expanded(
            child: Center(
              child: Container(
                width: 300,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF35F5FF),
                      Color(0xFF65F3D6),
                      Color(0xFFA1F0A2)
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(90),
                    bottomRight: Radius.circular(90)
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(170, 180, 180, 180),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(0, 4), // vertical offset
                    ),
                  ]
                ),
                child: const Center(
                  child: Image(
                    image: AssetImage('images/Key-Image.png'),
                  )
                ),
              ),
            ),
          ),

          // Bottom half
          Expanded(
            child: Center(
              child: Container(
                width: 400,
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Control your SmartLock\nwith ease",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        shadows: [
                          Shadow(
                            color: Color.fromARGB(170, 180, 180, 180),
                            blurRadius: 10,
                            offset: Offset(0, 4), // vertical offset
                          ),
                        ]
                      ),
                    ),
                    const SizedBox(height: 70),
                    Container(
                      width: 200,
                      height: 65,
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF94F5FA), 
                            Color(0xFF35F5FF), 
                          ],
                          stops: [0.0, 1.0],
                        ),
                        borderRadius: BorderRadius.circular(15), 
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(170, 180, 180, 180),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          loginDialog(context: context);
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0, // No default shadow
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          "Get Started",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Color.fromARGB(170, 180, 180, 180),
                                blurRadius: 10,
                                offset: Offset(0, 4), // vertical offset
                              ),
                            ]
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

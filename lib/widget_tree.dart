import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smartlock_app/features/welcome/presentation/welcome_page.dart';
import 'package:smartlock_app/features/dashboard/presentation/dashboard.dart';


class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<StatefulWidget> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree>{
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(), 
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Dashboard();
        } else {
          return const WelcomePage();
        }
      },
    );
  }
}
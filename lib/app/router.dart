import 'package:flutter/material.dart';
import 'package:smartlock_app/features/welcome/presentation/welcome_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const WelcomePage());
      default:
        return MaterialPageRoute(builder: (_) => const WelcomePage());        
    }
  }
}
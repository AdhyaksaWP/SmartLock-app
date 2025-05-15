import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartlock_app/app/router.dart';

void main() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: '/',
    );
  }
} 
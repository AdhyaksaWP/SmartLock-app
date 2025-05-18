import 'package:flutter/material.dart';

class Button extends StatelessWidget  {
  final VoidCallback onPressed;
  final String btnText;
  final double btnWidth, btnHeight;
  final List<Color> colors;

  const Button({
    super.key, 
    required this.onPressed, 
    required this.btnText,
    this.btnWidth = 200,
    this.btnHeight = 65,
    this.colors = const [
      Color(0xFF94F5FA), 
      Color(0xFF35F5FF), 
    ]
  });

  @override
  Widget build(BuildContext context){
  return Container(
      width: btnWidth,
      height: btnHeight,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: colors,
          stops: [0.0, 1.0], 
        ),
        borderRadius: BorderRadius.circular(15), 
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(170, 121, 48, 48),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0, 
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(
          btnText,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                color: Color.fromARGB(170, 180, 180, 180),
                blurRadius: 10,
                offset: Offset(0, 4), 
              ),
            ]
          ),
        ),
      ),
    );
  }
}
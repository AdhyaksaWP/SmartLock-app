import 'package:flutter/material.dart';

Future loginDialog({context}) => showDialog(
  context: context, 
  builder: (BuildContext context) => AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      side: BorderSide(
        color: Color(0xFF35F5FF),
        width: 2.0
      )
    ),
    title: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Login",
              style: TextStyle(
                fontWeight: FontWeight.w700
              ),
            ),
            SizedBox(
              width: 30,
              height: 30,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                }, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF5F5F),
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    side: BorderSide(
                      color: Color(0xFF000000),
                      width: 2.0
                    )
                  )
                ),
                child: Center(
                  child: Text(
                    "X",
                    style: TextStyle(
                      color: Color(0xFFFFFFFF)
                    ),  
                  )
                ),
              ),
            )
          ],
        ),
        Text(
          "Jika Anda tidak memiliki akun\nsilahkan Sign Up terlebih dahulu",
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFFCECECE)
          ),
        )
      ],
    ),
    content: 
    SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        children: <Widget>[
            TextField(
              decoration: InputDecoration(hintText: "email"),
            ),
            TextField(
              decoration: InputDecoration(hintText: "password"),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
              child:  Container(
                width: 200,
                height: 65,
                margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF94F5FA), // light cyan top
                      Color(0xFF35F5FF), // bright cyan bottom
                    ],
                    stops: [0.0, 1.0], // smooth full range
                  ),
                  borderRadius: BorderRadius.circular(15), // rounded like the image
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(170, 180, 180, 180),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(0, 4), // vertical offset
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
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
                    "Sign Up",
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
              ),
            ),
            Container(
              width: 200,
              height: 65,
              margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF94F5FA), // light cyan top
                    Color(0xFF35F5FF), // bright cyan bottom
                  ],
                  stops: [0.0, 1.0], // smooth full range
                ),
                borderRadius: BorderRadius.circular(15), // rounded like the image
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(170, 180, 180, 180),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: Offset(0, 4), // vertical offset
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
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
                  "Login",
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
  )
);

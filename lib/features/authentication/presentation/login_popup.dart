import 'package:flutter/material.dart';
import 'package:smartlock_app/features/authentication/domain/auth_domain.dart';
import 'package:smartlock_app/widgets/button.dart';
import 'package:smartlock_app/features/authentication/data/auth_repository.dart';

class LoginDialog extends StatefulWidget{
  const LoginDialog({super.key});

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog>{
  final AuthDomain authDomain = AuthDomain(AuthRepository());

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();

  bool _isLogin = true;
  String errorMsg = "";

  void register() async {
    if (_isLogin){
      setState(() {
        _isLogin = false;
      });
      return;
    }
    Map<String, dynamic> res = await authDomain.executeRegister(
      email: email.text, 
      password: password.text,
    );
    if (res.containsKey("error")){
      handleError(res);
    }
  }

  void login() async {
    if (!_isLogin){
      setState(() {
        _isLogin = true;
      });
    }
    Map<String, dynamic> res = await authDomain.executeLogin(
      email: email.text, 
      password: password.text
    );
    if (res.containsKey("error")){
      handleError(res);
    }
  }

  void handleError(res){
    setState(() {
      errorMsg = res["error"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
                _isLogin ? "Login" : "Register",
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
          if (errorMsg != "") Text(errorMsg),
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
        height: MediaQuery.of(context).size.height / 2.8 ,
        child: Column(
          children: <Widget>[
            TextField(
              controller: email,
              decoration: const InputDecoration(hintText: "email"),
            ),
            TextField(
              controller: password,
              decoration: const InputDecoration(hintText: "password"),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
              child: Button(
                btnText: "Sign Up",
                onPressed: () {
                  // Navigator.of(context).pop();
                  register();
                },
              )
            ),
            Button(
              btnText: "Login",
              onPressed: () {
                // Navigator.of(context).pop();
                login();
              },
            )
          ],
        ),
      ), 
    );
  }
}
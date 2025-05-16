import 'package:smartlock_app/features/authentication/data/auth_repository.dart';

class AuthDomain {
  final String name = "";
  final String email = "";
  final String password = "";
  final AuthRepository repository;
  AuthDomain(this.repository);

  Future<Map<String, dynamic>> executeRegister({
    required String email, 
    required String password
  }) async {
    if (!email.contains("@")) {
      return {
        "error": "Not a valid email address"
      };
    }
    else if (password.length < 8) {
      return {
        "error": "Needs to be a stronger password"
      };
    }
    try {
      final result = await repository.registerService(
        email: email, 
        password: password
      );
      return {
        "status": 200,
        "user": result.user
      };
    } catch (e){
      return {
        "status": 500,
        "error": e.toString() 
      };
    }
  }
  Future<Map<String, dynamic>> executeLogin({
    required String email,
    required String password
  }) async {
    try {
      final result = await repository.loginService(
        email: email, 
        password: password
      );
      return {
        "status": 200,
        "user": result.user
      };
    } catch (e){
      return {
        "status": 500,
        "error": e.toString() 
      };
    }
  }
}
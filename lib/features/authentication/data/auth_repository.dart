import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final String name = "";
  final String email = "";
  final String password = "";

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  Future<UserCredential> registerService({
    required String email , 
    required String password
  }) async {
    return await firebaseAuth.createUserWithEmailAndPassword(
      email: email, 
      password: password
    );
  }
  
  Future<UserCredential> loginService({
    required String email,
    required String password
  }) async {
    return await firebaseAuth.signInWithEmailAndPassword(
      email: email, 
      password: password
    );
  }
}
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //instance of auth
  final FirebaseAuth auth = FirebaseAuth.instance;

  //signin
  Future<UserCredential> signInWithEmailPassword(String email, password) async {
    try {
      UserCredential usercredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return usercredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //signup

  //sign out

  //errors
}

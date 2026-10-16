import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // Create an instance of FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Sign in method
  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Sign up method
  Future<void> signUp({required String email, required String password}) async {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Sign out method
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(' Error in SignOut: ${e.toString()}');
    }
  }

  Future<String?> updateEmailAndPassword({required String newEmail,required String newPassword}) async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        if (newEmail.isNotEmpty) {
          await user.verifyBeforeUpdateEmail(newEmail);
        }
        if (newPassword.isNotEmpty ) {

          await user.updatePassword(newPassword);
        }

        return null; 
      }
      return "Not user now";
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  // Stream to listen to authentication state changes
  // يُستدعى في  LandingScreen عشان نعرف المستخدم عامل تسجيل دخول ولا لا
  Stream<User?> get authStateChanges {
    return _auth.authStateChanges();
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// Login with email & password
  static Future<User?> login(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print("Login failed: ${e.code} - ${e.message}");
      return null;
    } catch (e) {
      print("Unexpected error: $e");
      return null;
    }
  }

  /// Sign up new user
  static Future<User?> register(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print("Register failed: ${e.code} - ${e.message}");
      return null;
    } catch (e) {
      print("Unexpected error: $e");
      return null;
    }
  }
  // sign in with google
  // sign in with google
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // User cancelled the sign-in
        print("Google Sign-In cancelled.");
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      // Create a new credential for Firebase
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Firebase
      final UserCredential userCredential =
      await _auth.signInWithCredential(credential);

      final User? user = userCredential.user;

      if (user != null) {
        print("Firebase User Signed In: ${user.displayName}, ${user.email}");
      }

      return user;
    } catch (error) {
      print("Google Sign-In failed: $error");
      return null;
    }
  }


  /// Logout user
  /// Logout user (Firebase + Google)
  static Future<void> logout() async {
    try {
      // Sign out from Firebase
      await _auth.signOut();

      // Also disconnect Google (if used)
      final GoogleSignIn googleSignIn = GoogleSignIn();
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.disconnect();
      }

      print("User logged out successfully.");
    } catch (e) {
      print("Logout failed: $e");
    }
  }


  /// Current logged-in user
  static User? get currentUser => _auth.currentUser;
}

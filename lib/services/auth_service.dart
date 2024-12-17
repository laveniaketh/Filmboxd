import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  
  // instance of auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  //get current user
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  // email sign in 
  Future<UserCredential> signInWithEmailAndPassword(String email, password) async {
    try {
      // sign user in 
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // email sign up
  Future<UserCredential> signUpWithEmailAndPassword(String email, password) async {
    try {
      // create user
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //sign out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
  }

  // google sign in
  signInWithGoogle() async {

    //begin interactive sign in process
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    //user cancels google sign in popup screen
    if(googleUser == null) {
      return null;
    }

    //obtain auth details from request 
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    //create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );

    //finally sign in
    return await _firebaseAuth.signInWithCredential(credential);
  } 

  //possible error messages
  String getErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided for that user.';
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'weak-password':
        return 'The password is too weak.';
      default:
        return 'An error occurred.';
    }
  }



  
}
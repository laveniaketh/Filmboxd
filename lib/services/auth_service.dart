import 'package:cloud_firestore/cloud_firestore.dart';
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
  Future<UserCredential> signInWithEmailAndPassword(
      String email, password) async {
    try {
      // sign user in
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // email sign up
  Future<UserCredential> signUpWithEmailAndPassword(
      String email, password) async {
    try {
      // create user
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      try {
        String? userEmail = userCredential.user?.email;

        if (userEmail != null) {
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(userEmail) 
              .set({
            'name': userEmail.split('@')[0],
            'username': userEmail.split('@')[0],
            'bio': "empty bio..."
          });
          print("Document successfully created in Firestore.");
        } else {
          print("Error: user email is null.");
        }
      } catch (e) {
        print("Error creating Firestore document: $e");
      }

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
  // signInWithGoogle() async {
  //   //begin interactive sign in process
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //   //user cancels google sign in popup screen
  //   if (googleUser == null) {
  //     return null;
  //   }

  //   //obtain auth details from request
  //   final GoogleSignInAuthentication googleAuth =
  //       await googleUser.authentication;

  //   //create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

  //   //finally sign in
  //   return await _firebaseAuth.signInWithCredential(credential);
  // }

  // google sign in
Future<UserCredential?> signInWithGoogle() async {
  try {
    // Begin interactive sign-in process
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    // User cancels the Google sign-in popup screen
    if (googleUser == null) {
      return null;
    }

    // Obtain authentication details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    // Sign in to Firebase with the Google credential
    UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(credential);

    // Check Firestore for an existing document; create one if it doesn't exist
    final User? user = userCredential.user;

    if (user != null) {
      final userEmail = user.email ?? "";
      final userDoc = FirebaseFirestore.instance.collection('Users').doc(userEmail);

      // Check if the user document exists
      final docSnapshot = await userDoc.get();
      if (!docSnapshot.exists) {
        await userDoc.set({
          'name': user.displayName ?? userEmail.split('@')[0], // Default name if displayName is null
          'username': userEmail.split('@')[0],
          'email': userEmail,
          'bio': "empty bio..."
        });
        print("New user document created in Firestore.");
      } else {
        print("User document already exists.");
      }
    }
    return userCredential;
  } catch (e) {
    print("Error signing in with Google: $e");
    return null;
  }
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

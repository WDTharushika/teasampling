import 'package:tea_sampling/home.dart';
import 'package:tea_sampling/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;

  // Method to get the current authenticated user
  Future<User?> getCurrentUser() async {
    return auth.currentUser;
  }

  // Method to sign in with Google
  Future<void> signInWithGoogle(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn(); // Initiates the Google Sign-In flow
      if (googleSignInAccount == null) {
        // The user canceled the sign-in process
        return;
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      // Signing in the user with the provided Google credentials
      UserCredential result = await auth.signInWithCredential(credential);

      User? userDetails = result.user;

      if (userDetails != null) {
        // User data to be stored in Firestore
        Map<String, dynamic> userInfoMap = {
          "email": userDetails.email,
          "name": userDetails.displayName,
          "imgUrl": userDetails.photoURL,
          "id": userDetails.uid
        };

        // Add user information to the Firestore database
        await DatabaseMethods()
            .addUser(userDetails.uid, userInfoMap)
            .then((value) {
          // Navigate to Home screen upon successful sign-in
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const Home()));
        });
      }
    } catch (e) {
      // Handle error gracefully
      print("Error during Google Sign-In: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to sign in with Google: $e")),
      );
    }
  }

 
}


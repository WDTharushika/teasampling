import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  // Add a new user to the Firestore collection "User"
  Future<void> addUser(String userId, Map<String, dynamic> userInfoMap) async {
    try {
      await FirebaseFirestore.instance
          .collection("User")
          .doc(userId)
          .set(userInfoMap);
    } catch (e) {
      print("Error adding user: $e");
      rethrow;
    }
  }

  // Add user details to the specified collection (Leaf, Root, or Soil)
  Future<void> addUserDetails(
      Map<String, dynamic> userInfoMap, String id, {String collection = "Leaf detail form"}) async {
    try {
      await FirebaseFirestore.instance
          .collection(collection)
          .doc(id)
          .set(userInfoMap);
    } catch (e) {
      print("Error adding user details: $e");
      rethrow;
    }
  }

  // Get user details for the logged-in user from the specified collection
  Stream<QuerySnapshot> getUserDetails(String uid, {String collection = "Leaf detail form"}) {
    try {
      return FirebaseFirestore.instance
          .collection(collection)
          .where('uid', isEqualTo: uid) // Filter by user UID
          .snapshots();
    } catch (e) {
      print("Error getting user details: $e");
      rethrow;
    }
  }

  // Update user details in the specified collection
  Future<void> updateUserDetails(
      String id, Map<String, dynamic> userInfoMap, {String collection = "Leaf detail form"}) async {
    try {
      await FirebaseFirestore.instance
          .collection(collection)
          .doc(id)
          .update(userInfoMap);
    } catch (e) {
      print("Error updating user details: $e");
      rethrow;
    }
  }

  // Delete user details from the specified collection
  Future<void> deleteUserDetails(String id, {String collection = "Leaf detail form"}) async {
    try {
      await FirebaseFirestore.instance
          .collection(collection)
          .doc(id)
          .delete();
    } catch (e) {
      print("Error deleting user details: $e");
      rethrow;
    }
  }
}

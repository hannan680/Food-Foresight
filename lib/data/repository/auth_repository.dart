import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import './autherror_handler.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user;

  get user => _user;

  Future<String?> signUp({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (_auth.currentUser != null) {
        _auth.currentUser!.updateDisplayName(name);
      }
      if (userCredential.user?.uid != null) {
        await _createUserDocument(
            userId: userCredential.user!.uid,
            name: name,
            phone: phone,
            email: email);
        await signOut();
      }
    } catch (err) {
      // Handle any sign-up errors here
      print("_____________Sign Up___________________________");
      throw Exception(AuthErrorHandler.getErrorMessage(err));
    }
  }

  Future<void> _createUserDocument({
    required String userId,
    required String name,
    required String phone,
    required String email,
  }) async {
    try {
      await _firestore.collection('users').doc(userId).set({
        'name': name,
        'phone': phone,
        'email': email,
        // Add more fields if needed
      });
    } catch (e) {
      print('Error creating user document: $e');
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (err) {
      print("_____________Sign In___________________________");
      throw Exception(AuthErrorHandler.getErrorMessage(err));
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<void> updateProfilePicture(String imagePath) async {
    try {
      User? user = getCurrentUser();

      if (user != null) {
        // Upload the image to Firebase Storage
        Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('profile_pictures/${user.uid}.jpg');

        await storageReference.putFile(File(imagePath));

        // Get the download URL of the uploaded image
        String downloadURL = await storageReference.getDownloadURL();

        // Update the user's profile with the new photo URL
        await user.updatePhotoURL(downloadURL);

        // Reload the user to get the updated information
        await user.reload();
        user = getCurrentUser();

        // Update the user document in Firestore with the new photo URL
        await _firestore
            .collection('users')
            .doc(user!.uid)
            .update({'photoURL': user.photoURL});
      }
    } catch (e) {
      print("Error updating profile picture: $e");
      throw Exception(AuthErrorHandler.getErrorMessage(e));
    }
  }

  Future<void> deleteAccount(String password) async {
    try {
      User? user = getCurrentUser();

      if (user != null) {
        // Reauthenticate the user with their password
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: password,
        );

        await user.reauthenticateWithCredential(credential);

        // Delete the user document in Firestore
        await _firestore.collection('users').doc(user.uid).delete();

        // Delete the user's account
        await user.delete();
      }
    } catch (e) {
      print("Error deleting account: $e");
      throw Exception("Error deleting account. Please try again later.");
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      print("Error sending reset password email: $e");
      throw Exception(
          "Error sending reset password email. Please try again later.");
    }
  }
}

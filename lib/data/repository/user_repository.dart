import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_foresight/data/repository/autherror_handler.dart';
import 'dart:io';

class UserRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateProfilePicture(String imagePath) async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('profile_pictures/${user.uid}.jpg');

        await storageReference.putFile(File(imagePath));

        String downloadURL = await storageReference.getDownloadURL();

        await user.updatePhotoURL(downloadURL);
        await user.reload();

        // Update the user document in Firestore with the new photo URL
        await _firestore
            .collection('users')
            .doc(user.uid)
            .update({'photoURL': user.photoURL});
      }
    } catch (e) {
      print("Error updating profile picture: $e");
      throw Exception(AuthErrorHandler.getErrorMessage(e));
    }
  }
}

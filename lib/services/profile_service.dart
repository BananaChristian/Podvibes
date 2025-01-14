import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class ProfileService {
  Future<void> uploadProfilePicture(String userId) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage == null) return;

    final storageRef = FirebaseStorage.instance
        .ref()
        .child('profilePictures')
        .child('$userId.jpg');

    try {
      await storageRef.putFile(File(pickedImage.path));
      final downloadUrl = await storageRef.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'profilePicture': downloadUrl});
    } catch (e) {
      debugPrint('Error uploading profile picture $e');
    }
  }

  Future <String> fetchProfilePicture(String userId) async {
    try{
      final userDoc=await FirebaseFirestore.instance.collection('users').doc(userId).get();
      if(userDoc.exists){
        final profileImageUrl=userDoc['profileImageUrl'];
        if(profileImageUrl!=null){
          return profileImageUrl;
        }
      }
    }catch(e){
      print('Error fetching profile picture $e');
    }
    return '';
  }
}

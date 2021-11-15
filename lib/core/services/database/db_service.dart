import 'dart:io';

// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sporty/core/models/user_model.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  DatabaseService._internal();

  factory DatabaseService() {
    return _instance;
  }

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> uploadUserCredentials(UserModel userMap) async {
    await _firestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .set(
          userMap.toJson(),
        )
        .catchError((onError) => print('DS - Failed to add user: $onError'));
  }

  Future<void> updateUserCredentials(
      {required String fieldName, required dynamic fieldValue}) async {
    await _firestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .update({'$fieldName': '$fieldValue'}).catchError(
            (onError) => print('DS - Failed to update user: $onError'));
  }

  Future<void> updateUserProfilePicture(File avatar) async {
    await _firestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .update(UserModel(avatar: avatar).toJson())
        .catchError((onError) => print('DS - Failed to update user: $onError'));
  }

  Future<void> deleteUserCredentials() async {
    await _firestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .delete()
        .catchError((onError) => print('DS - Failed to delete user: $onError'));
  }

  Future<UserModel> getUserCredentials() async {
    DocumentSnapshot snapshot = await _firestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .get()
        .catchError((onError) {
      print('DS - Failed to delete user: $onError');
    });

    return UserModel.fromJson(snapshot.data());
  }
}

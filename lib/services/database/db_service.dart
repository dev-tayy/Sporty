import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sporty/models/user_model.dart';

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

  Future<void> updateUserCredentials(UserModel userMap) async {
    await _firestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .update(userMap.toJson())
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

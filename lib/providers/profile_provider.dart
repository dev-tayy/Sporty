import 'package:sporty/helper/snackbar.dart';
import 'package:sporty/models/user_model.dart';
import 'package:sporty/services/database/db_service.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as sysPath;

class ProfileProvider extends ChangeNotifier {
  DatabaseService _databaseService = DatabaseService();
  //FirebaseAuth _auth = FirebaseAuth.instance;
  List<File> images = [];
  List<File> newImages = [];
  late File newImageFile;

  Future<UserModel> getUserCredentials(BuildContext context) async {
    return _databaseService.getUserCredentials().catchError((e) {
      SportyAppSnackBar.showErrorSnackBar(context, message: e.toString());
    });
  }

  Future<void> updateProfilePicture(BuildContext context, File? avatar) async {
    await _databaseService
        .updateUserCredentials(fieldName: 'avatar', fieldValue: avatar)
        .catchError((onError) =>
            SportyAppSnackBar.showErrorSnackBar(context, message: '$onError'));
  }

  Future<List<File?>> getImage(BuildContext context) async {
    try {
      images.clear();
      File imageFile = await ImagePicker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 20,
          maxHeight: 900,
          maxWidth: 600);

      var appDocDir = await sysPath.getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
      newImageFile = await imageFile.copy('$appDocPath ${DateTime.now()}');

      images.add(newImageFile);
    } catch (e) {
      SportyAppSnackBar.showErrorSnackBar(context,
          message: 'Image not selected');
    }
    notifyListeners();
    return images;
  }

  notifyListeners();
}

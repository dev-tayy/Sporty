import 'package:firebase_auth/firebase_auth.dart';
import 'package:sporty/helper/snackbar.dart';
import 'package:sporty/models/user_model.dart';
import 'package:sporty/screens/home_screen.dart';
import 'package:sporty/services/auth/auth_service.dart';
import 'package:sporty/services/auth/exception_handler.dart';
import 'package:sporty/services/database/db_service.dart';
import 'package:sporty/services/database/db_service_sp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class ProfileProvider extends ChangeNotifier {
  DatabaseService _databaseService = DatabaseService();
  //FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel> getUserCredentials(BuildContext context) async {
    return _databaseService.getUserCredentials().catchError((e) {
      SportyAppSnackBar.showErrorSnackBar(context, message: e.toString());
    });
  }

  notifyListeners();
}

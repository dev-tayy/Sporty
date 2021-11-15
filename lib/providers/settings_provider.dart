// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sporty/helper/snackbar.dart';
import 'package:sporty/main.dart';
import 'package:sporty/core/services/auth/auth_service.dart';
import 'package:sporty/core/services/auth/exception_handler.dart';
import 'package:sporty/core/services/database/db_service.dart';
import 'package:sporty/core/services/database/db_service_sp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';


class SettingsProvider extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseService _databaseService = DatabaseService();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isTapped = false;
  bool get isTapped => _isTapped;
  set isTap(bool val) {
    _isTapped = true;
    notifyListeners();
  }

  Future<void> signOut(BuildContext context) async {
    final progress = ProgressHUD.of(context);
    progress!.showWithText('Logging out ...');

    await AuthenticationService().logout();
    await DatabaseServiceSp.dispose();

    // Provider.of<AppProvider>(context, listen: false).dispose();
    // Provider.of<ProfileProvider>(context, listen: false).dispose();
    // Provider.of<SettingsProvider>(context, listen: false).dispose();

    progress.dismiss();

    Navigator.pushNamedAndRemoveUntil(
        context, WelcomeScreen.id, (route) => false);
  }

  Future<void> updateUsername(
      {required BuildContext context, required String newUsername}) async {
    try {
      await _auth.currentUser.updateProfile(displayName: newUsername);
      await DatabaseServiceSp.saveUsername(newUsername);
      await _databaseService.updateUserCredentials(
          fieldName: 'username', fieldValue: newUsername);
    } catch (e) {
      SportyAppSnackBar.showErrorSnackBar(context, message: e.toString());
    }
  }

  Future<void> updateEmail(
      {required BuildContext context, required String newEmail}) async {
    try {
      await _auth.currentUser.verifyBeforeUpdateEmail(newEmail).catchError((e) {
        String errorMsg = AuthExceptionHandler.generateExceptionMessage(e);
        SportyAppSnackBar.showErrorSnackBar(context, message: errorMsg);
      });
      await DatabaseServiceSp.saveEmail(newEmail);
      await _databaseService.updateUserCredentials(
          fieldName: 'email', fieldValue: newEmail);
    } catch (e) {
      print(e);
    }
  }

  Future<void> changePassword(
      {required BuildContext context, required String newPassword}) async {
    _auth.currentUser.updatePassword(newPassword).catchError((e) {
      String errorMsg = AuthExceptionHandler.generateExceptionMessage(e);
      SportyAppSnackBar.showErrorSnackBar(context, message: errorMsg);
    });
  }

  notifyListeners();
}

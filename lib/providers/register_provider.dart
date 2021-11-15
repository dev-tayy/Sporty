import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:sporty/helper/snackbar.dart';
import 'package:sporty/screens/login_screen.dart';
import 'package:sporty/core/services/auth/auth_service.dart';
import 'package:sporty/core/services/auth/exception_handler.dart';
import 'package:sporty/core/services/database/db_service.dart';
import 'package:sporty/core/models/user_model.dart';
import 'package:sporty/helper/helper.dart';
import 'package:sporty/core/services/navigation_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;

class RegisterProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  DatabaseService _databaseService = DatabaseService();
  File? avatar;
  List<String>? _interests;
  List<String>? get interests => _interests;
  set setInterests(List<String>? interests) {
    _interests = interests;
  }

  Future<void> registerUsers(BuildContext context) async {
    final progress = ProgressHUD.of(context);
    progress!.showWithText('Creating account...');

    AuthResultStatus newUser = await AuthenticationService().createAccount(
      email: emailController.text.trim(),
      password: passwordController.text,
      username: usernameController.text.trim(),
    );

    Future<bool> checkUsernameExists(String username) async {
      bool checkUsername = (await firestore
                  .collection("users")
                  .where('username', isEqualTo: username)
                  .get())
              .docs
              .length >
          0;

      if (checkUsername == false) {
        if (newUser == AuthResultStatus.successful) {
          UserModel userCredentials = UserModel(
              email: emailController.text.trim(),
              username: usernameController.text.trim(),
              phoneNumber: phoneNumberController.text,
              interests: _interests,
              createdAt: DateTime.now().toString(),
              id: _auth.currentUser!.uid,
              avatar: avatar);
          print(_interests!.length);
          _databaseService.uploadUserCredentials(userCredentials).catchError(
              (e) => SportyAppSnackBar.showErrorSnackBar(context,
                  message: e.toString()));

          NavigationService.navigateTo(LoginScreen.id);

          showSuccessDialog(
            context: context,
            message: 'Account created! We\'ve sent a verification mail to you.',
          );

          usernameController.text = '';
          emailController.text = '';
          phoneNumberController.text = '';
          passwordController.text = '';
          interests!.clear();
        } else {
          final errorMsg =
              AuthExceptionHandler.generateExceptionMessage(newUser);
          SportyAppSnackBar.showErrorSnackBar(context, message: errorMsg);
        }
      } else {
        SportyAppSnackBar.showErrorSnackBar(context,
            message: 'Username already exists');
      }
      return checkUsername;
    }

    checkUsernameExists(usernameController.text);

    progress.dismiss();
  }

  notifyListeners();
}

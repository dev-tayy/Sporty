import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:sporty/helper/snackbar.dart';
import 'package:sporty/services/auth/auth_service.dart';
import 'package:sporty/services/auth/exception_handler.dart';
import 'package:sporty/services/database/db_service.dart';
import 'package:sporty/models/user_model.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class SignUpModel extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  DatabaseService _databaseService = DatabaseService();

  signUp(BuildContext context) async {
    final progress = ProgressHUD.of(context);
    progress!.showWithText('Creating account...');

    AuthResultStatus newUser = await AuthenticationService().createAccount(
      email: emailController.text.trim(),
      password: passwordController.text,
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
            interests: [],
            createdAt: DateTime.now().toString(),
          );

          _databaseService.uploadUserCredentials(userCredentials);
          
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

    Future.delayed(Duration(seconds: 1), () {
      progress.dismiss();
    });
  }

  notifyListeners();
}

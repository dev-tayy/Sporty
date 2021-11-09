import 'package:sporty/helper/snackbar.dart';
import 'package:sporty/screens/home_screen.dart';
import 'package:sporty/services/auth/auth_service.dart';
import 'package:sporty/services/auth/exception_handler.dart';
import 'package:sporty/services/database/db_service_sp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class LoginProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login(BuildContext context) async {
    final progress = ProgressHUD.of(context);
    progress!.showWithText('Logging in...');

    var user = await AuthenticationService().logIn(
      email: emailController.text,
      password: passwordController.text,
    );

    progress.dismiss();
    

    if (user == AuthResultStatus.successful) {
      DatabaseServiceSp.saveEmail(emailController.text);
      //DatabaseServiceSp.saveUsername(usernameController.text);
      
      Navigator.pushNamedAndRemoveUntil(
        context,
        HomeScreen.id,
        (Route<dynamic> route) => false,
      );
    } else {
      final errorMsg = AuthExceptionHandler.generateExceptionMessage(user);
      SportyAppSnackBar.showErrorSnackBar(context, message: errorMsg);
    }
  }

  notifyListeners();
}

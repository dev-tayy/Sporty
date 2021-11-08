import 'package:sporty/helper/helper.dart';
import 'package:sporty/helper/snackbar.dart';
import 'package:sporty/screens/home_screen.dart';
import 'package:sporty/screens/login_screen.dart';
import 'package:sporty/services/auth/auth_service.dart';
import 'package:sporty/services/auth/exception_handler.dart';
import 'package:sporty/services/database/db_service_sp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:sporty/services/navigation_service.dart';

class ResetPasswordProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();

  Future<void> resetPassword(BuildContext context) async {
    final progress = ProgressHUD.of(context);
    progress!.show();

    var user = await AuthenticationService().resetPassword(
      email: emailController.text,
    );

    Future.delayed(Duration(seconds: 1), () {
      progress.dismiss();
    });

    if (user == AuthResultStatus.successful) {
      showSuccessDialog(
          context: context,
          message: 'A password reset link has been sent to your email.',
          action: NavigationService.navigateTo(LoginScreen.id));
    } else {
      final errorMsg = AuthExceptionHandler.generateExceptionMessage(user);
      SportyAppSnackBar.showErrorSnackBar(context, message: errorMsg);
    }
  }

  notifyListeners();
}

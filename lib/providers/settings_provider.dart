import 'package:sporty/helper/snackbar.dart';
import 'package:sporty/screens/home_screen.dart';
import 'package:sporty/services/auth/auth_service.dart';
import 'package:sporty/services/auth/exception_handler.dart';
import 'package:sporty/services/database/db_service_sp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class SettingsProvider extends ChangeNotifier {
  int currentIndex = 0;
  void toggle(int index) {
    currentIndex = index;
    notifyListeners();
  }

  notifyListeners();
}

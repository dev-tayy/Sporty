import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:sporty/providers/app_provider.dart';
import 'package:sporty/screens/buddies_screen.dart';
import 'package:sporty/screens/discover_screen.dart';
import 'package:sporty/screens/profile_screen.dart';
import 'package:sporty/screens/settings_screen.dart';
import 'package:sporty/core/services/navigation_service.dart';
import 'package:sporty/screens/splash_screen.dart';
import 'package:sporty/screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'package:provider/provider.dart';
import 'package:sporty/providers/providers.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: providers, child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, model, child) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorObservers: [
            BotToastNavigatorObserver(),
          ],
          builder: BotToastInit(),
          title: 'Sporty',
          navigatorKey: NavigationService.navigationKey,
          theme: ThemeData(
            fontFamily: 'BasisGrotesquePro',
            primarySwatch: Colors.green,
          ),
          initialRoute: SplashScreen.id,
          routes: {
            SplashScreen.id: (context) => SplashScreen(),
            WelcomeScreen.id: (context) => WelcomeScreen(),
            LoginScreen.id: (context) => LoginScreen(),
            HomeScreen.id: (context) => HomeScreen(),
            RegisterScreen.id: (context) => RegisterScreen(),
            ProfileScreen.id: (context) => ProfileScreen(),
            SettingsScreen.id: (context) => SettingsScreen(),
            BuddiesScreen.id: (context) => BuddiesScreen(),
            DiscoverScreen.id: (context) => DiscoverScreen(),
            // EditProfileScreen.id: (context) => EditProfileScreen(),
            // ChangePasswordScreen.id: (context) => ChangePasswordScreen(),
            ForgotPasswordScreen.id: (context) => ForgotPasswordScreen(),
            // ResetPasswordScreen.id: (context) => ResetPasswordScreen(),
            // ChangeEmailScreen.id: (context) => ChangeEmailScreen(),
          });
    });
  }
}


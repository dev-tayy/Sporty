import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sporty/providers/app_provider.dart';
import 'package:sporty/screens/buddies_screen.dart';
import 'package:sporty/screens/discover_screen.dart';
import 'package:sporty/screens/profile_screen.dart';
import 'package:sporty/screens/settings_screen.dart';
import 'package:sporty/core/services/database/db_service_sp.dart';
import 'package:sporty/core/services/navigation_service.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'helper/helper.dart';
import 'package:provider/provider.dart';
import 'package:sporty/providers/providers.dart';
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

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);
  static String id = "splash_screen";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  Animation? animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.decelerate,
    );

    animationController.forward();

    animationController.addListener(() {
      setState(() {});
    });

    animationController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        DatabaseServiceSp.getEmail();
        SharedPreferences shared = await SharedPreferences.getInstance();
        String? email = shared.getString(DatabaseServiceSp.emailKey);
        print(email);
        email == null
            ? Navigator.pushReplacementNamed(context, WelcomeScreen.id)
            : Navigator.pushReplacementNamed(context, HomeScreen.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text(
            'Sporty',
            style: TextStyle(
                fontFamily: 'MochiyPopPOne',
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),
        ));
  }
}

class WelcomeScreen extends StatelessWidget {
  static String id = 'welcome_screen';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Stack(
            children: [
              ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black, Colors.transparent],
                  ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                },
                blendMode: BlendMode.dstIn,
                child: Image.asset(
                  'assets/images/welcome_screen.jpg',
                  width: size.width,
                  height: size.height * 0.7,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                top: 450,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Sporty',
                    style: TextStyle(
                        fontFamily: 'MochiyPopPOne',
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: size.width * 0.8,
            child: ElevatedButton(
              onPressed: () => NavigationService.navigateTo(RegisterScreen.id),
              style: ElevatedButton.styleFrom(
                elevation: 5,
                primary: Colors.green.shade800,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Create Account',
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
          YMargin(15),
          Text('Already have an account?',
              style: TextStyle(color: Colors.white, fontSize: 13)),
          YMargin(15),
          Container(
            width: size.width * 0.8,
            child: ElevatedButton(
              onPressed: () => NavigationService.navigateTo(LoginScreen.id),
              style: ElevatedButton.styleFrom(
                primary: Colors.red.shade800,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Login',
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

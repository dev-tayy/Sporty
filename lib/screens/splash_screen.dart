import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sporty/core/services/database/db_service_sp.dart';
import 'package:sporty/screens/home_screen.dart';
import 'package:sporty/screens/welcome_screen.dart';

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


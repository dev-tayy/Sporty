import 'package:flutter/material.dart';
import 'package:sporty/helper/helper.dart';

class SettingsScreen extends StatelessWidget {
  static String id = "settings_screen";
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: const Color(0xFF121212),
      width: size.width,
      height: size.height,
      child: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(
            right: 20.0, left: 20.0, top: 40.0, bottom: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Profile',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                )),
            YMargin(25),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                  primary: const Color(0xFF48484A),
                  padding:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Change Password',
                    style: TextStyle(fontSize: 17, color: Colors.orange),
                  ),
                  Icon(Icons.arrow_forward_ios, color: Colors.white)
                ],
              ),
            ),
            YMargin(15),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                  primary: const Color(0xFF48484A),
                  padding:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Update Email',
                    style: TextStyle(fontSize: 17, color: Colors.orange),
                  ),
                  Icon(Icons.arrow_forward_ios, color: Colors.white)
                ],
              ),
            ),
            YMargin(15),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                  primary: const Color(0xFF48484A),
                  padding:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Update Username',
                    style: TextStyle(fontSize: 17, color: Colors.orange),
                  ),
                  Icon(Icons.arrow_forward_ios, color: Colors.white)
                ],
              ),
            ),
            YMargin(15),
            Container(
              width: size.width,
              color: Colors.orange,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 25, horizontal: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                child: Text(
                  'Logout',
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

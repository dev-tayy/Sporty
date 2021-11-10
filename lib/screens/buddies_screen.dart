import 'package:flutter/material.dart';

class BuddiesScreen extends StatelessWidget {
  static String id = "buddies_screen";
  const BuddiesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: const Color(0xFF121212),
      width: size.width,
      height: size.height,
    );
  }
}

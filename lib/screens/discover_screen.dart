import 'package:flutter/material.dart';

class DiscoverScreen extends StatelessWidget {
    static String id = "discover_screen";
  const DiscoverScreen({Key? key}) : super(key: key);

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
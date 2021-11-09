import 'package:flutter/material.dart';
import 'package:sporty/helper/helper.dart';

class ProfileScreen extends StatelessWidget {
  static String id = 'profile_screen';
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        width: size.width,
        height: size.height,
        color: const Color(0xFF121212),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                        border: Border.all(width: 1, color: Colors.orange)),
                    child: Container(
                      height: 100,
                      width: 100,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image(
                          image: NetworkImage(
                              'https://cdn.pixabay.com/photo/2019/03/30/10/05/man-4090877_960_720.png')),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'username',
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                YMargin(10),
                Container(
                  width: size.width,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  decoration: BoxDecoration(
                      color: const Color(0xFF48484A),
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Phone Number',
                          style: TextStyle(fontSize: 14, color: Colors.white)),
                      YMargin(3),
                      Text('07063640670',
                          style: TextStyle(fontSize: 16, color: Colors.orange)),
                    ],
                  ),
                ),
                YMargin(10),
                Container(
                  width: size.width,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  decoration: BoxDecoration(
                      color: const Color(0xFF48484A),
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Email Address',
                          style: TextStyle(fontSize: 14, color: Colors.white)),
                      YMargin(3),
                      Text('ytjani@gmail.com',
                          style: TextStyle(fontSize: 16, color: Colors.orange)),
                    ],
                  ),
                ),
                YMargin(10),
                Container(
                  width: size.width,
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  decoration: BoxDecoration(
                      color: const Color(0xFF48484A),
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Interests',
                          style: TextStyle(fontSize: 14, color: Colors.white)),
                      YMargin(3),
                      Wrap(
                        spacing: 8,
                        children: [
                          InterestContainer(interest: 'BasketBall'),
                          InterestContainer(interest: 'Rugby'),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InterestContainer extends StatelessWidget {
  final String? interest;
  const InterestContainer({Key? key, this.interest})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      child: Text(interest ?? '',
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          )),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.orange,
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sporty/helper/helper.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sporty/models/user_model.dart';
import 'package:sporty/providers/profile_provider.dart';

class ProfileScreen extends StatelessWidget {
  static String id = 'profile_screen';

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<ProfileProvider>(
      builder: (context, model, child) {
        return FutureBuilder<UserModel>(
          future: model.getUserCredentials(context),
          initialData: UserModel(
              phoneNumber: '', email: '', interests: [], username: ''),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                    height: size.height,
                    width: size.width,
                    decoration: BoxDecoration(color: const Color(0xFF121212)),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ));
              }

              List<String> emptyInterests = [];

              return SafeArea(
                child: Container(
                  width: size.width,
                  height: size.height,
                  color: const Color(0xFF121212),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
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
                                  border: Border.all(
                                      width: 1, color: Colors.orange)),
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
                              snapshot.data!.username?.toUpperCase() ?? '',
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          YMargin(20),
                          Container(
                            width: size.width,
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            decoration: BoxDecoration(
                                color: const Color(0xFF48484A),
                                borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Phone Number',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.white)),
                                YMargin(3),
                                Text('${snapshot.data!.phoneNumber}',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.orange)),
                              ],
                            ),
                          ),
                          YMargin(20),
                          Container(
                            width: size.width,
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            decoration: BoxDecoration(
                                color: const Color(0xFF48484A),
                                borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Email Address',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.white)),
                                YMargin(3),
                                Text('${snapshot.data!.email}',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.orange)),
                              ],
                            ),
                          ),
                          YMargin(20),
                          Container(
                            width: size.width,
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            decoration: BoxDecoration(
                                color: const Color(0xFF48484A),
                                borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Interests',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.white)),
                                YMargin(3),
                                Wrap(
                                  spacing: 8,
                                  children: [
                                    for (var interest
                                        in snapshot.data!.interests ??
                                            emptyInterests)
                                      InterestContainer(interest: interest),
                                  ],
                                )
                              ],
                            ),
                          ),
                          YMargin(30),
                          Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(3),
                                alignment: Alignment.center,
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                primary: Colors.orange,
                              ),
                              child: Text('Sign out',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else {
              print(snapshot.error);
            }
            return SizedBox();
          },
        );
      },
    );
  }
}

class InterestContainer extends StatelessWidget {
  final String? interest;
  const InterestContainer({Key? key, this.interest}) : super(key: key);

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


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sporty/helper/helper.dart';
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
                            child: Stack(
                              children: [
                                Container(
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
                                    child: model.images.isNotEmpty
                                        ? Image(
                                            image: FileImage(model.images.last),
                                            fit: BoxFit.cover,
                                          )
                                        : Image(
                                            image: AssetImage(
                                                'assets/images/welcome_screen.jpg'),
                                            fit: BoxFit.cover),
                                  ),
                                ),
                                Positioned(
                                  top: 90,
                                  left: 80,
                                  child: GestureDetector(
                                    onTap: () {
                                      model.getImage(context).then((value) {
                                        return model.updateProfilePicture(
                                            context, value.last);
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          color: Colors.orange,
                                          shape: BoxShape.circle),
                                      child: Icon(Icons.add_a_photo,
                                          color: Colors.white, size: 15),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          YMargin(10),
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
                                  runSpacing: 5,
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

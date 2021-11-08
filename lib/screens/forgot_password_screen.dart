//@=dart2.7
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:sporty/services/navigation_service.dart';
import 'package:sporty/helper/helper.dart';
import 'package:sporty/utils/validator.dart';
import 'package:provider/provider.dart';
import 'package:sporty/providers/reset_password_provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static String id = "forgot_password_screen";
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: ProgressHUD(
        child: Form(
          key: _formKey,
          child: Stack(children: [
            Container(
              width: size.width,
              height: size.height,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: size.width,
                      height: size.height,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/welcome_screen.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                        child: Container(
                          decoration:
                              BoxDecoration(color: Colors.white.withOpacity(0.0)),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: size.width * 0.85,
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: SingleChildScrollView(
                        child: Center(
                          child: Consumer<ResetPasswordProvider>(
                            builder: (context, model, child) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                // SizedBox(height: size.height * 0.08),
                                Center(
                                  child: Text(
                                    "Reset Password",
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
              
                                YMargin(15),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                      '  A verification code would be sent to your email address.',
                                      style: TextStyle(
                                          fontSize: 11,
                                          fontStyle: FontStyle.italic)),
                                ),
                                SizedBox(height: size.height * 0.01),
                                TextFormField(
                                  validator: (value) =>
                                      Validator.validateEmail(value ?? ""),
                                  controller: model.emailController,
                                  decoration: InputDecoration(
                                    hintText: "Email",
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
              
                                YMargin(30),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if(_formKey.currentState!.validate())
                                          model.resetPassword(context);
                                          model.emailController.text = '';
                                        },
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.indigo,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 40, vertical: 15)),
                                        child: Text(
                                          "Reset Password",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

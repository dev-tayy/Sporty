//@=dart2.7
import 'dart:ui';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:flutter_progress_hud/flutter_progress_hud.dart";
import "package:sporty/providers/register_provider.dart";
import 'package:sporty/utils/validator.dart';

class RegisterScreen extends StatefulWidget {
  static String id = "register_screen";
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<String>? options = [
    "Football",
    "BasketBall",
    "Ice Hockey",
    "MotorSpot",
    "Skiing",
    "Rugby",
  ];

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
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.0)),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: size.width * 0.85,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: SingleChildScrollView(
                        child: Consumer<RegisterProvider>(
                          builder: (context, model, child) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              //   SizedBox(height: size.height * 0.08),
                              Center(
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: size.height * 0.05),
                              TextFormField(
                                validator: (value) =>
                                    Validator.validateName(value ?? ""),
                                controller: model.usernameController,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  hintText: "Username",
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              SizedBox(height: size.height * 0.03),
                              TextFormField(
                                validator: (value) =>
                                    Validator.validateEmail(value ?? ""),
                                controller: model.emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              SizedBox(height: size.height * 0.03),
                              TextFormField(
                                obscureText: true,
                                validator: (value) =>
                                    Validator.validatePassword(value ?? ""),
                                controller: model.passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              SizedBox(height: size.height * 0.03),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                controller: model.phoneNumberController,
                                maxLength: 11,
                                validator: (value) =>
                                    Validator.validatePhoneNumber(value ?? ""),
                                decoration: InputDecoration(
                                  hintText: "Phone Number",
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              // Text(
                              //     '  A verification code would be sent to your phone.',
                              //     style: TextStyle(
                              //         fontSize: 10,
                              //         fontStyle: FontStyle.italic)),
                              SizedBox(height: size.height * 0.02),
                              Text('Select your interests',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w500)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FormField<List<String>>(
                                    autovalidate: true,
                                    initialValue: model.interests,
                                    onSaved: (val) =>
                                        setState(() => model.interests = val),
                                    validator: (value) {
                                      if (value?.isEmpty ?? value == null) {
                                        return 'Please select some interests';
                                      }
                                      if (value!.length > 5) {
                                        return "Can't select more than 5 interests";
                                      }
                                      if (value.length < 3) {
                                        return "Please select more than 1 interests";
                                      }
                                      return null;
                                    },
                                    builder: (state) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: ChipsChoice<String>.multiple(
                                              value: state.value,
                                              onChanged: (val) =>
                                                  state.didChange(val),
                                              choiceItems: C2Choice.listFrom<
                                                  String, String>(
                                                source: options,
                                                value: (i, v) =>
                                                    v.toLowerCase(),
                                                label: (i, v) => v,
                                                tooltip: (i, v) => v,
                                              ),
                                              choiceStyle: const C2ChoiceStyle(
                                                color: Colors.indigo,
                                                borderOpacity: .3,
                                                padding:
                                                    const EdgeInsets.all(0),
                                              ),
                                              choiceActiveStyle:
                                                  const C2ChoiceStyle(
                                                color: Colors.indigo,
                                                brightness: Brightness.dark,
                                                padding:
                                                    const EdgeInsets.all(0),
                                              ),
                                              wrapped: true,
                                            ),
                                          ),
                                          state.hasError
                                              ? Text(
                                                  '${state.errorText}', style: TextStyle(color: Colors.red))
                                              : SizedBox()
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: size.height * 0.03),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          model.registerUsers(context);
                                        }
                                        // model.passwordController.text = "";
                                      },
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.indigo,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 40, vertical: 15)),
                                      child: Text(
                                        "Register",
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
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:sporty/helper/helper.dart';
import 'package:sporty/providers/settings_provider.dart';
import 'package:sporty/utils/validator.dart';

class SettingsScreen extends StatelessWidget {
  static String id = "settings_screen";
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ProgressHUD(
      child: Container(
        color: const Color(0xFF121212),
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(
              right: 20.0, left: 20.0, top: 40.0, bottom: 20.0),
          child: Consumer<SettingsProvider>(builder: (context, model, child) {
            return Column(
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
                  onPressed: () async {
                    await showChangePasswordDialog(
                        context: context, message: 'Change Password');
                  },
                  style: TextButton.styleFrom(
                      primary: const Color(0xFF48484A),
                      padding: const EdgeInsets.symmetric(
                          vertical: 25, horizontal: 20),
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
                  onPressed: () async {
                    await showInfoDialog(
                      context: context,
                      message: 'Update Email',
                      hintText: 'New Email',
                      label: 'Email',
                    );
                  },
                  style: TextButton.styleFrom(
                      primary: const Color(0xFF48484A),
                      padding: const EdgeInsets.symmetric(
                          vertical: 25, horizontal: 20),
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
                  onPressed: () async {
                    await showInfoDialog(
                      context: context,
                      message: 'Update Username',
                      hintText: 'New Username',
                      label: 'Username',
                    );
                  },
                  style: TextButton.styleFrom(
                      primary: const Color(0xFF48484A),
                      padding: const EdgeInsets.symmetric(
                          vertical: 25, horizontal: 20),
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
                    onPressed: () {
                      model.signOut(context);
                    },
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
            );
          }),
        )),
      ),
    );
  }

  Future<void> showChangePasswordDialog(
      {required BuildContext context, String? message}) async {
    bool _showPassword = true;
    bool _isTapped = false;
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (_) => StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                backgroundColor: const Color(0xFF48484A),
                title: Container(
                  constraints: BoxConstraints(maxHeight: 180),
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  decoration: BoxDecoration(color: Colors.orange),
                  child: Text(message ?? "",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                ),
                titlePadding: EdgeInsets.all(0),
                actionsPadding: EdgeInsets.symmetric(horizontal: 10),
                content: Form(
                  key: _formKey,
                  child: Consumer<SettingsProvider>(
                      builder: (context, model, child) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextFormField(
                          validator: (value) =>
                              Validator.validatePassword(value ?? ""),
                          controller: model.passwordController,
                          obscureText: _showPassword,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                              child: Icon(
                                _showPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                            ),
                            hintText: "New Password",
                            focusColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange),
                                borderRadius: BorderRadius.circular(0)),
                            enabled: true,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(0)),
                            filled: true,
                            isDense: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(0)),
                          ),
                        ),
                        YMargin(15),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.orange,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              setState(() => _isTapped = true);
                              model.changePassword(
                                  context: context,
                                  newPassword: model.passwordController.text);
                              model.usernameController.clear();
                              model.emailController.clear();
                              model.passwordController.clear();
                              Navigator.pop(context);
                            }
                          },
                          child: Text(
                            _isTapped ? 'UPDATING' : 'UPDATE',
                            style: TextStyle(
                                color: Colors.white, letterSpacing: 1.3),
                          ),
                        )
                      ],
                    );
                  }),
                ),
              ),
            ));
  }
}

Future<void> showInfoDialog({
  required BuildContext context,
  required String message,
  required String hintText,
  required String? label,
}) async {
  bool _isTapped = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              backgroundColor: const Color(0xFF48484A),
              title: Container(
                constraints: BoxConstraints(maxHeight: 180),
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                decoration: BoxDecoration(color: Colors.orange),
                child: Text(message,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              ),
              titlePadding: EdgeInsets.all(0),
              actionsPadding: EdgeInsets.symmetric(horizontal: 10),
              content: Form(
                key: _formKey,
                child: Consumer<SettingsProvider>(
                    builder: (context, model, child) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        validator: (value) => label == 'Email'
                            ? Validator.validateEmail(value ?? "")
                            : Validator.validateName(value ?? ""),
                        controller: label == 'Email'
                            ? model.emailController
                            : model.usernameController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: hintText,
                          focusColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange),
                              borderRadius: BorderRadius.circular(0)),
                          enabled: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(0)),
                          filled: true,
                          isDense: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(0)),
                        ),
                      ),
                      YMargin(15),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orange,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        onPressed: () async {
                          print(_formKey.currentState!.validate());
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            setState(() => _isTapped = true);
                            label == "Email"
                                ? await model.updateEmail(
                                    context: context,
                                    newEmail: model.emailController.text)
                                : await model.updateUsername(
                                    context: context,
                                    newUsername: model.usernameController.text);
                            model.usernameController.clear();
                            model.emailController.clear();
                            model.passwordController.clear();
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          _isTapped ? 'UPDATING' : 'UPDATE',
                          style: TextStyle(
                              color: Colors.white, letterSpacing: 1.3),
                        ),
                      )
                    ],
                  );
                }),
              ),
            ),
          ));
}

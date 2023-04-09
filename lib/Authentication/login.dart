// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import '/Screen/home.dart';
import '/Widgets/color.dart';

// import 'package:e_shop/Admin/adminLogin.dart';
import '../Widgets/customTextField.dart';
import '../DialogBox/errorDialog.dart';
import '../DialogBox/loadingDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import '../Store/storehome.dart';
import '../Config/config.dart';
import '../main.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailtextEditingController =
      TextEditingController();
  final TextEditingController _passwordtextEditingController =
      TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double _screenwidth = MediaQuery.of(context).size.width,
        _screenheight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                "images/login.png",
                height: 200.0,
                width: 200.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
               "Login to your account",
                style: TextStyle(color: valhalla, fontWeight: FontWeight.bold),
              ),
            ),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: _emailtextEditingController,
                    data: Icons.email,
                    hintText: "Email",
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _passwordtextEditingController,
                    data: Icons.vpn_key,
                    hintText: "Password",
                    isObsecure: true,
                  ),
                ],
              ),
            ),
            Container(
              width: _screenwidth - 100.0,
              decoration: BoxDecoration(
                  color: tyrianPurple,
                  borderRadius: BorderRadius.circular(10.0)),
              child: TextButton(
                onPressed: () {
                  _emailtextEditingController.text.isNotEmpty &&
                          _passwordtextEditingController.text.isNotEmpty
                      ? loginUser()
                      : showDialog(
                          context: context,
                          builder: (c) {
                            return const ErrorAlertDialog(
                              message: "Please Enter Correct Details",
                            );
                          });
                  print(EcommerceApp.sharedPreferences
                      .getString(EcommerceApp.userName));
                  print(EcommerceApp.sharedPreferences
                      .getString(EcommerceApp.userEmail));
                  print(EcommerceApp.sharedPreferences
                      .getString(EcommerceApp.userUID));
                  print(EcommerceApp.sharedPreferences
                      .getString(EcommerceApp.userpassword));
                },
                child: Text(
                 "Sign In",
                  style: TextStyle(
                      color: white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Container(
              height: 4.0,
              width: _screenwidth * 0.8,
              color: tyrianPurple,
            ),
            const SizedBox(
              height: 15.0,
            ),
          ],
        ),
      ),
    );
  }

  
  loginUser() async {
    var a = await FirebaseFirestore.instance
        .collection("Users")
        .doc(_emailtextEditingController.text)
        .get();

    var b = a.data();

    if (a.data == null) {
      showDialog(
          context: context,
          builder: (c) {
            return const ErrorAlertDialog(
              message: "Please Enter Correct Details",
            );
          });
    } else if (_emailtextEditingController.text != b!['email']) {
      showDialog(
          context: context,
          builder: (c) {
            return const ErrorAlertDialog(
              message: "Please Enter Correct Email",
            );
          });
    } else if (_passwordtextEditingController.text != b['password']) {
      showDialog(
          context: context,
          builder: (c) {
            return const ErrorAlertDialog(
              message: "Please Enter Correct Password",
            );
          });
    } else {
      setState(() {
        _emailtextEditingController.text = "";
        _passwordtextEditingController.text = "";
        EcommerceApp.sharedPreferences
            .setString(EcommerceApp.userUID, b['uid']);
        EcommerceApp.sharedPreferences
            .setString(EcommerceApp.userEmail, b['email']);
        EcommerceApp.sharedPreferences
            .setString(EcommerceApp.userName, b['User Name']);
        EcommerceApp.sharedPreferences
            .setString(EcommerceApp.userpassword, b['password']);
        EcommerceApp.sharedPreferences
            .setString(EcommerceApp.language, "English");
      });

      Route route = MaterialPageRoute(builder: (c) => HomeScreen());
      Navigator.pushReplacement(context, route);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Signed In successfully"),
      ));
    }
    
}
}
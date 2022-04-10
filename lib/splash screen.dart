import 'dart:async';

import 'package:crypo_app/Pages/Home%20Page.dart';
import 'package:crypo_app/signin&signup/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:crypo_app/utils/color.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  //
  Future<void> usercheck() async {
    final _user = FirebaseAuth.instance.currentUser;
    if (_user != null) {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => HomePage()), (route) => false);
    } else {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => LoginPage()), (route) => false);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 2), () {
      usercheck();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            color1,
            color2.withOpacity(0.9),
          ], begin: FractionalOffset(0, 0.4), end: Alignment.topRight),
        ),
        child: Center(
          child: Image.asset(
            "assets/logo.png",
          ),
        ),
      ),
    );
  }
}

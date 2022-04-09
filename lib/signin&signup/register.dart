import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypo_app/signin&signup/Login.dart';
import 'package:crypo_app/signin&signup/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Pages/Home Page.dart';
import '../utils/color.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  //
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  //
  //signup

  Future signupfunction({name, email, phone, pass}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);
      var userid = FirebaseAuth.instance.currentUser!.uid;
      users
          .doc("${userid}")
          .set({
            "userid": userid,
            "name": name,
            "email": email,
            "phone": int.parse(phone),
            "password": pass,
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"))
          .then((value) {
            setState(() {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => HomePage()),
                  (route) => false);
            });
          });

      //
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  // Future Testingfunction() async {
  //   _firestore
  //       .collection('users')
  //       .add({
  //         'full_name': "shiva", // John Doe
  //         'company': "susi empire", // Stokes and Sons
  //         'age': 19 // 42
  //       })
  //       .then((value) => print("User Added"))
  //       .catchError((error) => print("Failed to add user: $error"));
  // }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: _height * 0.4,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [orangeColors, orangeLightColors],
                            end: Alignment.bottomCenter,
                            begin: Alignment.topCenter),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(100))),
                  ),
                  Image.asset("assets/logo.png"),
                  const Positioned(
                      bottom: 20,
                      right: 20,
                      child: Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ],
              ), //header container
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    textBox(
                        hint: "Fullname",
                        icon: Icons.person,
                        Controller: _nameController),
                    textBox(
                        hint: "Email",
                        keybord: TextInputType.emailAddress,
                        icon: Icons.email,
                        Controller: _emailController),
                    textBox(
                        hint: "Phone number",
                        icon: Icons.call,
                        Controller: _phoneController),
                    textBox(
                        hint: "Password",
                        icon: Icons.vpn_key_sharp,
                        Controller: _passController),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Container(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          "Forget password ?",
                          style:
                              TextStyle(fontSize: 15, color: Colors.grey[700]),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        if (_formkey.currentState!.validate()) {
                          signupfunction(
                              name: _nameController.text.toString(),
                              email: _emailController.text.toString(),
                              phone: _phoneController.text.toString(),
                              pass: _passController.text.toString());
                          // Testingfunction();
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [orangeColors, orangeLightColors],
                              end: Alignment.centerLeft,
                              begin: Alignment.centerRight),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(100),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "Register",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (_) => LoginPage()),
                                (route) => false);
                          });
                        },
                        child: RichText(
                          text: TextSpan(children: [
                            const TextSpan(
                                text: "Already a member ? ",
                                style: TextStyle(color: Colors.black)),
                            TextSpan(
                                text: "Login",
                                style: TextStyle(color: orangeColors)),
                          ]),
                        ),
                      ),
                    ), //forget password
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container textBox({Controller, hint, icon, keybord}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: const BoxDecoration(
        boxShadow: [
          // color: Colors.white, //background color of box
          BoxShadow(
            color: Colors.grey,
            blurRadius: 1.0, // soften the shadow
            spreadRadius: 1.0, //extend the shadow
            offset: Offset(
              2.0, // Move to right 10  horizontally
              2.0, // Move to bottom 10 Vertically
            ),
          )
        ],
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      padding: EdgeInsets.only(left: 10),
      child: TextFormField(
        keyboardType: keybord,
        validator: (value) {
          if (value!.isEmpty) {
            return "* Required";
          } else
            return null;
        },
        controller: Controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }
}

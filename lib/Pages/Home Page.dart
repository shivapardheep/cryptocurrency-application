import 'package:crypo_app/signin&signup/Login.dart';
import 'package:crypo_app/utils/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //sign out
  Future<void> signout() async {
    await FirebaseAuth.instance.signOut().then((value) =>
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => LoginPage()), (route) => false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          orangeColors,
          orangeLightColors,
        ])),
        child: Column(
          children: [
            Container(
              height: 300,
            ),
            Expanded(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(70),
                    topLeft: Radius.circular(70),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                  child: Column(
                    children: [
                      Card(
                        shadowColor: Colors.grey,
                        child: ListTile(
                          leading: const CircleAvatar(
                            backgroundImage: AssetImage(
                                "assets/flags/United_States_of_America.png"),
                          ),
                          title: const Center(
                            child: Text(
                              "USA",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          trailing: InkWell(
                            onTap: () {},
                            child: Ink(
                              height: 30,
                              width: 60,
                              child: Row(
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Text(
                                      "view",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Icon(
                                    Icons.navigate_next,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

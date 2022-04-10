import 'dart:convert';

import 'package:crypo_app/Pages/drawer%20page.dart';
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

//
  double xvalue = 0.0;
  double yvvalue = 0.0;
  double scalevalue = 1;
  bool checkdrawer = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DrawerPage(),
        AnimatedContainer(
          duration: Duration(milliseconds: 500),
          transform: Matrix4.translationValues(xvalue, yvvalue, 0)
            ..scale(scalevalue),
          child: ClipRRect(
            borderRadius: checkdrawer
                ? BorderRadius.circular(20)
                : BorderRadius.circular(0),
            child: Scaffold(
              body: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  color1.withOpacity(0.9),
                  color2.withOpacity(0.9),
                ], begin: FractionalOffset(0, 0.4), end: Alignment.topRight)),
                child: SafeArea(
                  child: Column(
                    children: [
                      Container(
                        height: 300,
                        decoration: const BoxDecoration(),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20,
                                right: 20,
                                top: 10,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        Drawer();
                                      });
                                    },
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          print("clicked");
                                          checkdrawer = !checkdrawer;
                                          if (checkdrawer == true) {
                                            xvalue = 200;
                                            yvvalue = 120;
                                            scalevalue = 0.78;
                                          } else {
                                            xvalue = 0.0;
                                            yvvalue = 0.0;
                                            scalevalue = 1;
                                          }
                                        });
                                      },
                                      child: Ink(
                                        height: 20,
                                        width: 20,
                                        child: const Image(
                                          image: AssetImage("assets/menu.png"),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 20,
                                    width: 20,
                                    child: const Image(
                                      image: AssetImage("assets/info.png"),
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Image(
                              image: AssetImage("assets/homeimage.png"),
                              // height: 50,
                              width: 280,
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                height: 40,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: Colors.pink,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: const [
                                      Text(
                                        "Define Crypto",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Icon(
                                        Icons.show_chart,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text(
                                      "Crypto Approved Countries",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[700],
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 10,
                                  child: Container(
                                    child: FutureBuilder(
                                        future: DefaultAssetBundle.of(context)
                                            .loadString("assets/mapdata.json"),
                                        builder: (context, snapshot) {
                                          var data = jsonDecode(
                                              snapshot.data.toString());
                                          return ListView.builder(
                                              itemCount: data == null
                                                  ? 0
                                                  : data.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int i) {
                                                return Card(
                                                  shadowColor: Colors.grey,
                                                  child: ListTile(
                                                    leading: CircleAvatar(
                                                      backgroundImage: AssetImage(
                                                          "${data[i]['flag']}"),
                                                    ),
                                                    title: Center(
                                                      child: Text(
                                                        "${data[i]['country']}",
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
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
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 5),
                                                              child: Text(
                                                                "view",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                            Icon(
                                                              Icons
                                                                  .navigate_next,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ],
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.blue,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            1),
                                                  ),
                                                );
                                              });
                                        }),
                                    // color: Colors.green,
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
              ),
            ),
          ),
        ),
      ],
    );
  }
}

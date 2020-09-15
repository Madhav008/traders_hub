import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trades_club/animations/FadeAnimation.dart';
import 'package:trades_club/controllers/authentication/authentications.dart';
import 'package:trades_club/database_screen/traders_screen.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/background.jpg'),
                          fit: BoxFit.fill)),
                  child: Stack(
                    children: <Widget>[
                      // Positioned(
                      //   left: 30,
                      //   width: 80,
                      //   height: 200,
                      //   child: FadeAnimation(
                      //       1,
                      //       Container(
                      //         decoration: BoxDecoration(
                      //             image: DecorationImage(
                      //                 image: AssetImage('images/lamp-1.jpg'))),
                      //       )),
                      // ),
                      // Positioned(
                      //   left: 140,
                      //   width: 80,
                      //   height: 150,
                      //   child: FadeAnimation(
                      //       1.3,
                      //       Container(
                      //         decoration: BoxDecoration(
                      //             image: DecorationImage(
                      //                 image: AssetImage('images/lamp-2.jpg'))),
                      //       )),
                      // ),
                      // Positioned(
                      //   right: 40,
                      //   top: 40,
                      //   width: 80,
                      //   height: 150,
                      //   child: FadeAnimation(
                      //       1.5,
                      //       Container(
                      //         decoration: BoxDecoration(
                      //             image: DecorationImage(
                      //                 image: AssetImage('images/clock.jpg'))),
                      //       )),
                      // ),
                      Positioned(
                        
                        child: FadeAnimation(
                            1.6,
                            Container(
                              margin: EdgeInsets.only(top: 50),
                              child: Center(
                                child: Text(
                                  "Traders Hub",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(
                          1.8,
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(143, 148, 251, .2),
                                      blurRadius: 20.0,
                                      offset: Offset(0, 10))
                                ]),
                          )),
                      FadeAnimation(
                          2,
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isLoading = true;
                              });
                              login();
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(colors: [
                                    Color.fromRGBO(143, 148, 251, 1),
                                    Color.fromRGBO(143, 148, 251, .6),
                                  ])),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset('images/google.png'),
                                    ),

                                    Text(
                                      "LOGIN WITH GOOGLE ",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 70,
                      ),
                      (isLoading == true)
                          ? CircularProgressIndicator()
                          : SizedBox(
                              height: 1,
                            )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void login() {
    AuthService().googleSignIn().whenComplete(
      () async {
        FirebaseUser user = await FirebaseAuth.instance.currentUser();

        isLoading = false;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => TradersScrenn(
              id: user.uid,
            ),
          ),
        );
      },
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trades_club/provider/url.dart';
import 'package:trades_club/screen/data_screen/splash_screen.dart';

import 'controllers/authentication/login.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: ProvideUrl(),
          child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
        primarySwatch: Colors.purple, textSelectionColor: Colors.amber),
          home: FutureBuilder<FirebaseUser>(
            future: FirebaseAuth.instance.currentUser(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
          FirebaseUser user = snapshot.data;
          return SplashScreen(id: user.uid);
        } else {
          return LoginScreen();
        }
            }
          ),
        ),
    );
  }
}

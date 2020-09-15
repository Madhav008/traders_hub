import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import 'package:trades_club/database_screen/traders_screen.dart';
import 'package:trades_club/provider/url.dart';

// ignore: must_be_immutable
class SplashScreen extends StatefulWidget {
  String id;
  SplashScreen({this.id});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => TradersScrenn(id: widget.id),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
        Provider.of<ProvideUrl>(context, listen: true).fetchAndSetProducts();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Image.asset('images/traders_hub.jpg'),
                height: 300,
                width: 300,
              ),
            ),
            Text(
              'Traders Hub',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            CircularProgressIndicator(
              
            ),
          ],
        ),
      ),
    );
  }
}

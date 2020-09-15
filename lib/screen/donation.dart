import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Donation extends StatefulWidget {
  @override
  _DonationState createState() => _DonationState();
}

class _DonationState extends State<Donation> {

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'header_key': 'header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Color.fromRGBO(143, 148, 251, 1),
                Color.fromRGBO(143, 148, 251, .6),
              ])),
        ),
        centerTitle: true,
        title: Text(
          "Donate Now",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
              Color.fromRGBO(143, 148, 251, 1),
              Color.fromRGBO(143, 148, 251, .6),
            ])),
        child: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(height: 40,),            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
              "Hii Hope You Like Our App If You Like It\nPlease Share It With Your Friends And\nHelp Us By Donating As We Are Providing \nFOREX Signals For Free ",style: TextStyle(fontSize: 20,color: Colors.greenAccent,fontWeight: FontWeight.bold),
          ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
              "This App Is Build By Aditya And Hari\nContact Us At Whatsapp \n+918894170070",style: TextStyle(fontSize: 20,color: Colors.yellow,fontWeight: FontWeight.bold),
          ),
            ),
            Spacer(),
            Material(
              color: Colors.white,
              elevation: 14.0,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0),
              ),
              shadowColor: Color(0x802196f3),
              child: _build(),
            ),
          ],
        )),
      ),
    );
  }

  Widget _build() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 300.0,
        child: Column(
          children: <Widget>[
            _titlecontainer(),
            _donate(),
          ],
        ),
      ),
    );
  }

  Widget _titlecontainer() {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 25.0, left: 20.0, right: 20,bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                "Traders Hub",
                style: TextStyle(
                  color: Colors.purple[900],
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _donate() {
    return Padding(
      padding: EdgeInsets.only(top: 75.0, left: 20.0, bottom: 10.0, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              _launchInBrowser('https://paypal.me/Adishield?locale.x=en_GB');
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
                    Image.asset(
                      'images/paypal.png',
                    ),
                    Text(
                      "Donate  ",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:trades_club/controllers/authentication/authentications.dart';
import 'package:trades_club/controllers/authentication/login.dart';
import 'package:trades_club/database_screen/SelectionScreen.dart';
import 'package:trades_club/database_screen/traders_screen.dart';
import 'package:trades_club/screen/donation.dart';
import 'package:trades_club/screen/info.dart';
import 'package:trades_club/screen/profile.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class CustomDrawer extends StatefulWidget {
  String uid;
  CustomDrawer(this.uid);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String _launchUrl = 'https://t.me/traders_hubs';

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
    return StreamBuilder(
      stream:
          // ignore: deprecated_member_use
          Firestore.instance
              .collection('users')
              .document(widget.uid)
              .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Drawer(
            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: <Color>[
                    Color.fromRGBO(143, 148, 251, 1),
                    Color.fromRGBO(143, 148, 251, .6),
                  ])),
                  accountEmail: (snapshot.data['email'] == null)
                      ? Text("Hii ")
                      : Text(
                          snapshot.data['email'],
                          style: TextStyle(color: Colors.black),
                        ),
                  accountName: (snapshot.data['name'] == null)
                      ? Text(
                          ' ',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        )
                      : Text(
                          snapshot.data['name'],
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                  currentAccountPicture: ClipRRect(
                    borderRadius: BorderRadius.circular(70),
                    child: (snapshot.data['image'] != null)
                        ? Image(
                            image: NetworkImage(snapshot.data['image']),
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          )
                        : Container(),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TradersScrenn(id: widget.uid),
                        ));
                  },
                  title: Text("Home"),
                  leading: Icon(
                    EvaIcons.homeOutline,
                    color: Color.fromRGBO(143, 148, 251, 1),
                  ),
                ),
                ListTile(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(),
                      )),
                  title: Text("Account"),
                  leading: Icon(EvaIcons.personOutline,
                      color: Color.fromRGBO(143, 148, 251, 1)),
                ),
                ListTile(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Donation(),
                      )),
                  title: Text("Donation"),
                  leading: Icon(Icons.monetization_on,
                      color: Color.fromRGBO(143, 148, 251, 1)),
                ),
                ListTile(
                    leading: Icon(Icons.share,
                        color: Color.fromRGBO(143, 148, 251, 1)),
                    title: Text("Join The Telegram"),
                    onTap: () {
                      setState(
                        () {
                          _launchInBrowser(_launchUrl);
                        },
                      );
                    }),
              
                ListTile(
                    leading: Icon(Icons.info,
                        color: Color.fromRGBO(143, 148, 251, 1)),
                    title: Text("Guidelines"),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InformationPage(),
                          ));
                    }),
                (snapshot.data['admin'] == true)
                    ? ListTile(
                        title: Text("Add Trader"),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AdminPage(),
                            )),
                        leading: Icon(EvaIcons.bulbOutline,
                            color: Color.fromRGBO(143, 148, 251, 1)),
                      )
                    : ListTile(
                        onTap: () => AuthService().signOutUser().then((value) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                              (Route<dynamic> route) => false);
                        }),
                        title: Text("LogOut"),
                        leading: Icon(EvaIcons.logOut,
                            color: Color.fromRGBO(143, 148, 251, 1)),
                      ),
                SizedBox(height: 20),
              ],
            ),
          );
        } else {
          return LinearProgressIndicator();
        }
      },
    );
  }
}

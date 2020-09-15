import 'package:flutter/material.dart';
import 'package:trades_club/screen/data_screen/first.dart';

import 'package:trades_club/screen/data_screen/second.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  String url;
  String uid;
  HomeScreen({this.uid, this.url});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
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
            title: Text("TRADERS HUB"),
            bottom: TabBar(
              indicatorColor: Colors.grey[200],
              indicatorWeight: 5.0,
              isScrollable: false,
              tabs: [
                Container(
                  child: Tab(
                    child: Text(
                      "Signals",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Container(
                  child: Tab(
                    child: Text(
                      "Trades History",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              FirstScreen(
                uid: widget.uid,
                url: widget.url,
              ),
              SecondScreen(),
            ],
          ),
        ));
  }
}

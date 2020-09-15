import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:trades_club/bloc/closeTrades.dart';
import 'package:trades_club/bloc/opentrades.dart';
import 'package:trades_club/model/message.dart';
import 'package:trades_club/provider/url.dart';
import 'package:trades_club/screen/data_screen/home.dart';
import 'package:trades_club/widgets/drawer.dart';

// ignore: must_be_immutable
class TradersScrenn extends StatefulWidget {
  String id;
  TradersScrenn({this.id});
  int coins = 0;

  @override
  _TradersScrennState createState() => _TradersScrennState();
}

class _TradersScrennState extends State<TradersScrenn> {
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: <String>[],
    nonPersonalizedAds: true,
    childDirected: true,
    keywords: <String>[
      'Game',
      "trading"
      "Flutter",
      "Ipl",
      "cricket",
      "youtube",
      "faug",
    ],
  );


  BannerAd createBannerAd() {
    return BannerAd(
        adUnitId: "ca-app-pub-8095094030715762/4944961884",
        // adUnitId: BannerAd.testAdUnitId,
        //Change BannerAd adUnitId with Admob ID
        size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("BannerAd $event");
        });
  }

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
        adUnitId: "ca-app-pub-8095094030715762/6613266779",
        //Change Interstitial AdUnitId with Admob ID
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("IntersttialAd $event");
        });
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<Message> messages = [];
  RewardedVideoAd videoAd = RewardedVideoAd.instance;
  _getToken() async {
    _firebaseMessaging.getToken().then((token) async {
      print("Device Token: $token");
      var tok =
          await Firestore.instance.collection('DeviceIDToken').getDocuments();
      var value = tok.documents.map((e) => e.data.containsValue(token));

      if (!value.contains(true)) {
        Firestore.instance.collection('DeviceIDToken').add({
          "device_token": token,
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-8095094030715762~4102314199");
    //Change appId With Admob Id
    createBannerAd()
      ..load()
      ..show();

    super.initState();

    _getToken();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        final notification = message['notification'];
        setState(() {
          messages.add(Message(
              title: notification['title'], body: notification['body']));
        });
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");

        final notification = message['data'];
        setState(() {
          messages.add(Message(
            title: '${notification['title']}',
            body: '${notification['body']}',
          ));
        });
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ProvideUrl>(context, listen: true).fetchAndSetProducts();
    var ids = Provider.of<ProvideUrl>(context, listen: false).items;
    return Scaffold(
      appBar: buildAppBar(),
      drawer: CustomDrawer(widget.id),
      body: Container(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return ChangeNotifierProvider.value(
                value: ids[index],
                child: Consumer<DataUrl>(
                  builder: (context, productData, child) {
                    return GestureDetector(
                      onTap: () async {
                        var data = await Firestore.instance
                            .collection('url')
                            .getDocuments();
                        var uid = data.documents[index].documentID;
                        closeTradesbloc..getClose(productData.closeurl);
                        openTradesbloc..getMovies(productData.openurl);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(
                                  uid: uid, url: productData.openurl),
                            ));
                        createInterstitialAd()
                          ..load()
                          ..show();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 15,
                          shadowColor: Color.fromRGBO(143, 148, 251, 1),
                          child: StreamBuilder(
                              stream: Firestore.instance
                                  .collection('users')
                                  .document(widget.id)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListTile(
                                    title: Container(
                                        child: Text(
                                            "Master Trader ${index + 1}",
                                            style: GoogleFonts.lato(
                                                color: Colors.deepPurple,
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold))),
                                    leading: CircleAvatar(
                                      radius: 30,
                                      child: Image.asset("images/avatar.jpg"),
                                    ),
                                    trailing: Container(
                                      child: (snapshot.data['admin'] == true)
                                          ? IconButton(
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                              onPressed: () async {
                                                try {
                                                  await Provider.of<ProvideUrl>(
                                                          context,
                                                          listen: false)
                                                      .deleteProduct(
                                                          productData.id);
                                                } catch (error) {
                                                  print(error);
                                                }
                                              })
                                          : Container(
                                              child: Icon(
                                              Icons.euro_symbol,
                                              color: Colors.deepPurple,
                                            )),
                                    ),
                                  );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              }),
                        ),
                      ),
                    );
                  },
                ));
          },
          itemCount: ids.length,
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
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
        "TRADERS HUB",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

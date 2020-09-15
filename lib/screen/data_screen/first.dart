import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trades_club/bloc/opentrades.dart';
import 'package:trades_club/model/openorders.dart';

// ignore: must_be_immutable
class FirstScreen extends StatefulWidget {
  String uid;
  String url;
  FirstScreen({this.uid, this.url});
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    super.initState();
    openTradesbloc.getMovies(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<OpenOrders>(
      stream: openTradesbloc.subject.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return (snapshot.data.rows.length!=0)?_buildHomeWidget(snapshot.data):Center(child: Container(child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("No Active Signal ",style: TextStyle(color: Colors.purple,fontSize: 25,fontWeight: FontWeight.w400),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("You will be notified whenever a signal gets active ",style: TextStyle(color: Colors.purple[200],fontSize: 15,fontWeight: FontWeight.w400),),
              ),

            ],
          ),));
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 25.0,
          width: 25.0,
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
            strokeWidth: 4.0,
          ),
        )
      ],
    ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: $error"),
      ],
    ));
  }

  Widget _buildHomeWidget(OpenOrders data) {
    List<Rows> orders = data.rows;
    Firestore.instance
        .collection("url")
        .document(widget.uid)
        .updateData({"rows": orders.length});
    return ListView.builder(
      // ignore: missing_return
      itemBuilder: (context, index) {
        
          var date = orders[index].date;

          var pips = (orders[index].profit * 10) / (orders[index].volume * 100);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 120,
              child: Card(
                elevation: 15.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Stack(
                      children: [
                        Container(
                          child: (orders[index].icon == "sell")
                              ? Text(
                                  "SELL" + " -> " + orders[index].symbol,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                )
                              : Text(
                                  "BUY" + " -> " + orders[index].symbol,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ),
                        ),
                        Positioned(
                          right: 10,
                          child: Container(
                            child: Text("Running . . .",
                                style: GoogleFonts.lato(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple)),
                          ),
                        ),
                        Positioned(
                            top: 50,
                            child: Container(
                              child: Text(
                                date.toString(),
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                            )),
                        Positioned(
                          bottom: 1,
                          left: 0,
                          child: Container(
                            child: Text(
                              "Open Time -> " + orders[index].openTime,
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 1,
                          right: 0,
                          child: Container(
                            child: (pips > 0)
                                ? Text(
                                    "Pips -> " + (pips).round().toString(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green),
                                  )
                                : Text(
                                    "Pips -> " + (pips).round().toString(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        
      },
      itemCount: orders.length,
    );
  }
}

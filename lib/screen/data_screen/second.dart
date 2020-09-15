import 'package:flutter/material.dart';
import 'package:trades_club/bloc/closeTrades.dart';
import 'package:trades_club/model/closeorders.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CloseOrders>(
      stream: closeTradesbloc.subject.stream,
      builder: (context, AsyncSnapshot<CloseOrders> snapshot) {
        if (snapshot.hasData) {
          return _buildHomeWidget(snapshot.data);
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

  Widget _buildHomeWidget(CloseOrders data) {
    List<Rows> orders = data.rows;
    return ListView.builder(
      // ignore: missing_return
      itemBuilder: (context, index) {
        var pips = (orders[index].profit * 10) / (orders[index].volume * 100);
        var date = orders[index].date;
        if (orders[index].symbol == null) {
            orders.removeAt(index);
        } else {
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
                        Positioned(
                          top: 50,
                          right: 0,
                          child: Container(
                            child: Text(
                              orders[index].duration,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
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
                          child: Container(
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
                        ),
                        Positioned(
                          right: 100,
                          child: Container(
                            child: Text(
                              "Total     ",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 10,
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
                        Positioned(
                          bottom: 1,
                          left: 0,
                          child: Container(
                            child: Text(
                              "Open Time : " + orders[index].openTime,
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 1,
                          right: 0,
                          child: Container(
                            child: Text(
                              "Close Time :" + orders[index].closeTime,
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
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
        }
      },
      itemCount: orders.length,
    );
  }
}
//   }
// }

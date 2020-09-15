import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InformationPage extends StatelessWidget {
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
          "Guidelines",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
              child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                '1. Whenever any trade is opened by a master trade then you will get an notification. ',style: GoogleFonts.sourceSansPro(fontSize: 25,color: Colors.purple,fontWeight: FontWeight.w700))
          ),
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Text(
                '2. You can follow the signals as soon as a trade is opened and close it when the trade is  closed. ',style: GoogleFonts.sourceSansPro(fontSize: 25,color: Colors.purple,fontWeight: FontWeight.w700)),
         ),
         Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                '3. If a Trader open more than Two same trades Then Try To follow only One. ',style: GoogleFonts.sourceSansPro(fontSize: 25,color: Colors.purple,fontWeight: FontWeight.w700)),
          ),
          Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('4. Trade with Proper Risk Management.',style: GoogleFonts.sourceSansPro(fontSize: 25,color: Colors.purple,fontWeight: FontWeight.w700)),
        ),
         Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('5. All the Trades TimeZone is in (GMT +3) ',style: GoogleFonts.sourceSansPro(fontSize: 25,color: Colors.purple,fontWeight: FontWeight.w700)),
        ),
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Text(
                '6. Any problem Or Suggestions feel Free To contact Us on Our telegram Group.',style: GoogleFonts.sourceSansPro(fontSize: 25,color: Colors.purple,fontWeight: FontWeight.w700)),
         ),
        SizedBox(
          height: 70,
        ),]),
      ),
    );
  }
}

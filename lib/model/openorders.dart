// To parse this JSON data, do
//
//     final openOrders = openOrdersFromJson(jsonString);

import 'dart:convert';

OpenOrders openOrdersFromJson(String str) =>
    OpenOrders.fromJson(json.decode(str));

String openOrdersToJson(OpenOrders data) => json.encode(data.toJson());

class OpenOrders {
  OpenOrders({
    this.rows,
  });

  List<Rows> rows;

  factory OpenOrders.fromJson(Map<String, dynamic> json) => OpenOrders(
        rows: List<Rows>.from(json["rows"].map((x) => Rows.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "rows": List<dynamic>.from(rows.map((x) => x.toJson())),
      };
}

class Rows {
  Rows({
    this.icon,
    this.text,
    this.date,
    this.openTime,
    this.closeTime,
    this.duration,
    this.volume,
    this.symbol,
    this.profit,
    this.isTrade,
    this.currency,
  });

  String icon;
  String text;
  String date;
  String openTime;
  dynamic closeTime;
  String duration;
  double volume;
  String symbol;
  double profit;
  bool isTrade;
  String currency;

  factory Rows.fromJson(Map<String, dynamic> json) => Rows(
        icon: json["icon"],
        text: json["text"],
        date: json["date"],
        openTime: json["openTime"],
        closeTime: json["closeTime"],
        duration: json["duration"],
        volume: json["volume"].toDouble(),
        symbol: json["symbol"],
        profit: json["profit"].toDouble(),
        isTrade: json["isTrade"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
        "icon": icon,
        "text": text,
        "date":date,
        "openTime": openTime,
        "closeTime": closeTime,
        "duration": duration,
        "volume": volume,
        "symbol": symbol,
        "profit": profit,
        "isTrade": isTrade,
        "currency": currency,
      };
}

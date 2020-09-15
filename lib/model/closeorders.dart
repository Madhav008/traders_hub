// To parse this JSON data, do
//
//     final closeOrders = closeOrdersFromJson(jsonString);

import 'dart:convert';

CloseOrders closeOrdersFromJson(String str) => CloseOrders.fromJson(json.decode(str));

String closeOrdersToJson(CloseOrders data) => json.encode(data.toJson());

class CloseOrders {
    CloseOrders({
        this.rows,
    });

    List<Rows> rows;

    factory CloseOrders.fromJson(Map<String, dynamic> json) => CloseOrders(
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
    String closeTime;
    String duration;
    double volume;
    String symbol;
    double profit;
    bool isTrade;
    String currency;

    factory Rows.fromJson(Map<String, dynamic> json) => Rows(
        icon: json["icon"],
        text: json["text"],
        date: json["date"].toString(),
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
        "date": date,
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

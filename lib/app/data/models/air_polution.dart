// To parse this JSON data, do
//
//     final airPolution = airPolutionFromJson(jsonString);

import 'dart:convert';

List<AirPolution> airPolutionFromJson(String str) => List<AirPolution>.from(json.decode(str).map((x) => AirPolution.fromJson(x)));

String airPolutionToJson(List<AirPolution> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AirPolution {
    AirPolution({
        this.main,
        this.components,
        this.dt,
    });

    Main? main;
    Map<String, double>? components;
    int? dt;

    factory AirPolution.fromJson(Map<String, dynamic> json) => AirPolution(
        main: json["main"] == null ? null : Main.fromJson(json["main"]),
        components: Map.from(json["components"]!).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
        dt: json["dt"],
    );

    Map<String, dynamic> toJson() => {
        "main": main?.toJson(),
        "components": Map.from(components!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "dt": dt,
    };
}

class Main {
    Main({
        this.aqi,
    });

    int? aqi;

    factory Main.fromJson(Map<String, dynamic> json) => Main(
        aqi: json["aqi"],
    );

    Map<String, dynamic> toJson() => {
        "aqi": aqi,
    };
}

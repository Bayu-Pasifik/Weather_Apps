// To parse this JSON data, do
//
//     final nameCountry = nameCountryFromJson(jsonString);

import 'dart:convert';

NameCountry nameCountryFromJson(String str) =>
    NameCountry.fromJson(json.decode(str));

String nameCountryToJson(NameCountry data) => json.encode(data.toJson());

class NameCountry {
  NameCountry({
    this.name,
    this.localNames,
    this.lat,
    this.lon,
    this.country,
    this.state,
  });

  String? name;
  Map<String, String>? localNames;
  double? lat;
  double? lon;
  String? country;
  String? state;

  factory NameCountry.fromJson(Map<String, dynamic> json) => NameCountry(
        name: json["name"],
        localNames: json["local_names"] == null
            ? null
            : Map.from(json["local_names"]!)
                .map((k, v) => MapEntry<String, String>(k, v)),
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        country: json["country"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "local_names": Map.from(localNames!)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
        "lat": lat,
        "lon": lon,
        "country": country,
        "state": state,
      };
}

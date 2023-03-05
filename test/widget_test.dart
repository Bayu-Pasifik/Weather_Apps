import 'package:forecast_weather/app/data/models/air_polution.dart';
import 'package:forecast_weather/app/data/models/detailWeather.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  String apikey = "e89f7d4a30fc78da18fd06f35e47db8f";
  Uri url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/air_pollution/history?lat=-7.97718&lon=112.634&start=1677877591&end=1678311220&appid=$apikey');
  var response = await http.get(url);
  var data = json.decode(response.body)['list'];
  var tempdata = data.map((e) => AirPolution.fromJson(e)).toList();
  print("isi object class :  ${tempdata[0].components["co"]}");

  // var epoch = 1677877591;
  // var days = epoch + 432000;
  // var humantime = DateTime.fromMillisecondsSinceEpoch(days * 1000);
  // print(humantime);
}

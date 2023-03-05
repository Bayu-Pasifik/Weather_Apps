import 'package:forecast_weather/app/data/models/air_polution.dart';
import 'package:forecast_weather/app/data/models/detailWeather.dart';
import 'package:forecast_weather/app/data/models/next_weather.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailPageController extends GetxController {
  List<dynamic> place = [];
  Future<DetailWeather> detailWeather(String lat, String lon) async {
    String apikey = "e89f7d4a30fc78da18fd06f35e47db8f";
    Uri url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=$apikey');
    var response = await http.get(url);
    var data = json.decode(response.body);
    print("isi respon body $data");
    var tempdata = DetailWeather.fromJson(data);
    return tempdata;
  }

  List<dynamic> polution = [];

  Future<List<dynamic>> detailPolution(
      String lat, String lon, int start, int end) async {
    String apikey = "e89f7d4a30fc78da18fd06f35e47db8f";
    Uri url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/air_pollution/history?lat=$lat&lon=$lon&start=$start&end=$end&appid=$apikey');
    var response = await http.get(url);
    var data = json.decode(response.body)['list'];
    var tempdata = data.map((e) => AirPolution.fromJson(e)).toList();
    polution.addAll(tempdata);
    print("total polution ${polution.length}");
    print("isi list polution ${tempdata[0]}");
    return tempdata;
  }

  List<dynamic> nextweather = [];
  Future<List<dynamic>> nextWeather(String lat, String lon) async {
    String apikey = "e89f7d4a30fc78da18fd06f35e47db8f";
    Uri url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&units=metric&appid=$apikey');
    var response = await http.get(url);
    var data = json.decode(response.body)['list'];
    var tempdata = data.map((e) => NextWeather.fromJson(e)).toList();
    nextweather.addAll(tempdata);
    print("total nextweather ${nextweather.length}");
    print("isi list polution ${tempdata[0]}");
    return nextweather;
  }
}

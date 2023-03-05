import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:forecast_weather/app/data/models/nameCountry.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends GetxController {
  late TextEditingController searchC;
  RefreshController refreshController = RefreshController();
  List<dynamic> place = [];
  Future<List<dynamic>> countryName(String name) async {
    String apikey = "e89f7d4a30fc78da18fd06f35e47db8f";
    Uri url = Uri.parse(
        'http://api.openweathermap.org/geo/1.0/direct?q=$name&limit=5&appid=$apikey');
    var response = await http.get(url);
    var data = json.decode(response.body);
    var tempdata = data.map((e) => NameCountry.fromJson(e)).toList();
    update();
    place.addAll(tempdata);
    print("isi place $place");
    update();

    return place;
  }

  @override
  void onInit() {
    super.onInit();
    searchC = TextEditingController();
    searchC.text = '';
  }

  void refreshData() async {
    if (refreshController.initialRefresh != true) {
      await countryName(searchC.text);
      update();
      return refreshController.refreshCompleted();
    } else {
      return refreshController.refreshFailed();
    }
  }

  // void loadData() async {
  //   if (page <= totalPage) {
  //     hal.value = hal.value + 1;
  //     await getCurrent(hal.value);
  //     update();
  //     return nowPlayingRefresh.loadComplete();
  //   } else {
  //     return nowPlayingRefresh.loadNoData();
  //   }
  // }
}

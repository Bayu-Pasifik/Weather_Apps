import 'package:flutter/material.dart';
import 'package:forecast_weather/app/data/models/nameCountry.dart';
import 'package:forecast_weather/app/routes/app_pages.dart';

import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:weather_animation/weather_animation.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(children: [
        SizedBox(
          width: context.width,
          height: context.height,
          child: WeatherScene.weatherEvery.getWeather(),
        ),
        ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextField(
              controller: controller.searchC,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 10),
                      borderRadius: BorderRadius.all(Radius.circular(12)))),
            ),
            Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  onPressed: () {
                    controller.place.clear();
                    controller.countryName(controller.searchC.text);
                  },
                  child: const Text("Search"),
                )),
            const SizedBox(height: 20),
            GetBuilder<HomeController>(
              builder: (c) {
                return (c.place.isNotEmpty)
                    ? SizedBox(
                        width: 200,
                        height: context.height,
                        child: SmartRefresher(
                          enablePullDown: false,
                          controller: c.refreshController,
                          onRefresh: () => c.refreshData(),
                          child: (c.place != [] || c.place.isNotEmpty)
                              ? ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 10),
                                  itemCount: c.place.length,
                                  itemBuilder: (context, index) {
                                    NameCountry country = c.place[index];
                                    return GestureDetector(
                                        onTap: () {
                                          Get.toNamed(Routes.DETAIL_PAGE,
                                              arguments: country);
                                        },
                                        child: Material(
                                          elevation: 4,
                                          child: ListTile(
                                            title: Text("${country.name}"),
                                            subtitle: Text("${country.state}"),
                                          ),
                                        ));
                                  },
                                )
                              : const Center(
                                  child: Text("No data"),
                                ),
                        ),
                      )
                    : const Center(child: Text("No data"));
              },
            )
          ],
        ),
      ]),
    ));
  }
}

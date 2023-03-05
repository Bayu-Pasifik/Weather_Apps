import 'package:flutter/material.dart';
import 'package:forecast_weather/app/data/models/air_polution.dart';
import 'package:forecast_weather/app/data/models/detailWeather.dart';
import 'package:forecast_weather/app/data/models/nameCountry.dart';
import 'package:forecast_weather/app/data/models/next_weather.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:weather_animation/weather_animation.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';

import '../controllers/detail_page_controller.dart';

class DetailPageView extends GetView<DetailPageController> {
  const DetailPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final NameCountry nameCountry = Get.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text('${nameCountry.name}'),
          centerTitle: true,
          elevation: 0,
        ),
        body: SafeArea(
            child: FutureBuilder(
          future: controller.detailWeather(
              nameCountry.lat.toString(), nameCountry.lon.toString()),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            }
            DetailWeather detail = snapshot.data!;
            var epoch = 1677877591;
            var days = epoch + 432000;
            //var humantime = DateTime.fromMillisecondsSinceEpoch(days * 1000);
            return Stack(
              children: [
                (detail.weather![0].main == "Thunderstrom")
                    ? WeatherBg(
                        weatherType: WeatherType.thunder,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height)
                    : (detail.weather![0].main == "Drizzle")
                        ? WeatherBg(
                            weatherType: WeatherType.lightRainy,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height)
                        : (detail.weather![0].main == "Rain")
                            ? WeatherBg(
                                weatherType: WeatherType.middleRainy,
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height)
                            : (detail.weather![0].main == "Snow")
                                ? WeatherBg(
                                    weatherType: WeatherType.middleSnow,
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height)
                                : (detail.weather![0].main == "Clear")
                                    ? WeatherBg(
                                        weatherType: WeatherType.sunny,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height)
                                    : (detail.weather![0].main == "Clouds")
                                        ? WeatherBg(
                                            weatherType: WeatherType.cloudy,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height)
                                        : WeatherBg(
                                            weatherType: WeatherType.hazy,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height),
                ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    Center(
                      child: SizedBox(
                        height: 150,
                        width: 150,
                        child: Image.network(
                          "http://openweathermap.org/img/wn/${detail.weather![0].icon}.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        "${detail.main!.temp} °C",
                        style: GoogleFonts.sourceSansPro(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Center(
                      child: Text(
                        "${detail.weather![0].main}",
                        style: GoogleFonts.sourceSansPro(),
                      ),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text("Min : ${detail.main!.tempMin} °C",
                          style: GoogleFonts.sourceSansPro()),
                      const SizedBox(width: 10),
                      Text("Max : ${detail.main!.tempMax} °C",
                          style: GoogleFonts.sourceSansPro())
                    ]),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 40,
                        width: context.width,
                        decoration: BoxDecoration(
                            color: const Color(0XFF104084).withOpacity(0.5),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(BoxIcons.bx_cloud),
                            Text("${detail.clouds!.all} %",
                                style: GoogleFonts.sourceSansPro()),
                            const SizedBox(width: 20),
                            const Icon(EvaIcons.thermometer),
                            Text("${detail.main!.humidity} %",
                                style: GoogleFonts.sourceSansPro()),
                            const SizedBox(width: 20),
                            const Icon(BoxIcons.bx_wind),
                            Text("${detail.wind!.speed} meter / sec",
                                style: GoogleFonts.sourceSansPro()),
                            const SizedBox(width: 20),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 250,
                      width: context.width,
                      decoration: BoxDecoration(
                          color: const Color(0XFF104084).withOpacity(0.5),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView(
                          children: [
                            Center(
                              child: Text(
                                "Air Polution in 5 days",
                                style: GoogleFonts.sourceSansPro(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 10),
                            FutureBuilder<List<dynamic>>(
                              future: controller.detailPolution(
                                  detail.coord!.lat.toString(),
                                  detail.coord!.lon.toString(),
                                  detail.dt!,
                                  days),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }

                                return SizedBox(
                                  height: 200,
                                  width: context.width,
                                  child: ListView.separated(
                                    itemCount: snapshot.data?.length ?? 0,
                                    separatorBuilder: (context, index) =>
                                        const Divider(
                                      height: 5,
                                      thickness: 5,
                                    ),
                                    itemBuilder: (context, index) {
                                      AirPolution airPolution =
                                          snapshot.data![index];
                                      print(
                                          "isi component in detail : ${airPolution.components}");
                                      var time =
                                          DateTime.fromMillisecondsSinceEpoch(
                                              airPolution.dt! * 1000);
                                      var formate1 =
                                          "${time.day} / ${time.month} / ${time.year}";
                                      var formate2 =
                                          "${time.hour} : ${time.minute}${time.second}";
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 5),
                                          Row(
                                            children: [
                                              Text(formate1),
                                              const SizedBox(width: 20),
                                              Text("($formate2)"),
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                              "Co : ${airPolution.components!["co"]} μg/m3"),
                                          const SizedBox(height: 5),
                                          Text(
                                              "No : ${airPolution.components!["no"]} μg/m3"),
                                          const SizedBox(height: 5),
                                          Text(
                                              "O3 : ${airPolution.components!["o3"]} μg/m3"),
                                          const SizedBox(height: 5),
                                          Text(
                                              "S02 : ${airPolution.components!["so2"]} μg/m3"),
                                          const SizedBox(height: 5),
                                          Text(
                                              "PM2_5 : ${airPolution.components!["pm2_5"]} μg/m3"),
                                          const SizedBox(height: 5),
                                          Text(
                                              "PM10 : ${airPolution.components!["pm10"]} μg/m3"),
                                          const SizedBox(height: 5),
                                          Text(
                                              "NH3 : ${airPolution.components!["nh3"]} μg/m3"),
                                          const SizedBox(height: 5),
                                          (airPolution.main!.aqi == 1)
                                              ? const Text("Conclussion : Good")
                                              : (airPolution.main!.aqi == 2)
                                                  ? const Text(
                                                      "Conclussion : Fair")
                                                  : (airPolution.main!.aqi == 3)
                                                      ? const Text(
                                                          "Conclussion : Moderate")
                                                      : (airPolution
                                                                  .main!.aqi ==
                                                              4)
                                                          ? const Text(
                                                              "Conclussion : Poor")
                                                          : const Text(
                                                              "Conclussion : Very Poor"),
                                          const SizedBox(height: 5),
                                        ],
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // ! next weather
                    Container(
                      height: 300,
                      width: context.width,
                      decoration: BoxDecoration(
                          color: const Color(0XFF104084).withOpacity(0.5),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: ListView(
                        children: [
                          Center(
                            child: Text(
                              "Next Weather in 5 days",
                              style: GoogleFonts.sourceSansPro(
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 10),
                          FutureBuilder<List<dynamic>>(
                            future: controller.nextWeather(
                                detail.coord!.lat.toString(),
                                detail.coord!.lon.toString()),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }

                              return SizedBox(
                                  height: 300,
                                  width: context.width,
                                  child: ListView.separated(
                                    padding: const EdgeInsets.all(10),
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(width: 20),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      NextWeather next =
                                          controller.nextweather[index];
                                      // print(
                                      //     "isi component in detail : ${airPolution.components}");
                                      var time = next.dtTxt!;
                                      var formate1 =
                                          "${time.day} / ${time.month} / ${time.year}";
                                      var formate2 =
                                          "${time.hour} : ${time.minute}${time.second}";
                                      return Column(
                                        children: [
                                          Text(formate1),
                                          const SizedBox(height: 5),
                                          Text("($formate2)"),
                                          const SizedBox(height: 30),
                                          Image.network(
                                            "http://openweathermap.org/img/wn/${detail.weather![0].icon}.png",
                                          ),
                                          const SizedBox(height: 30),
                                          Text("${next.weather![0].main}"),
                                          const SizedBox(height: 5),
                                          Text(
                                              "(${next.weather![0].description})"),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Text(
                                                  "Min : ${next.main!.tempMin} °C"),
                                              const SizedBox(width: 10),
                                              Text(
                                                  "Min : ${next.main!.tempMax} °C"),
                                            ],
                                          )
                                        ],
                                      );
                                    },
                                  ));
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            );
          },
        )));
  }
}

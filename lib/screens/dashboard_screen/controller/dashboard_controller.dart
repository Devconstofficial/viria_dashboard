import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:viria_dashboard/utils/app_images.dart';

import '../../../model/revenue_model.dart';


class DashboardController extends GetxController {
  RxString selectedOption = "".obs;
  List<String> options = ["Last 7 days", "Monthly", "Yearly"];

  RxList<FlSpot> newSignups = <FlSpot>[].obs;
  RxList<FlSpot> videosGenerated = <FlSpot>[].obs;
  RxList<FlSpot> activeSubscribers = <FlSpot>[].obs;
  RxDouble selectedXValue = 6.0.obs;
  var weeklyRevenue = <WeeklyRevenueModel>[].obs;
  RxList<double> actualVideos = <double>[].obs;
  RxList<double> targetVideos = <double>[].obs;
  RxList<String> months = <String>[].obs;
  RxBool isDataLoaded = false.obs;

  RxList<CountryData> userCountries = <CountryData>[
    CountryData('United States', Colors.orange),
    CountryData('Brazil', Colors.redAccent),
    CountryData('China', Colors.purple),
    CountryData('India', Colors.teal),
    CountryData('Indonesia', Colors.green),
    CountryData('Nigeria', Colors.blue),
  ].obs;

  late MapShapeSource mapSource;


  @override
  void onInit() {
    super.onInit();
    fetchChartData();
    fetchWeeklyRevenue();
    loadChartData();

    mapSource = MapShapeSource.asset(
      kMapJson,
      shapeDataField: 'name',
      dataCount: userCountries.length,
      primaryValueMapper: (int index) => userCountries[index].country,
      shapeColorValueMapper: (int index) => userCountries[index].color,
    );
  }

  void loadChartData() {
    months.value = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
    actualVideos.value = [8.5, 7.5, 6, 8, 9, 9.2];
    targetVideos.value = [10, 9.5, 11, 9, 12, 12];

    Future.microtask(() {
      isDataLoaded.value = months.isNotEmpty &&
          actualVideos.length == targetVideos.length &&
          actualVideos.isNotEmpty;
    });
  }

  double get averageActual => actualVideos.isEmpty ? 0 : actualVideos.reduce((a, b) => a + b) / actualVideos.length;
  double get averageTarget => targetVideos.isEmpty ? 0 : targetVideos.reduce((a, b) => a + b) / targetVideos.length;

  void fetchChartData() {
    newSignups.value = [
      FlSpot(0, 320),
      FlSpot(1, 300),
      FlSpot(2, 260),
      FlSpot(3, 200),
      FlSpot(4, 180),
      FlSpot(5, 250),
      FlSpot(6, 310),
      FlSpot(7, 330),
      FlSpot(8, 310),
      FlSpot(9, 280),
      FlSpot(10, 220),
      FlSpot(11, 180),
    ];

    videosGenerated.value = [
      FlSpot(0, 240),
      FlSpot(1, 220),
      FlSpot(2, 180),
      FlSpot(3, 140),
      FlSpot(4, 180),
      FlSpot(5, 250),
      FlSpot(6, 350),
      FlSpot(7, 330),
      FlSpot(8, 310),
      FlSpot(9, 270),
      FlSpot(10, 220),
      FlSpot(11, 180),
    ];

    activeSubscribers.value = [
      FlSpot(0, 280),
      FlSpot(1, 330),
      FlSpot(2, 300),
      FlSpot(3, 260),
      FlSpot(4, 180),
      FlSpot(5, 200),
      FlSpot(6, 270),
      FlSpot(7, 310),
      FlSpot(8, 300),
      FlSpot(9, 260),
      FlSpot(10, 240),
      FlSpot(11, 210),
    ];
  }

  void fetchWeeklyRevenue() {
    weeklyRevenue.value = [
      WeeklyRevenueModel(day: 'Mon', subscriptionRevenue: 14, creditPurchases: 13),
      WeeklyRevenueModel(day: 'Tue', subscriptionRevenue: 17, creditPurchases: 12),
      WeeklyRevenueModel(day: 'Wed', subscriptionRevenue: 6, creditPurchases: 22),
      WeeklyRevenueModel(day: 'Thu', subscriptionRevenue: 16, creditPurchases: 7),
      WeeklyRevenueModel(day: 'Fri', subscriptionRevenue: 13, creditPurchases: 12),
      WeeklyRevenueModel(day: 'Sat', subscriptionRevenue: 17, creditPurchases: 14),
      WeeklyRevenueModel(day: 'Sun', subscriptionRevenue: 21, creditPurchases: 12),
    ];
  }
}

class CountryData {
  final String country;
  final Color color;

  CountryData(this.country, this.color);
}
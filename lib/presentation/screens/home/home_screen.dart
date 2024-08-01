import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:food_macros/core/constants/app_assets.dart';
import 'package:food_macros/core/constants/app_colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    data = [
      _ChartData('Arroz', 1000),
      _ChartData('Pan', 600),
      _ChartData('Agua', 8000),
      _ChartData('Pasta', 1000),
      _ChartData('Tomate', 600),
      _ChartData('Tortitas', 120),
      _ChartData('Caldo', 2000),
      _ChartData('Leche', 6000),
      _ChartData('Patata', 5000),
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final additivesList = [AppAssets.additive1, AppAssets.additive2];

    return Scaffold(
        backgroundColor: AppColors.foreground,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CarouselSlider(
                    items: additivesList
                        .map((e) => Image.asset(
                              e,
                              fit: BoxFit.cover,
                            ))
                        .toList(),
                    options: CarouselOptions(
                      height: 200,
                      viewportFraction: 0.7,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      enlargeCenterPage: true,
                    )),
                const SizedBox(
                  height: 100,
                ),
                SfCartesianChart(
                    primaryXAxis: const CategoryAxis(),
                    primaryYAxis: const NumericAxis(
                        minimum: 0, maximum: 5000, interval: 500),
                    tooltipBehavior: _tooltip,
                    series: <CartesianSeries<_ChartData, String>>[
                      BarSeries<_ChartData, String>(
                          dataSource: data,
                          xValueMapper: (_ChartData data, _) => data.x,
                          yValueMapper: (_ChartData data, _) => data.y,
                          name: 'Alimento',
                          color: AppColors.secondary)
                    ])
              ],
            ),
          ),
        ));
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}

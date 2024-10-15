import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_macros/core/constants/app_colors.dart';
import 'package:food_macros/core/types/screen_status.dart';
import 'package:food_macros/presentation/screens/home/bloc/home_bloc.dart';
import 'package:food_macros/presentation/screens/home/bloc/home_state.dart';
import 'package:food_macros/presentation/screens/home/widgets/additive_card.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.foreground,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state.screenStatus.isLoading()) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state.screenStatus.isError()) {
                return const Center(
                  child: Text('Error en la home'),
                );
              }

              final List<_ChartData> chartData = state.monthlySpent
                  .map((monthlySpent) => _ChartData(
                        monthlySpent.alimentName,
                        monthlySpent.quantity.toDouble(),
                        monthlySpent.id,
                      ))
                  .toList();

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CarouselSlider(
                    items: state.additives
                        .map((additive) => AdditiveCard(
                              additiveNumber: additive.additiveNumber,
                              name: additive.name,
                            ))
                        .toList(),
                    options: CarouselOptions(
                      height: 200,
                      viewportFraction: 0.7,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      enlargeCenterPage: true,
                    ),
                  ),
                  Stack(
                    children: [
                      SfCartesianChart(
                        primaryYAxis: const NumericAxis(
                          minimum: 0,
                          maximum: 5000,
                          interval: 500,
                        ),
                        primaryXAxis: const CategoryAxis(),
                        tooltipBehavior: _tooltip,
                        series: <CartesianSeries<_ChartData, String>>[
                          BarSeries<_ChartData, String>(
                            dataSource: chartData,
                            xValueMapper: (_ChartData data, _) => data.x,
                            yValueMapper: (_ChartData data, _) => data.y,
                            name: 'Alimento',
                            color: AppColors.secondary,
                          ),
                        ],
                      ),
                      if (chartData.isEmpty)
                        Positioned.fill(
                          child: Center(
                            child: Text(
                              "No hay información disponible",
                              style: TextStyle(
                                fontSize: 28,
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ),
                          ),
                        ),
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y, this.id);

  final String x;
  final double y;
  final int? id;
}

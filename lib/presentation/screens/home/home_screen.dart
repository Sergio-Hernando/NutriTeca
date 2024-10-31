import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutri_teca/core/constants/app_colors.dart';
import 'package:nutri_teca/core/constants/app_theme.dart';
import 'package:nutri_teca/core/extensions/context_extension.dart';
import 'package:nutri_teca/core/types/screen_status.dart';
import 'package:nutri_teca/domain/models/additive_entity.dart';
import 'package:nutri_teca/presentation/screens/home/bloc/home_bloc.dart';
import 'package:nutri_teca/presentation/screens/home/bloc/home_state.dart';
import 'package:nutri_teca/presentation/screens/home/widgets/additive_card.dart';
import 'package:nutri_teca/presentation/screens/home/widgets/monthly_spent_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TooltipBehavior _tooltip;
  bool _isOverlayOpen = false;

  @override
  void initState() {
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  void _showAdditiveDialog(AdditiveEntity additive) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    setState(() {
      _isOverlayOpen = true;
    });

    overlayEntry = OverlayEntry(
      builder: (context) => Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: AppColors.background.withOpacity(0.9),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 10,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  additive.name,
                  style: AppTheme.titleTextStyle
                      .copyWith(color: AppColors.foreground),
                ),
                Text(
                  additive.description,
                  style: const TextStyle(fontFamily: 'Roboto'),
                ),
                ElevatedButton(
                  onPressed: () => {
                    setState(() {
                      _isOverlayOpen = false;
                    }),
                    overlayEntry.remove()
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryAccent,
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(fontWeight: FontWeight.w800)),
                  child: Text(context.localizations.close),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
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
                return Center(
                  child: Text(context.localizations.homeError),
                );
              }

              final List<ChartData> chartData = state.monthlySpent
                  .map((monthlySpent) => ChartData(
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
                        .map((additive) => GestureDetector(
                              onTap: () => _showAdditiveDialog(additive),
                              child: AdditiveCard(
                                additiveNumber: additive.additiveNumber,
                                name: additive.name,
                              ),
                            ))
                        .toList(),
                    options: CarouselOptions(
                      height: 200,
                      viewportFraction: 0.8,
                      autoPlay: !_isOverlayOpen,
                      autoPlayInterval: const Duration(seconds: 3),
                      enlargeCenterPage: true,
                    ),
                  ),
                  MonthlySpentChart(tooltip: _tooltip, chartData: chartData)
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

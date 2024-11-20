import 'package:flutter/material.dart';
import 'package:nutri_teca/core/constants/app_colors.dart';
import 'package:nutri_teca/core/extensions/context_extension.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MonthlySpentChart extends StatelessWidget {
  const MonthlySpentChart({
    super.key,
    required TooltipBehavior tooltip,
    required this.chartData,
  }) : _tooltip = tooltip;

  final TooltipBehavior _tooltip;
  final List<ChartData> chartData;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SfCartesianChart(
          primaryYAxis: const NumericAxis(
            minimum: 0,
            maximum: 5000,
            interval: 500,
          ),
          primaryXAxis: const CategoryAxis(),
          tooltipBehavior: _tooltip,
          series: <CartesianSeries<ChartData, String>>[
            BarSeries<ChartData, String>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              name: context.localizations.aliment,
              color: AppColors.secondary,
            ),
          ],
        ),
        if (chartData.isEmpty)
          Positioned.fill(
            child: Center(
              child: Text(
                context.localizations.informationNotAvailable,
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.id);

  final String x;
  final double y;
  final int? id;
}

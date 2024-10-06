import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ShowLineChart extends StatelessWidget {
  List<FlSpot> spotsToShow;
  double maxX;
  double maxY;

  ShowLineChart(
      {super.key, required this.spotsToShow, this.maxX = 12, this.maxY = 4}) {
    if (spotsToShow.isNotEmpty) {
      final FlSpot finalValue = spotsToShow.last;
      maxX = finalValue.x;
      maxY = finalValue.y;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineTouchData: const LineTouchData(
          enabled: true,
        ),
        gridData: const FlGridData(
          show: false,
        ),
        titlesData: const FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        // minX: 0,
        maxX: maxX,
        maxY: maxY,
        minY: 0,
        lineBarsData: [
          LineChartBarData(
            spots: spotsToShow.length > 1
                ? spotsToShow
                : [
                    const FlSpot(1, 1.7),
                    const FlSpot(3, 2.5),
                    const FlSpot(6, 2.4),
                    const FlSpot(8, 2.8),
                    const FlSpot(10, 2.5),
                    const FlSpot(11, 5.6),
                  ],
            isCurved: true,
            color: Colors.orangeAccent,
            barWidth: 4,
            isStrokeCapRound: true,
            dotData: const FlDotData(
              show: false,
            ),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.amber[50],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pos_inoidsoft_app/constant.dart';
import 'package:pos_inoidsoft_app/presentation/screens/Currency_exchange/chart.dart';
import 'package:pos_inoidsoft_app/presentation/screens/Stadistics/stadistics.dart';

class DrawLineChartWidget extends StatelessWidget {
  List<FlSpot> pointToShow = [];
  MomentTypes moment;
  var maxDaySales;
  double totalSales;
  double maxXToShow = 0.0;
  double maxYToShow = 0.0;

  DrawLineChartWidget(
      {super.key,
      required this.pointToShow,
      required this.moment,
      required this.maxDaySales,
      required this.totalSales}) {}

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 6,
      child: Stack(children: [
        ShowLineChart(
          spotsToShow: pointToShow,
        ),
        Positioned(
          bottom: 82,
          right: 170,
          child: Row(
            children: [
              const CircleAvatar(radius: 10, backgroundColor: Colors.green),
              const SizedBox(width: 5),
              Text(
                "$MAX_DAY: \$$maxDaySales",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 27,
          left: 20,
          child: Row(
            children: [
              const CircleAvatar(radius: 5, backgroundColor: Colors.red),
              const SizedBox(width: 5),
              Text(
                "$SALES: \$$totalSales",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:pos_inoidsoft_app/presentation/providers/item_sales_provider.dart';

import '../../../constant.dart';
import '../Currency_exchange/chart.dart';

enum MomentTypes { daily, weekly, monthly }

class Stadistics extends StatelessWidget {
  const Stadistics({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            STADISCTICS_TITLE,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: DAILY_STADISTICS,
                icon: Icon(Icons.calendar_today_sharp),
              ),
              Tab(
                text: WEEKLY_STADISTICS,
                icon: Icon(Icons.calendar_view_week_sharp),
              ),
              Tab(
                text: MONTH_STADISTICS,
                icon: Icon(Icons.calendar_month_sharp),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: ByMomentStadistic(moment: MomentTypes.daily),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: ByMomentStadistic(moment: MomentTypes.weekly),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: ByMomentStadistic(moment: MomentTypes.monthly),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ByMomentStadistic extends ConsumerWidget {
  final MomentTypes moment;

  List<String> _listProductName = [];
  String selectedProduct = '';

  num MAX_LENGTH = 15;

  late double totalSales;

  var maxDaySales;

  ByMomentStadistic({super.key, this.moment = MomentTypes.daily});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///####################################################################
    ///  Bibliografy:
    ///    https://github.com/AbdullahChauhan/custom-dropdown/blob/master/example/lib/widgets/search_dropdown.dart
    ///
    ///
    /// #################################################################

    _listProductName =
        ref.watch(itemSalesProvider).map((e) => e.title).toList();
    selectedProduct = _listProductName[0];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$MY_SALES ${validatePeriod(moment)}",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(height: 5),
        getSaleStadisticsByMomenDrawChart(moment),
        const SizedBox(
          height: 25,
        ),
        const Text(
          BY_PRODUCT_SALES,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
        ),

        /// Select one products from the list and show the chart
        CustomDropdown<String>.search(
          hintText: 'Select cuisines',
          items: _listProductName,
          initialItem: selectedProduct,
          overlayHeight: 342,
          onChanged: (value) {
            print('SearchDropdown onChanged value: $value');
            // setState(() {
            //   selectedItem = value;
            // });

            selectedProduct = value as String;
          },
        ),
        getSaleStadisticsByProductDrawChart(moment, selectedProduct),
      ],
    );
  }

  validatePeriod(MomentTypes moment) {
    switch (moment) {
      case MomentTypes.daily:
        return DAILY;
      case MomentTypes.weekly:
        return WEEKLY;
      case MomentTypes.monthly:
        return MONTHLY;
      default:
        return 'Invalid moment';
    }
  }

  getMoment(MomentTypes moment) {
    switch (moment) {
      case MomentTypes.daily:
        return DAY;
      case MomentTypes.weekly:
        return WEEK;
      case MomentTypes.monthly:
        return MONTH;
      default:
        return 'Invalid moment';
    }
  }

  List<FlSpot> getSaleStadisticsByMoment(MomentTypes moment) {
    List<FlSpot> result = [];
    double step =
        double.parse((Random().nextDouble() * 1.7).toStringAsFixed(2)) %
            MAX_LENGTH;

    for (int i = 1; i < MAX_LENGTH; i++) {
      result.add(FlSpot(i.toDouble(), double.parse(step.toStringAsFixed(2))));
      step += step + MAX_LENGTH;
    }

    totalSales = result.fold(0, (tot, item) => tot.toDouble() + item.y);
    totalSales = double.parse(totalSales.toStringAsFixed(2));

    return result;
  }

  DrawLineChartWidget getSaleStadisticsByMomenDrawChart(MomentTypes moment) {
    List<FlSpot> result = [];
    double step =
        double.parse((Random().nextDouble() * 1.7).toStringAsFixed(2)) %
            MAX_LENGTH;

    for (int i = 1; i < MAX_LENGTH; i++) {
      result.add(FlSpot(i.toDouble(), double.parse(step.toStringAsFixed(2))));
      step += step + MAX_LENGTH;
    }

    //Sum all values in sales by moment
    totalSales = result.fold(0, (tot, item) => tot.toDouble() + item.y);
    totalSales = double.parse(totalSales.toStringAsFixed(2));

    //Find out the max value in list
    FlSpot max = result.reduce((a, b) => (a.y > b.y) ? a : b);

    return DrawLineChartWidget(
      moment: moment,
      maxDaySales: "${max.y} /${getMoment(moment)} (${max.x.toInt()})",
      totalSales: totalSales,
      pointToShow: result,
    );
  }

  DrawLineChartWidget getSaleStadisticsByProductDrawChart(
      MomentTypes moment, String selectedProduct) {
    return getSaleStadisticsByMomenDrawChart(moment);
  }
}

class DrawLineChartWidget extends StatelessWidget {
  List<FlSpot> pointToShow = [];
  MomentTypes moment;
  var maxDaySales;
  double totalSales;

  DrawLineChartWidget(
      {super.key,
      required this.pointToShow,
      required this.moment,
      required this.maxDaySales,
      required this.totalSales});

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
          right: 120,
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

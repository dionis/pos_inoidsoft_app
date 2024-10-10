import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:pos_inoidsoft_app/presentation/providers/config_state_variables.dart';
import 'package:pos_inoidsoft_app/presentation/providers/item_sales_provider.dart';
import 'package:pos_inoidsoft_app/presentation/screens/Stadistics/compute_by_month.dart';
import 'package:pos_inoidsoft_app/presentation/screens/Stadistics/compute_result.dart';
import 'package:pos_inoidsoft_app/presentation/widgets/draw_line_chart_widget.dart';

import '../../../constant.dart';
import '../../../data/models/sales_order.dart';
import '../Currency_exchange/chart.dart';
import 'compute_by_7days.dart';
import 'compute_by_week.dart';

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
        // Text(
        //   "$MY_SALES ${validatePeriod(moment)}",
        //   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        // ),
        // const SizedBox(height: 15),
        // getSaleStadisticsByMomentDrawChart(moment),

        SaleStadisticsByMomentDrawChart(
          label: "$MY_SALES ${validatePeriod(moment)}",
          moment: moment,
        ),
        const SizedBox(
          height: 45,
        ),
        SaleStadisticsByMomentDrawChartConsumer(
          label: BY_PRODUCT_SALES,
          moment: moment,
        ),
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

  DrawLineChartWidget getSaleStadisticsByMomentDrawChart(MomentTypes moment) {
    List<FlSpot> result = [];

    late ComputeResult stadisticsCalculator;

    switch (moment) {
      case MomentTypes.daily:
        stadisticsCalculator = ComputeBy7Days(stadisticOrders: stadisticOrders);
        break;
      case MomentTypes.weekly:
        stadisticsCalculator = ComputeByWeek(stadisticOrders: stadisticOrders);
        break;
      case MomentTypes.monthly:
        stadisticsCalculator = ComputeByMonth(stadisticOrders: stadisticOrders);
        break;
      default:
        break;
    }

    result = stadisticsCalculator.compute();

    // double step =
    //     double.parse((Random().nextDouble() * 1.7).toStringAsFixed(2)) %
    //         MAX_LENGTH;

    // for (int i = 1; i < MAX_LENGTH; i++) {
    //   result.add(FlSpot(i.toDouble(), double.parse(step.toStringAsFixed(2))));
    //   step += step + MAX_LENGTH;
    // }

    //Sum all values in sales by moment
    totalSales = result.fold(0, (tot, item) => tot.toDouble() + item.y);
    totalSales = double.parse(totalSales.toStringAsFixed(2));

    //Find out the max value in list
    FlSpot max = result.reduce((a, b) => (a.y > b.y) ? a : b);

    return DrawLineChartWidget(
      moment: moment,
      maxDaySales:
          "${double.parse(max.y.toStringAsFixed(2))} /${getMoment(moment)} (${max.x.toInt()})",
      totalSales: totalSales,
      pointToShow: result,
    );
  }

  DrawLineChartWidget getSaleStadisticsByProductDrawChart(
      MomentTypes moment, String selectedProduct) {
    return getSaleStadisticsByMomentDrawChart(moment);
  }

  // Define an extension method to get the week of the year
}

class SaleStadisticsByMomentDrawChart extends StatelessWidget {
  MomentTypes moment;
  String label;
  double totalSales = 0.0;

  SaleStadisticsByMomentDrawChart(
      {super.key, required this.moment, required this.label});

  @override
  Widget build(BuildContext context) {
    List<FlSpot> result = [];
    late ComputeResult stadisticsCalculator;

    switch (moment) {
      case MomentTypes.daily:
        stadisticsCalculator = ComputeBy7Days(stadisticOrders: stadisticOrders);
        break;
      case MomentTypes.weekly:
        stadisticsCalculator = ComputeByWeek(stadisticOrders: stadisticOrders);
        break;
      case MomentTypes.monthly:
        stadisticsCalculator = ComputeByMonth(stadisticOrders: stadisticOrders);
        break;
      default:
        break;
    }

    result = stadisticsCalculator.compute();
    //Sum all values in sales by moment
    totalSales = result.fold(0, (tot, item) => tot.toDouble() + item.y);
    totalSales = double.parse(totalSales.toStringAsFixed(2));

    //Find out the max value in list
    FlSpot max = result.reduce((a, b) => (a.y > b.y) ? a : b);

    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(height: 15),
        DrawLineChartWidget(
          moment: moment,
          maxDaySales:
              "${double.parse(max.y.toStringAsFixed(2))} /${getMoment(moment)} (${max.x.toInt()})",
          totalSales: totalSales,
          pointToShow: result,
        )
      ],
    );
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
}

class SaleStadisticsByMomentDrawChartConsumer extends ConsumerWidget {
  MomentTypes moment;
  String label;
  double totalSales = 0.0;
  List<String> _listProductName = [];
  String selectedProduct = '';
  List<SalesOrder> itemsOrder = [];

  String selectedItem = '';

  SaleStadisticsByMomentDrawChartConsumer(
      {super.key, required this.moment, required this.label});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<FlSpot> result = [];
    late ComputeResult stadisticsCalculator;

    itemsOrder = selectedItem.isEmpty ? stadisticOrders : itemsOrder;

    switch (moment) {
      case MomentTypes.daily:
        stadisticsCalculator = ComputeBy7Days(stadisticOrders: itemsOrder);
        break;
      case MomentTypes.weekly:
        stadisticsCalculator = ComputeByWeek(stadisticOrders: itemsOrder);
        break;
      case MomentTypes.monthly:
        stadisticsCalculator = ComputeByMonth(stadisticOrders: itemsOrder);
        break;
      default:
        break;
    }

    result = stadisticsCalculator.compute();
    //Sum all values in sales by moment
    totalSales = result.fold(0, (tot, item) => tot.toDouble() + item.y);
    totalSales = double.parse(totalSales.toStringAsFixed(2));

    //Find out the max value in list
    FlSpot max = result.reduce((a, b) => (a.y > b.y) ? a : b);

    _listProductName =
        ref.watch(itemSalesProvider).map((e) => e.title).toList();
    selectedProduct = _listProductName[0];

    selectedItem = ref.watch(selectedItemProvider);

    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        CustomDropdown<String>.search(
          hintText: SELECT_PRODUCT_NAME,
          items: _listProductName,
          initialItem: selectedProduct,
          overlayHeight: 342,
          onChanged: (value) {
            selectedItem = selectedProduct = value as String;

            itemsOrder = stadisticOrders.map((element) {
              element.items = element.items
                  .where((item) => item.product!.title == selectedItem)
                  .toList();
              return element;
            }).toList();

            ref.read(selectedItemProvider.notifier).selected = selectedItem;
          },
        ),
        const SizedBox(height: 15),
        DrawLineChartWidget(
          moment: moment,
          maxDaySales:
              "${double.parse(max.y.toStringAsFixed(2))} /${getMoment(moment)} (${max.x.toInt()})",
          totalSales: totalSales,
          pointToShow: result,
        )
      ],
    );
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
}

// ignore: implementation_imports
import 'package:fl_chart/src/chart/base/axis_chart/axis_chart_data.dart';
import 'package:pos_inoidsoft_app/data/models/sales_order.dart';
import 'package:pos_inoidsoft_app/presentation/screens/Stadistics/compute_result.dart';

class ComputeByWeek extends ComputeResult {
  num SIZE_WEEK = 4;

  ComputeByWeek({required super.stadisticOrders});

  @override
  List<FlSpot> compute() {
    Map<int, FlSpot> mapSalesByMonth = {};
    DateTime currentDay = DateTime.now();
    double sumAllPrice = 0.0;

    for (SalesOrder iSalesOrder in stadisticOrders) {
      //If not current year not compute
      // if (iSalesOrder.date.year != currentDay.year &&
      //     iSalesOrder.date.month != currentDay.month) {
      //   continue;
      // }

      int valueWeekOfMonth = iSalesOrder.date.weekOfMonth;

      //Sum all prices of products in current product order
      sumAllPrice = iSalesOrder.items
          .fold(0, (tot, item) => tot.toDouble() + item.product!.price);

      if (!mapSalesByMonth.containsKey(valueWeekOfMonth)) {
        mapSalesByMonth.putIfAbsent(valueWeekOfMonth,
            () => FlSpot(valueWeekOfMonth.toDouble(), sumAllPrice));
      } else {
        FlSpot current = mapSalesByMonth.entries
            .firstWhere((element) => element.key == valueWeekOfMonth)
            .value;
        double y = current.y + sumAllPrice;
        FlSpot newCurrent = FlSpot(valueWeekOfMonth.toDouble(), y);
        mapSalesByMonth.update(valueWeekOfMonth, (value) => newCurrent,
            ifAbsent: () => const FlSpot(0, 0));
      }
    }

    for (int iWeek = 1; iWeek <= SIZE_WEEK; iWeek++) {
      if (iWeek != currentDay.weekOfMonth) {
        mapSalesByMonth.putIfAbsent(iWeek, () => FlSpot(iWeek.toDouble(), 0));
      }
    }
    return mapSalesByMonth.values.toList();
  }

  @override
  List<FlSpot> computeByItem(String itemName) {
    // TODO: implement computeByItem
    throw UnimplementedError();
  }
}

extension DateTimeExtension on DateTime {
  int get weekOfMonth {
    var date = this;
    final firstDayOfTheMonth = DateTime(date.year, date.month, 1);
    int sum = firstDayOfTheMonth.weekday - 1 + date.day;
    if (sum % 7 == 0) {
      return sum ~/ 7;
    } else {
      return sum ~/ 7 + 1;
    }
  }
}

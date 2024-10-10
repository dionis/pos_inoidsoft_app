// ignore: implementation_imports
import 'package:fl_chart/src/chart/base/axis_chart/axis_chart_data.dart';
import 'package:pos_inoidsoft_app/data/models/sales_order.dart';
import 'package:pos_inoidsoft_app/presentation/screens/Stadistics/compute_result.dart';

class ComputeBy7Days extends ComputeResult {
  ComputeBy7Days({required super.stadisticOrders});

  @override
  List<FlSpot> compute() {
    Map<int, FlSpot> mapSalesByMonth = {};
    DateTime currentDay = DateTime.now();
    double sumAllPrice = 0.0;
    int dayOfDifference = 7;

    for (int iDay = 0; iDay <= dayOfDifference; iDay++) {
      int dayInInterval = currentDay.subtract(Duration(days: iDay)).day;

      mapSalesByMonth.putIfAbsent(
          dayInInterval, () => FlSpot(dayInInterval.toDouble(), 0.0));
    }

    for (SalesOrder iSalesOrder in stadisticOrders) {
      //If not current year not compute
      //and validate a day in the last 7 days
      if (iSalesOrder.date.year != currentDay.year &&
          iSalesOrder.date.month != currentDay.month &&
          currentDay.subtract(Duration(days: dayOfDifference)).day <=
              iSalesOrder.date.day &&
          iSalesOrder.date.day <= currentDay.day) {
        continue;
      }

      int dayOfMonth = iSalesOrder.date.day;

      //Sum all prices of products in current product order
      sumAllPrice = iSalesOrder.items
          .fold(0, (tot, item) => tot.toDouble() + item.product!.price);

      sumAllPrice = double.parse(sumAllPrice.toStringAsExponential(2));

      if (!mapSalesByMonth.containsKey(dayOfMonth)) {
        mapSalesByMonth.putIfAbsent(
            dayOfMonth, () => FlSpot(dayOfMonth.toDouble(), sumAllPrice));
      } else {
        FlSpot current = mapSalesByMonth.entries
            .firstWhere((element) => element.key == dayOfMonth)
            .value;
        double y = current.y + sumAllPrice;
        FlSpot newCurrent = FlSpot(dayOfMonth.toDouble(), y);
        mapSalesByMonth.update(dayOfMonth, (value) => newCurrent,
            ifAbsent: () => const FlSpot(0, 0));
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

// ignore: implementation_imports
import 'package:fl_chart/src/chart/base/axis_chart/axis_chart_data.dart';
import 'package:pos_inoidsoft_app/data/models/sales_order.dart';
import 'package:pos_inoidsoft_app/presentation/screens/Stadistics/compute_result.dart';

class ComputeByMonth extends ComputeResult {
  ComputeByMonth({required super.stadisticOrders});

  @override
  List<FlSpot> compute() {
    Map<int, FlSpot> mapSalesByMonth = {};
    DateTime currentDay = DateTime.now();
    int month;
    double sumAllPrice = 0.0;

    for (SalesOrder iSalesOrder in stadisticOrders) {
      //If not current year not compute
      if (iSalesOrder.date.year != currentDay.year) {
        continue;
      }

      month = iSalesOrder.date.month;

      //Sum all prices of products in current product order
      sumAllPrice = iSalesOrder.items
          .fold(0, (tot, item) => tot.toDouble() + item.product!.price);

      if (!mapSalesByMonth.containsKey(month)) {
        mapSalesByMonth.putIfAbsent(
            month, () => FlSpot(month.toDouble(), sumAllPrice));
      } else {
        FlSpot current = mapSalesByMonth.entries
            .firstWhere((element) => element.key == month)
            .value;
        double y = current.y + sumAllPrice;
        FlSpot newCurrent = FlSpot(month.toDouble(), y);
        mapSalesByMonth.update(month, (value) => newCurrent,
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

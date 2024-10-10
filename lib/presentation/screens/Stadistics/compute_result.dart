import 'package:fl_chart/fl_chart.dart';
import 'package:pos_inoidsoft_app/data/models/sales_order.dart';

abstract class ComputeResult {
  List<FlSpot> result = [];
  List<SalesOrder> stadisticOrders;

  ComputeResult({required this.stadisticOrders});

  List<FlSpot> get salesToShow => result;

  List<FlSpot> compute();

  List<FlSpot> computeByItem(String itemName);
}

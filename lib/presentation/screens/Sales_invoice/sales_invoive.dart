import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pos_inoidsoft_app/presentation/providers/config_state_variables.dart';
import 'package:pos_inoidsoft_app/presentation/providers/items_car_sales_provider.dart';
import 'package:random_name_generator/random_name_generator.dart';

import '../../../constant.dart';

class SalesInvoice extends ConsumerStatefulWidget {
  const SalesInvoice({super.key});

  @override
  ConsumerState<SalesInvoice> createState() => _SalesInvoiceState();
}

class _SalesInvoiceState extends ConsumerState<SalesInvoice> {
  int invoceNumber = Random(234).nextInt(2000);

  @override
  Widget build(BuildContext context) {
    final salesInvoiceData =
        ref.read(stadisticsSalesCartProvider.notifier).lastInsertedSales;

    final paymentMethodName = ref.watch(paymentMethodProvider);

    List<Map<String, String>> totalSalesData = [
      {
        'Total': TABLE_PRODUCT_TOTAL,
        'Cantidad': '',
        'Precio': '0.0',
      },
      {
        'Total': TABLE_PROCUT_CASH_TOTAL,
        'Cantidad': '',
        'Precio': '34.3',
      },
      {
        'Total': TABLE_PRODUCT_TRANSFER_TOTAL,
        'Cantidad': '',
        'Precio': '222234.3',
      },
      // Add more dummy data here...
    ];

    double total = salesInvoiceData.fold(
        0,
        (tot, item) =>
            tot.toDouble() + (item.product?.price ?? 1) * item.quantity);
    String totalSalestOutput = total.toStringAsFixed(2);
    totalSalesData[0]['Precio'] = totalSalestOutput;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                const Text(
                  INVOCE_NAME,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
                FloatingActionButton(
                    tooltip: PRINT_INVOCE,
                    onPressed: () {},
                    child: const Icon(Icons.print_outlined))
              ],
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.business_outlined,
                        size: 50,
                      ),
                      Text(
                        BUSSINES_NAME,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade400,
                            fontSize: 35),
                      ),
                      Text(
                        BUSSINES_NAME,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade400,
                            fontSize: 30),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(BUSSINES_ADDRESS,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.5)),
                      Text(BUSSINES_ADDRESS,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17)),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(BUSSINES_PHONE_NUMBER,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.5)),
                      Text(BUSSINES_PHONE_NUMBER,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 11.5)),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(BUSSINES_WEBPAGE,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12.5)),
                      Text(BUSSINES_WEBPAGE,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 9.5)),
                    ]),
              ),
            ),
            const DotWidget(
              dashColor: Colors.black,
              dashHeight: 2,
              dashWidth: 5,
              emptyWidth: 2,
            ),
            Container(
              padding: const EdgeInsets.all(2.0),
              child: Center(
                  child: DataTable(
                      columnSpacing: 30,
                      border: TableBorder.all(color: Colors.white),
                      headingRowColor:
                          const WidgetStatePropertyAll<Color?>(Colors.grey),
                      columns: [
                    DataColumn(
                        label: Text(
                      "$TABLE_INVOICE #$invoceNumber",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    )),
                    const DataColumn(
                        label: Text(TABLE_PAYMENT_METHOD,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16))),
                  ],
                      rows: [
                    DataRow(cells: [
                      DataCell(Text(
                        DateFormat('dd-MM-yyyy')
                            .add_jm()
                            .format(DateTime.now()),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )),
                      DataCell(Text(paymentMethodName)),
                    ]),
                    DataRow(cells: [
                      const DataCell(Text(
                        TABLE_SELLER_NAME,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      DataCell(Text(RandomNames(Zone.spain).fullName())),
                    ]),
                  ])),
            ),
            const DotWidget(
              dashColor: Colors.black,
              dashHeight: 2,
              dashWidth: 5,
              emptyWidth: 2,
            ),
            Container(
              //color: Colors.blueGrey,
              padding: const EdgeInsets.all(2.0),
              child: Center(
                  child: DataTable(
                //columnSpacing: 30,
                headingRowHeight: 0,
                border: TableBorder.all(color: Colors.white),
                headingRowColor:
                    const WidgetStatePropertyAll<Color?>(Colors.transparent),
                columns: const [
                  DataColumn(label: Text('')),
                  // DataColumn(label: Text('')),
                  DataColumn(label: Text('')),
                ],
                rows: (totalSalesData.map((data) {
                  return DataRow(cells: [
                    DataCell(Text(
                      data['Total']!,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    )),
                    // DataCell(Text(data['Cantidad']!)),
                    DataCell(Text(data['Precio']!,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18))),
                  ]);
                }).toList()),
              )),
            ),
            const DotWidget(
              dashColor: Colors.black,
              dashHeight: 2,
              dashWidth: 5,
              emptyWidth: 2,
            ),
            Container(
              //color: Colors.blueGrey,
              padding: const EdgeInsets.all(2.0),
              child: Center(
                  child: DataTable(
                //columnSpacing: 30,
                border: TableBorder.all(color: Colors.white),
                headingRowColor:
                    WidgetStatePropertyAll<Color?>(Colors.grey[400]),
                columns: const [
                  DataColumn(
                      label: Text(
                    TABLE_PRODUCT_NAME,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )),
                  DataColumn(
                      label: Text(TABLE_PRODUCT_QUANTITY,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text(TABLE_PRODUCT_PRICE,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold))),
                ],
                rows: (salesInvoiceData.map((data) {
                  final double productTotalPrice =
                      (data.quantity * data.product!.price);

                  return DataRow(cells: [
                    DataCell(Text(
                      data?.product?.title ?? '',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )),
                    DataCell(Text(data?.quantity.toString() ?? '')),
                    DataCell(Text(
                      productTotalPrice.toStringAsFixed(2),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ))
                  ]);
                }).toList()),
              )),
            )
          ],
        ),
      ),
    );
  }
}

class DotWidget extends StatelessWidget {
  final double totalWidth, dashWidth, emptyWidth, dashHeight;

  final Color dashColor;

  const DotWidget({
    this.totalWidth = 300,
    this.dashWidth = 10,
    this.emptyWidth = 5,
    this.dashHeight = 2,
    this.dashColor = Colors.black,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalWidth ~/ (dashWidth + emptyWidth),
        (_) => Container(
          width: dashWidth,
          height: dashHeight,
          color: dashColor,
          margin: EdgeInsets.only(left: emptyWidth / 2, right: emptyWidth / 2),
        ),
      ),
    );
  }
}

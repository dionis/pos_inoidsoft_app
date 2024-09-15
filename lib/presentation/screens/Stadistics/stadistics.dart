import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
                child: const ByMomentStadistic(moment: MomentTypes.daily),
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
                child: const ByMomentStadistic(moment: MomentTypes.weekly),
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
                child: const ByMomentStadistic(moment: MomentTypes.monthly),
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
  const ByMomentStadistic({super.key, this.moment = MomentTypes.daily});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$MY_SALES $moment",
          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 6,
          child: const Stack(children: [
            ShowLineChart(),
            Positioned(
              bottom: 92,
              right: 27,
              child: CircleAvatar(radius: 10, backgroundColor: Colors.orange),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: Row(
                children: [
                  CircleAvatar(radius: 5, backgroundColor: Colors.amber),
                  SizedBox(width: 10),
                  Text(
                    '1BTC=\$5.483',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          BY_PRODUCT_SALES,
          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
        ),

        /// Select one products from the list and show the chart
        SizedBox(
          height: MediaQuery.of(context).size.height / 6,
          child: const Stack(children: [
            ShowLineChart(),
            Positioned(
              bottom: 92,
              right: 27,
              child: CircleAvatar(radius: 10, backgroundColor: Colors.orange),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: Row(
                children: [
                  CircleAvatar(radius: 5, backgroundColor: Colors.amber),
                  SizedBox(width: 10),
                  Text(
                    '1BTC=\$5.483',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ],
    );
  }
}

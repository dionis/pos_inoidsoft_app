import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:pos_inoidsoft_app/presentation/providers/config_state_variables.dart';
import 'package:pos_inoidsoft_app/presentation/providers/currency_coin_exchange.dart';
import 'package:pos_inoidsoft_app/presentation/providers/item_sales_provider.dart';

import '../../../constant.dart';
import '../../../data/models/currency.dart';
import '../../../data/models/exchange_coin.dart';
import 'detail_wallet.dart';
import 'total_wallet_bal.dart';

//Crypto Wallet App Flutter | flutter crypto wallet app ui

//https://www.youtube.com/watch?v=DiOZQ7aRb-k&list=PLOEXB48nQMqPK6gb_o4BXg3VhmabCujex&index=34

// List<Currency> listCurrencyExchangeItem = [
//   Currency(
//     name: 'Dollar',
//     imageAvatar: 'assets/currency/Dollar-USD.png',
//     rate: 4.32,
//     balance: '\$19.153',
//     profit: '\$ 5.441',
//   ),
//   Currency(
//       name: 'Euro',
//       imageAvatar: 'assets/currency/Euro-EUR.png',
//       rate: 3.97,
//       balance: '\$4.822',
//       profit: '\$ 401'),
//   Currency(
//       name: 'Zelle',
//       imageAvatar: 'assets/currency/Zelle.png',
//       rate: -13.55,
//       balance: '\$859',
//       profit: '\$ 0.45'),
//   Currency(
//       name: 'MLC',
//       imageAvatar: 'assets/currency/mlc.png',
//       rate: -13.55,
//       balance: '\$859',
//       profit: '\$ 0.45')
// ];

class CurrencyExchage extends ConsumerWidget {
  const CurrencyExchage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currencyCoinList = ref.watch(itemsExchangeCoinProvider);

    return Scaffold(
      backgroundColor: const Color(0xffECF5FD),
      //bottomNavigationBar: const BottomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          //Filter EditTExt Currency
          //List Currency
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: ListView.builder(
                      itemCount: currencyCoinList.length,
                      itemBuilder: (context, index) => CurrencyExchangeItem(
                            data: currencyCoinList[index],
                            index: index,
                          ))))
        ],
      ),
    );
  }

  Container myAppBar() {
    return Container(
      height: 110,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.notes,
            color: Colors.black87,
          ),
          const Text(
            "Wallets",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Image.asset("assets/icon1.png", height: 25),
        ],
      ),
    );
  }
}

class CurrencyExchangeItem extends ConsumerWidget {
  ExchangeCoin data;
  final int index;

  String? currencyExchangeSourceStr = '';

  CurrencyExchangeItem({super.key, required this.data, required this.index});

  // final String iconUrl;
  // final double percentage;
  // final String myCrypto;
  // final balance;
  // final profit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    currencyExchangeSourceStr = ref.watch(currentExchangeCoinSourceProvider);

    return InkWell(
      onTap: () {
        //Show warning because color exits
        Fluttertoast.showToast(
            msg: data.title, toastLength: Toast.LENGTH_SHORT);
        ref
            .read(selectedCoinIndexProvider.notifier)
            .updateEditSelectedItem(index);

        ref.read(selectedCoinProvider.notifier).setCoin(data);
        ref
            .read(currentIndexProvider.notifier)
            .updateCurrentMainWidget("EditCurrencyWidget", 11);
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 22),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              (data.image.contains("https:/"))
                  ? Image.network(
                      data.image,
                      width: 50,
                    )
                  : data.image.isEmpty
                      ? const Icon(
                          Icons.currency_exchange_sharp,
                          size: 50,
                        )
                      : Image.asset(
                          data.image,
                          width: 50,
                          height: 50.5,
                        ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      data.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Text(currencyExchangeSource[0],
                            style: TextStyle(fontSize: 15))
                        //  DropdownButton(
                        //     borderRadius: BorderRadius.circular(20)
                        //         .copyWith(topLeft: Radius.circular(0)),
                        //     isExpanded: true,
                        //     hint: Text(TYPE_EXCHANGE,
                        //         style: TextStyle(fontSize: 15)),
                        //     value: data.excangheType,
                        //     items: currencyExchangeSource
                        //         .map((element) => DropdownMenuItem(
                        //             value: element,
                        //             child: Text(element,
                        //                 style: TextStyle(
                        //                     fontSize: 15,
                        //                     color: Colors.black45))))
                        //         .toList(),
                        //     onChanged: (val) {
                        //       print('SearchDropdown onChanged value: $val');
                        //       ref
                        //           .read(
                        //               currentExchangeCoinSourceProvider.notifier)
                        //           .updateShoppingCartSize(val!);
                        //       data.excangheType = val;
                        //     }),
                        )
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'CUP: ${data.rate}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.pink),
                  ),
                  Text(
                    DateFormat('dd-MM-yyyy').format(data.time),
                    style: const TextStyle(
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

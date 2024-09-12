import 'package:flutter/material.dart';

import '../../../data/models/currency.dart';
import 'detail_wallet.dart';
import 'total_wallet_bal.dart';

//Crypto Wallet App Flutter | flutter crypto wallet app ui

//https://www.youtube.com/watch?v=DiOZQ7aRb-k&list=PLOEXB48nQMqPK6gb_o4BXg3VhmabCujex&index=34

List<Currency> listCurrencyExchangeItem = [
  Currency(
    name: '3.529020 BTC',
    imageAvatar:
        'https://icons.iconarchive.com/icons/cjdowner/cryptocurrency/128/Bitcoin-icon.png',
    rate: 4.32,
    balance: '\$19.153',
    profit: '\$ 5.441',
  ),
  Currency(
      name: '12.633681ETH',
      imageAvatar:
          'https://icons.iconarchive.com/icons/cjdowner/cryptocurrency/128/Ethereum-icon.png',
      rate: 3.97,
      balance: '\$4.822',
      profit: '\$ 401'),
  Currency(
      name: '3.529020 BTC',
      imageAvatar:
          'https://icons.iconarchive.com/icons/cjdowner/cryptocurrency/128/Ripple-icon.png',
      rate: -13.55,
      balance: '\$859',
      profit: '\$ 0.45')
];

class CurrencyExchage extends StatelessWidget {
  const CurrencyExchage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffECF5FD),
      //bottomNavigationBar: const BottomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          //myAppBar(),
          const SizedBox(height: 25),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DetailWalletScreen()),
                    );
                  },
                  child: TotalWalletBalance(
                    context: context,
                    totalBalance: '\$39.584',
                    crypto: "7.251332 BTC",
                    percentage: 3.55,
                  ),
                ),
                TotalWalletBalance(
                  context: context,
                  totalBalance: '\$55.594',
                  crypto: '9.332421 BTC',
                  percentage: -9.999,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Sorted by higher %',
                    style: TextStyle(color: Colors.black38)),
                Row(children: [
                  Text(
                    '24H',
                    style: TextStyle(color: Colors.black38),
                  ),
                  Icon(Icons.keyboard_arrow_down, color: Colors.black38),
                ])
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          //Filter EditTExt Currency
          //List Currency
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: ListView.builder(
                      itemCount: listCurrencyExchangeItem.length,
                      itemBuilder: (context, index) => CurrencyExchangeItem(
                          data: listCurrencyExchangeItem[index]))))
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

class CurrencyExchangeItem extends StatelessWidget {
  final Currency data;

  const CurrencyExchangeItem({
    super.key,
    required this.data,
  });

  // final String iconUrl;
  // final double percentage;
  // final String myCrypto;
  // final balance;
  // final profit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network(
              data.imageAvatar,
              width: 50,
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
                    data.name,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    data.profit,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${data.balance}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  data.rate >= 0 ? '+${data.rate}%' : '${data.rate}%',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: data.rate >= 0 ? Colors.green : Colors.pink,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

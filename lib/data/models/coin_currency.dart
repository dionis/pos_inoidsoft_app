class CoinCurrency {
  late String euro;
  late String dollar;
  late String mlc;
  late String zelle;
  List<Map<String, double>> listCurrencyCoin;
  DateTime readTime;

  CoinCurrency({required this.readTime, required this.listCurrencyCoin});

  void updateCurrency(String? coinName, double rate) {
    if (coinName == null) {
      return;
    } else if (coinName.toLowerCase().contains('euro')) {
      euro = rate.toStringAsFixed(2);
    } else if (coinName.toLowerCase().contains('usd')) {
      dollar = rate.toStringAsFixed(2);
    }
  }

  void set currencies(List<Map<String, double>> newList) =>
      listCurrencyCoin = newList;
}

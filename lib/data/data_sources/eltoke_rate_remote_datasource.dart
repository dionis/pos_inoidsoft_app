import 'package:dio/dio.dart';
import 'package:string_validator/string_validator.dart';
import 'package:xml/xml.dart' as xml;
import '../models/coin_currency.dart';

String BNC_URL = 'https://www.bc.gob.cu/historigrama/xml/5054';

abstract class ElTolkeRateRemoteDatasource {
  Future<CoinCurrency> getRateCoinCurrency();
}

class ElTokeRateRemoteDatasourceImp implements ElTolkeRateRemoteDatasource {
  final Dio dio = Dio();

  @override
  Future<CoinCurrency> getRateCoinCurrency() async {
    final resp = await dio.get(BNC_URL);

    //Parse XML
    final document = xml.XmlDocument.parse(resp.data);

    //   curl -X 'GET' \
    // 'https://tasas.eltoque.com/v1/trmi?date_from=2022-10-27%2000%3A00%3A01&date_to=2022-10-27%2023%3A59%3A01' \
    // -H 'accept: */*' \
    // -H 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTcyNTgzNjg1NiwianRpIjoiYWZhOTQwMTMtNzQ2My00ZjYwLTg5MjMtMGIyZjQ4YzM1ZGI5IiwidHlwZSI6ImFjY2VzcyIsInN1YiI6IjY2Y2NhMzllMzhkNzU2MWQyMTUwYWEzNCIsIm5iZiI6MTcyNTgzNjg1NiwiZXhwIjoxNzU3MzcyODU2fQ.oJkghN6xeVzbBlXIVVHL6Bd_w-dXaJUMVii17S2Wrrw'

    //URL https://tasas.eltoque.com/v1/trmi?date_from=2022-10-27%2000%3A00%3A01&date_to=2022-10-27%2023%3A59%3A01

    // For testing

    //   {
    // "tasas": {
    //   "USDT_TRC20": 165,
    //   "BTC": 167.69,
    //   "MLC": 165,
    //   "USD": 165,
    //   "ECU": 165,
    //   "TRX": 171.735
    // },
    // "date": "2024-09-18",
    // "hour": 6,
    // "minutes": 57,
    // "seconds": 5
    //}
    final coinsNode = document.findAllElements('TC');
    // loop through the document and extract values4
    List<Map<String, double>> readValues = [];
    CoinCurrency currency =
        CoinCurrency(readTime: DateTime.now(), listCurrencyCoin: readValues);

    for (final coins in coinsNode) {
      final coinAcronym = coins.getAttribute('SIG_MONEDA') ?? '';
      final String coinName = coins.getAttribute('NOM_MONEDA') ?? '';
      final bncExchange = coins.getAttribute('TC_1');
      final String? rateExchange = coins.getAttribute('TC2');

      readValues.add({coinName: toDouble(rateExchange ?? '0.0')});
      currency.updateCurrency(coinAcronym, toDouble(rateExchange ?? '0.0'));
    }

    currency.currencies = readValues;

    return currency;
  }
}

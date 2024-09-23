import 'package:dio/dio.dart';
import 'package:string_validator/string_validator.dart';
import 'package:xml/xml.dart' as xml;
import '../models/coin_currency.dart';

String BNC_URL = 'https://www.bc.gob.cu/historigrama/xml/5054';

abstract class CadecaRateRemoteDatasource {
  Future<CoinCurrency> getRateCoinCurrency();
}

class CadecaRateRemoteDatasourceImp implements CadecaRateRemoteDatasource {
  final Dio dio = Dio();

  @override
  Future<CoinCurrency> getRateCoinCurrency() async {
    final resp = await dio.get(BNC_URL);

    //Parse XML
    final document = xml.XmlDocument.parse(resp.data);

    //URL reference https://www.bc.gob.cu/historigrama/138

    //  <TC SIG_MONEDA="AUD" NOM_MONEDA="DOLAR AUSTRALIANO" TC_1="16.19880" TC_2="80.99400"/>
    //  <TC SIG_MONEDA="MXN" NOM_MONEDA="NUEVO PESO MEXICANO" TC_1="1.24574" TC_2="6.22870"/>
    //  <TC SIG_MONEDA="GBP" NOM_MONEDA="LIBRA ESTERLINA" TC_1="31.56360" TC_2="157.81800"/>
    //  <TC SIG_MONEDA="NOK" NOM_MONEDA="CORONA NORUEGA" TC_1="2.26262" TC_2="11.31312"/>
    //  <TC SIG_MONEDA="SEK" NOM_MONEDA="CORONA SUECA" TC_1="2.35410" TC_2="11.77048"/>
    //  <TC SIG_MONEDA="USD" NOM_MONEDA="DOLAR AMERICANO" TC_1="24.00000" TC_2="120.00000"/>
    //  <TC SIG_MONEDA="CAD" NOM_MONEDA="DOLAR CANADIENSE" TC_1="17.64641" TC_2="88.23205"/>
    //  <TC SIG_MONEDA="JPY" NOM_MONEDA="YEN JAPONES" TC_1="5.91229" TC_2="1.18246"/>
    //  <TC SIG_MONEDA="DKK" NOM_MONEDA="CORONA DANESA" TC_1="3.57521" TC_2="17.87603"/>
    //  <TC SIG_MONEDA="CHF" NOM_MONEDA="FRANCO SUIZO" TC_1="28.34701" TC_2="141.73507"/>
    //  <TC SIG_MONEDA="EUR" NOM_MONEDA="EURO" TC_1="26.67480" TC_2="133.37400"/>
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

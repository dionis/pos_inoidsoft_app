import 'package:pos_inoidsoft_app/data/models/category.dart';
import 'package:pos_inoidsoft_app/presentation/widgets/categories.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../constant.dart';
import '../../data/models/cart_item.dart';
part 'config_state_variables.g.dart';

@Riverpod(keepAlive: true)
class CurrentIndex extends _$CurrentIndex {
  @override
  int build() {
    return 0;
  }

  void updateCurrentMainWidget(String widgetName, int? index) {
    switch (widgetName) {
      case 'Homeboard':
        state = index ?? 0;
        break;
      case 'QrReaderCodeWindow':
        state = index ?? 1;
        break;
      case 'MainPoSScreen':
        state = index ?? 2;
        break;
      case 'ItemListScreen':
        state = index ?? 3;
        break;
      case 'Stadistics':
        state = index ?? 4;
        break;
      case 'CalculatorScreen':
        state = index ?? 5;
        break;
      case 'ProductEditScreen':
        state = index ?? 6;
        break;
      case 'BussinesSettings':
        state = index ?? 7;
        break;
      case 'VendorSenttings':
        state = index ?? 8;
        break;
      case 'CurrencyExchage':
        state = index ?? 9;
        break;
      case 'SalesInvoice':
        state = index ?? 10;
        break;
      case 'EditCurrencyWidget':
        state = index ?? 11;
        break;
      default:
        state = 0;
        break;
    }
  }
}

@Riverpod(keepAlive: true)
class ShoppinCartSize extends _$ShoppinCartSize {
  @override
  int build() => 0;

  updateShoppingCartSize(int size) {
    state = size;
  }
}

@Riverpod(keepAlive: true)
class CurrentExchangeCoinSource extends _$CurrentExchangeCoinSource {
  @override
  String build() => currencyExchangeSource[0];

  updateShoppingCartSize(String newCurrentExchangeCoin) {
    state = newCurrentExchangeCoin;
  }
}

@Riverpod(keepAlive: true)
class CategorySelected extends _$CategorySelected {
  @override
  Category build() => Category(title: 'All', image: 'assets/no-image.jpg');

  void set update(Category newCategory) => state = newCategory;
}

@Riverpod(keepAlive: true)
class PaymentMethod extends _$PaymentMethod {
  @override
  String build() => paymentMethod.first;

  void setPayment(String newPaymentMethod) {
    state = newPaymentMethod;
  }
}

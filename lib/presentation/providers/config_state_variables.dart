import 'package:riverpod_annotation/riverpod_annotation.dart';

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
      default:
        state = 0;
        break;
    }
  }
}

@Riverpod(keepAlive: true)
class ShoppinCartSize extends _$ShoppinCartSize {
  @override
  int build() {
    return cartItems.length;
  }

  updateShoppingCartSize(int size) {
    state = size;
  }
}

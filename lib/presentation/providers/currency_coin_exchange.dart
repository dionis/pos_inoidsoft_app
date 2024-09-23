import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/exchange_coin.dart';

part 'currency_coin_exchange.g.dart';

@Riverpod(keepAlive: true)
class ItemsExchangeCoin extends _$ItemsExchangeCoin {
  @override
  List<ExchangeCoin> build() {
    return [
      ExchangeCoin(
        title: "Dollar",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
        image: "assets/currency/Dollar-USD.png",
        rate: 120,
      ),
      ExchangeCoin(
        title: "Euro",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
        image: "assets/currency/Euro-EUR.png",
        rate: 325,
      ),
      ExchangeCoin(
        title: "MLC",
        image: "assets/currency/mlc.png",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
        rate: 270,
      ),
      ExchangeCoin(
        title: "Zelle",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Donec massa sapien faucibus et molestie ac feugiat. In massa tempor nec feugiat nisl. Libero id faucibus nisl tincidunt.",
        rate: 270,
        image: "assets/currency/Zelle.png",
      ),
      ExchangeCoin(title: 'CUP', description: '', image: '', rate: 1)
    ];
  }

  bool createCoin(ExchangeCoin coin) {
    final exitsCoin = state.any((element) => element.id == coin.id);

    if (!exitsCoin) {
      state = [...state, coin];
    }

    return exitsCoin;
  }

  void updateCoin(ExchangeCoin coin, int index) {
    state = [...state]..[index] = coin;
  }

  void deleteCoin(int index) {
    state = [...state]..removeAt(index);
  }
}

@Riverpod(keepAlive: true)
class SelectedCoin extends _$SelectedCoin {
  @override
  ExchangeCoin build() =>
      ExchangeCoin(title: 'CUP', description: '', image: '', rate: 1);

  void setCoin(ExchangeCoin newCoin) {
    state = newCoin;
  }
}

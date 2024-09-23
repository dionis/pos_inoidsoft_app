// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_coin_exchange.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$itemsExchangeCoinHash() => r'd26bae4775c9600748f590396393ab9d50503c2f';

/// See also [ItemsExchangeCoin].
@ProviderFor(ItemsExchangeCoin)
final itemsExchangeCoinProvider =
    NotifierProvider<ItemsExchangeCoin, List<ExchangeCoin>>.internal(
  ItemsExchangeCoin.new,
  name: r'itemsExchangeCoinProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$itemsExchangeCoinHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ItemsExchangeCoin = Notifier<List<ExchangeCoin>>;
String _$selectedCoinHash() => r'2754832e171388cdf09d8de9e1570b489c1febf6';

/// See also [SelectedCoin].
@ProviderFor(SelectedCoin)
final selectedCoinProvider =
    NotifierProvider<SelectedCoin, ExchangeCoin>.internal(
  SelectedCoin.new,
  name: r'selectedCoinProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$selectedCoinHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedCoin = Notifier<ExchangeCoin>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

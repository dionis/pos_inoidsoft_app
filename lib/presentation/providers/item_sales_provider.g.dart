// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_sales_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$itemSalesCurrentFilterHash() =>
    r'1c5dfa5f1c09ede22bd0ff911f8cbada9d9a5804';

/// See also [ItemSalesCurrentFilter].
@ProviderFor(ItemSalesCurrentFilter)
final itemSalesCurrentFilterProvider =
    AutoDisposeNotifierProvider<ItemSalesCurrentFilter, FilterType>.internal(
  ItemSalesCurrentFilter.new,
  name: r'itemSalesCurrentFilterProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$itemSalesCurrentFilterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ItemSalesCurrentFilter = AutoDisposeNotifier<FilterType>;
String _$itemSalesHash() => r'9693da8ef398c2afa6f4dd5c918689fba3b2984c';

/// See also [ItemSales].
@ProviderFor(ItemSales)
final itemSalesProvider =
    AutoDisposeNotifierProvider<ItemSales, List<Product>>.internal(
  ItemSales.new,
  name: r'itemSalesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$itemSalesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ItemSales = AutoDisposeNotifier<List<Product>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

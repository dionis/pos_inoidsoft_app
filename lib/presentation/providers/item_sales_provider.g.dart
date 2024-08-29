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
String _$selectedProductHash() => r'02854d8e49d107b25ceba3986ded19713ddaa561';

/// See also [SelectedProduct].
@ProviderFor(SelectedProduct)
final selectedProductProvider =
    NotifierProvider<SelectedProduct, Product>.internal(
  SelectedProduct.new,
  name: r'selectedProductProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedProductHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedProduct = Notifier<Product>;
String _$itemSalesHash() => r'1c95391bf53982a11cfdfa57530cd0dd6a86f9e6';

/// See also [ItemSales].
@ProviderFor(ItemSales)
final itemSalesProvider = NotifierProvider<ItemSales, List<Product>>.internal(
  ItemSales.new,
  name: r'itemSalesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$itemSalesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ItemSales = Notifier<List<Product>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

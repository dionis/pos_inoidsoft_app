// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_sales_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$itemSalesCurrentFilterHash() =>
    r'a462667ecf286ab2c415c98ed5ab667324c29b03';

/// See also [ItemSalesCurrentFilter].
@ProviderFor(ItemSalesCurrentFilter)
final itemSalesCurrentFilterProvider =
    NotifierProvider<ItemSalesCurrentFilter, FilterType>.internal(
  ItemSalesCurrentFilter.new,
  name: r'itemSalesCurrentFilterProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$itemSalesCurrentFilterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ItemSalesCurrentFilter = Notifier<FilterType>;
String _$selectedProductHash() => r'0914ed829bc8a9ca57c806e6d00063253ccd1cd3';

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
String _$selectedProductIndexHash() =>
    r'37104b60a0bb2b2799a16843d05b8c151746b619';

/// See also [SelectedProductIndex].
@ProviderFor(SelectedProductIndex)
final selectedProductIndexProvider =
    NotifierProvider<SelectedProductIndex, int>.internal(
  SelectedProductIndex.new,
  name: r'selectedProductIndexProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedProductIndexHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedProductIndex = Notifier<int>;
String _$itemSalesHash() => r'5593d4861452b0f7a5d1d2c28e238e8d5fcd8635';

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

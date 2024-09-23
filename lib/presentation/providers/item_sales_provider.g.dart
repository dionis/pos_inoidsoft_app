// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_sales_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$filteredItemSalesHash() => r'62cdbb369e49bf11dd83cb4fc6f6754f00e58d73';

/// See also [filteredItemSales].
@ProviderFor(filteredItemSales)
final filteredItemSalesProvider = Provider<List<Product>>.internal(
  filteredItemSales,
  name: r'filteredItemSalesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$filteredItemSalesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FilteredItemSalesRef = ProviderRef<List<Product>>;
String _$filteredItemSalesByNameHash() =>
    r'd05da6af52be6ab012357383068ee2415a737e6a';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [filteredItemSalesByName].
@ProviderFor(filteredItemSalesByName)
const filteredItemSalesByNameProvider = FilteredItemSalesByNameFamily();

/// See also [filteredItemSalesByName].
class FilteredItemSalesByNameFamily extends Family<List<Product>> {
  /// See also [filteredItemSalesByName].
  const FilteredItemSalesByNameFamily();

  /// See also [filteredItemSalesByName].
  FilteredItemSalesByNameProvider call(
    String title,
  ) {
    return FilteredItemSalesByNameProvider(
      title,
    );
  }

  @override
  FilteredItemSalesByNameProvider getProviderOverride(
    covariant FilteredItemSalesByNameProvider provider,
  ) {
    return call(
      provider.title,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'filteredItemSalesByNameProvider';
}

/// See also [filteredItemSalesByName].
class FilteredItemSalesByNameProvider extends Provider<List<Product>> {
  /// See also [filteredItemSalesByName].
  FilteredItemSalesByNameProvider(
    String title,
  ) : this._internal(
          (ref) => filteredItemSalesByName(
            ref as FilteredItemSalesByNameRef,
            title,
          ),
          from: filteredItemSalesByNameProvider,
          name: r'filteredItemSalesByNameProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$filteredItemSalesByNameHash,
          dependencies: FilteredItemSalesByNameFamily._dependencies,
          allTransitiveDependencies:
              FilteredItemSalesByNameFamily._allTransitiveDependencies,
          title: title,
        );

  FilteredItemSalesByNameProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.title,
  }) : super.internal();

  final String title;

  @override
  Override overrideWith(
    List<Product> Function(FilteredItemSalesByNameRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FilteredItemSalesByNameProvider._internal(
        (ref) => create(ref as FilteredItemSalesByNameRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        title: title,
      ),
    );
  }

  @override
  ProviderElement<List<Product>> createElement() {
    return _FilteredItemSalesByNameProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FilteredItemSalesByNameProvider && other.title == title;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, title.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FilteredItemSalesByNameRef on ProviderRef<List<Product>> {
  /// The parameter `title` of this provider.
  String get title;
}

class _FilteredItemSalesByNameProviderElement
    extends ProviderElement<List<Product>> with FilteredItemSalesByNameRef {
  _FilteredItemSalesByNameProviderElement(super.provider);

  @override
  String get title => (origin as FilteredItemSalesByNameProvider).title;
}

String _$filteredItemSalesByQuantityHash() =>
    r'eb25ab59ec1868ab9c015032a2d785df71e9164c';

/// See also [filteredItemSalesByQuantity].
@ProviderFor(filteredItemSalesByQuantity)
const filteredItemSalesByQuantityProvider = FilteredItemSalesByQuantityFamily();

/// See also [filteredItemSalesByQuantity].
class FilteredItemSalesByQuantityFamily extends Family<List<Product>> {
  /// See also [filteredItemSalesByQuantity].
  const FilteredItemSalesByQuantityFamily();

  /// See also [filteredItemSalesByQuantity].
  FilteredItemSalesByQuantityProvider call(
    int quantity,
    QuantityFilterType filterType,
  ) {
    return FilteredItemSalesByQuantityProvider(
      quantity,
      filterType,
    );
  }

  @override
  FilteredItemSalesByQuantityProvider getProviderOverride(
    covariant FilteredItemSalesByQuantityProvider provider,
  ) {
    return call(
      provider.quantity,
      provider.filterType,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'filteredItemSalesByQuantityProvider';
}

/// See also [filteredItemSalesByQuantity].
class FilteredItemSalesByQuantityProvider extends Provider<List<Product>> {
  /// See also [filteredItemSalesByQuantity].
  FilteredItemSalesByQuantityProvider(
    int quantity,
    QuantityFilterType filterType,
  ) : this._internal(
          (ref) => filteredItemSalesByQuantity(
            ref as FilteredItemSalesByQuantityRef,
            quantity,
            filterType,
          ),
          from: filteredItemSalesByQuantityProvider,
          name: r'filteredItemSalesByQuantityProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$filteredItemSalesByQuantityHash,
          dependencies: FilteredItemSalesByQuantityFamily._dependencies,
          allTransitiveDependencies:
              FilteredItemSalesByQuantityFamily._allTransitiveDependencies,
          quantity: quantity,
          filterType: filterType,
        );

  FilteredItemSalesByQuantityProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.quantity,
    required this.filterType,
  }) : super.internal();

  final int quantity;
  final QuantityFilterType filterType;

  @override
  Override overrideWith(
    List<Product> Function(FilteredItemSalesByQuantityRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FilteredItemSalesByQuantityProvider._internal(
        (ref) => create(ref as FilteredItemSalesByQuantityRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        quantity: quantity,
        filterType: filterType,
      ),
    );
  }

  @override
  ProviderElement<List<Product>> createElement() {
    return _FilteredItemSalesByQuantityProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FilteredItemSalesByQuantityProvider &&
        other.quantity == quantity &&
        other.filterType == filterType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, quantity.hashCode);
    hash = _SystemHash.combine(hash, filterType.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FilteredItemSalesByQuantityRef on ProviderRef<List<Product>> {
  /// The parameter `quantity` of this provider.
  int get quantity;

  /// The parameter `filterType` of this provider.
  QuantityFilterType get filterType;
}

class _FilteredItemSalesByQuantityProviderElement
    extends ProviderElement<List<Product>> with FilteredItemSalesByQuantityRef {
  _FilteredItemSalesByQuantityProviderElement(super.provider);

  @override
  int get quantity => (origin as FilteredItemSalesByQuantityProvider).quantity;
  @override
  QuantityFilterType get filterType =>
      (origin as FilteredItemSalesByQuantityProvider).filterType;
}

String _$filteredItemSalesByPriceHash() =>
    r'61cd6bc0933f867d88a5786e253539e22ee4bc98';

/// See also [filteredItemSalesByPrice].
@ProviderFor(filteredItemSalesByPrice)
const filteredItemSalesByPriceProvider = FilteredItemSalesByPriceFamily();

/// See also [filteredItemSalesByPrice].
class FilteredItemSalesByPriceFamily extends Family<List<Product>> {
  /// See also [filteredItemSalesByPrice].
  const FilteredItemSalesByPriceFamily();

  /// See also [filteredItemSalesByPrice].
  FilteredItemSalesByPriceProvider call(
    int quantity,
    QuantityFilterType filterType,
  ) {
    return FilteredItemSalesByPriceProvider(
      quantity,
      filterType,
    );
  }

  @override
  FilteredItemSalesByPriceProvider getProviderOverride(
    covariant FilteredItemSalesByPriceProvider provider,
  ) {
    return call(
      provider.quantity,
      provider.filterType,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'filteredItemSalesByPriceProvider';
}

/// See also [filteredItemSalesByPrice].
class FilteredItemSalesByPriceProvider extends Provider<List<Product>> {
  /// See also [filteredItemSalesByPrice].
  FilteredItemSalesByPriceProvider(
    int quantity,
    QuantityFilterType filterType,
  ) : this._internal(
          (ref) => filteredItemSalesByPrice(
            ref as FilteredItemSalesByPriceRef,
            quantity,
            filterType,
          ),
          from: filteredItemSalesByPriceProvider,
          name: r'filteredItemSalesByPriceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$filteredItemSalesByPriceHash,
          dependencies: FilteredItemSalesByPriceFamily._dependencies,
          allTransitiveDependencies:
              FilteredItemSalesByPriceFamily._allTransitiveDependencies,
          quantity: quantity,
          filterType: filterType,
        );

  FilteredItemSalesByPriceProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.quantity,
    required this.filterType,
  }) : super.internal();

  final int quantity;
  final QuantityFilterType filterType;

  @override
  Override overrideWith(
    List<Product> Function(FilteredItemSalesByPriceRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FilteredItemSalesByPriceProvider._internal(
        (ref) => create(ref as FilteredItemSalesByPriceRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        quantity: quantity,
        filterType: filterType,
      ),
    );
  }

  @override
  ProviderElement<List<Product>> createElement() {
    return _FilteredItemSalesByPriceProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FilteredItemSalesByPriceProvider &&
        other.quantity == quantity &&
        other.filterType == filterType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, quantity.hashCode);
    hash = _SystemHash.combine(hash, filterType.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FilteredItemSalesByPriceRef on ProviderRef<List<Product>> {
  /// The parameter `quantity` of this provider.
  int get quantity;

  /// The parameter `filterType` of this provider.
  QuantityFilterType get filterType;
}

class _FilteredItemSalesByPriceProviderElement
    extends ProviderElement<List<Product>> with FilteredItemSalesByPriceRef {
  _FilteredItemSalesByPriceProviderElement(super.provider);

  @override
  int get quantity => (origin as FilteredItemSalesByPriceProvider).quantity;
  @override
  QuantityFilterType get filterType =>
      (origin as FilteredItemSalesByPriceProvider).filterType;
}

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
String _$itemSalesHash() => r'044df38b31cadfa82acb1aa89179c2f1a0f3c496';

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
String _$selectedCoinIndexHash() => r'84186089e60d1b98daa7768f4f6fae54fdaa0108';

/// See also [SelectedCoinIndex].
@ProviderFor(SelectedCoinIndex)
final selectedCoinIndexProvider =
    NotifierProvider<SelectedCoinIndex, int>.internal(
  SelectedCoinIndex.new,
  name: r'selectedCoinIndexProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedCoinIndexHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedCoinIndex = Notifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

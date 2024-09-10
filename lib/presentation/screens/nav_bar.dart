import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:pos_inoidsoft_app/constant.dart';
import 'package:pos_inoidsoft_app/presentation/providers/items_car_sales_provider.dart';
import 'package:pos_inoidsoft_app/presentation/screens/Calculator/calculator_screen.dart';
import 'package:pos_inoidsoft_app/presentation/providers/config_state_variables.dart';
import 'package:pos_inoidsoft_app/presentation/screens/Product/product_screen.dart';
import 'package:pos_inoidsoft_app/presentation/screens/Stadistics/stadistics.dart';
import 'package:pos_inoidsoft_app/presentation/screens/favorite.dart';
import 'package:pos_inoidsoft_app/presentation/widgets/custom_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/item_sales_provider.dart';
import 'Detail/edit_item.dart';
import 'Qrcode_reader/qr_code_reader_windows.dart';
import '../../data/models/cart_item.dart';
import 'Home/HomeBoard.dart';
import 'Items/item_lists.dart';
import 'post_screen/post_main_screen.dart';

class BottomNavBar extends ConsumerStatefulWidget {
  const BottomNavBar({super.key});

  @override
  ConsumerState<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends ConsumerState<BottomNavBar> {
  int currentIndexReference = 0;
  int shoppingCartSizeReference = 0;
  int currentProductIndexReference = 0;
  List<CartItem> cartItemsList = [];

  List screens = [
    const Homeboard(),
    const QrReaderCodeWindow(),
    const MainPoSScreen(),
    ItemListsScreen(),
    const Stadistics(),
    const CalculatorScreen(),
    CrudItemScreen(eventTitle: 'Add')
  ];

  // const ProductEditScreen()

  @override
  Widget build(BuildContext context) {
    currentIndexReference = ref.watch(currentIndexProvider);

    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        // Here we take the value from the MyHomePage object that was created by
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (context) {
            return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                style: IconButton.styleFrom(
                    backgroundColor: kcontentColor,
                    padding: const EdgeInsets.all(20)),
                icon: Image.asset("images/icon.png", height: 20));
          },
        ),
        actions: [
          _shoopingCartBadget(),
          IconButton(
              onPressed: () {},
              iconSize: 30,
              style: IconButton.styleFrom(
                  backgroundColor: kcontentColor,
                  padding: const EdgeInsets.all(20)),
              icon: const Icon(Icons.notifications_outlined))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "Unique",
        onPressed: () {
          setState(() {
            //currentIndexReference = 2;
            ref
                .read(itemSalesCurrentFilterProvider.notifier)
                .changeCurrentFilter(FilterType.all);
            ref
                .read(currentIndexProvider.notifier)
                .updateCurrentMainWidget("MainPoSScreen", 2);
          });
        },
        backgroundColor: kprimaryColor,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.home,
          color: Colors.white,
          size: 35,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 1,
        height: 60,
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    //currentIndexReference = 0;
                    ref
                        .read(itemSalesCurrentFilterProvider.notifier)
                        .changeCurrentFilter(FilterType.all);
                    ref
                        .read(currentIndexProvider.notifier)
                        .updateCurrentMainWidget("Homeboard", 0);
                  });
                },
                icon: Icon(
                  Icons.grid_view_outlined,
                  size: 30,
                  color: currentIndexReference == 0
                      ? kprimaryColor
                      : Colors.grey.shade400,
                )),
            IconButton(
                onPressed: () {
                  setState(() {
                    //currentIndexReference = 1;
                    ref
                        .read(itemSalesCurrentFilterProvider.notifier)
                        .changeCurrentFilter(FilterType.all);
                    ref
                        .read(currentIndexProvider.notifier)
                        .updateCurrentMainWidget("QrReaderCodeWindow", 1);
                  });
                },
                icon: Icon(
                  Icons.qr_code_scanner_rounded,
                  size: 30,
                  color: currentIndexReference == 1
                      ? kprimaryColor
                      : Colors.grey.shade400,
                )),
            const SizedBox(
              width: 15,
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    //currentIndexReference = 2;
                    ref
                        .read(itemSalesCurrentFilterProvider.notifier)
                        .changeCurrentFilter(FilterType.all);
                    ref
                        .read(currentIndexProvider.notifier)
                        .updateCurrentMainWidget("MainPoSScreen", 2);
                  });
                },
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  size: 30,
                  color: currentIndexReference == 2
                      ? kprimaryColor
                      : Colors.grey.shade400,
                )),
            IconButton(
                onPressed: () {
                  setState(() {
                    //currentIndexReference = 3;
                    ref
                        .read(itemSalesCurrentFilterProvider.notifier)
                        .changeCurrentFilter(FilterType.all);
                    ref
                        .read(currentIndexProvider.notifier)
                        .updateCurrentMainWidget("ItemListScreen", 3);
                  });
                },
                icon: Icon(
                  Icons.format_list_bulleted_add,
                  size: 30,
                  color: currentIndexReference == 3
                      ? kprimaryColor
                      : Colors.grey.shade400,
                )),
            IconButton(
                onPressed: () {
                  setState(() {
                    //currentIndexReference = 4;
                    ref
                        .read(itemSalesCurrentFilterProvider.notifier)
                        .changeCurrentFilter(FilterType.all);
                    ref
                        .read(currentIndexProvider.notifier)
                        .updateCurrentMainWidget("Stadistics", 4);
                  });
                },
                icon: Icon(
                  Icons.query_stats_sharp,
                  size: 30,
                  color: currentIndexReference == 4
                      ? kprimaryColor
                      : Colors.grey.shade400,
                )),
          ],
        ),
      ),
      body: screens[currentIndexReference],
      drawer: CustomDrawer(),
    );
  }

  Widget _shoopingCartBadget() {
    shoppingCartSizeReference = ref.watch(shoppinCartSizeProvider);

    cartItemsList = ref.watch(itemsSalesCartProvider);

    return badges.Badge(
      position: badges.BadgePosition.topEnd(top: 0, end: 3),
      badgeAnimation: const badges.BadgeAnimation.slide(
          // disappearanceFadeAnimationDuration: Duration(milliseconds: 200),
          // curve: Curves.easeInCubic,
          ),
      showBadge: cartItemsList.isNotEmpty,
      badgeStyle: const badges.BadgeStyle(
        badgeColor: Colors.red,
      ),
      badgeContent: Text(
        shoppingCartSizeReference.toString(),
        style: const TextStyle(color: Colors.white),
      ),
      child: IconButton(
          icon: const Icon(Icons.shopping_cart),
          style: IconButton.styleFrom(
              backgroundColor: kcontentColor,
              padding: const EdgeInsets.all(20)),
          onPressed: () {
            setState(() {
              ref
                  .read(itemSalesCurrentFilterProvider.notifier)
                  .changeCurrentFilter(FilterType.all);
              ref
                  .read(currentIndexProvider.notifier)
                  .updateCurrentMainWidget("MainPoSScreen", 2);
            });
          }),
    );
  }
}

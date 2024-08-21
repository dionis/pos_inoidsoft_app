import 'package:flutter/material.dart';
import 'package:pos_inoidsoft_app/constant.dart';
import 'package:pos_inoidsoft_app/pos_screen.dart';
import 'package:pos_inoidsoft_app/presentation/home_screen.dart';
import 'package:pos_inoidsoft_app/presentation/providers/config_state_variables.dart';
import 'package:pos_inoidsoft_app/presentation/screens/Stadistics/stadistics.dart';
import 'package:pos_inoidsoft_app/presentation/screens/favorite.dart';
import 'package:pos_inoidsoft_app/presentation/widgets/custom_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/qr_code_reader_windows.dart';
import 'Home/HomeBoard.dart';
import 'Items/Items.dart';
import 'post_screen/post_main_screen.dart';

class BottomNavBar extends ConsumerStatefulWidget {
  const BottomNavBar({super.key});

  @override
  ConsumerState<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends ConsumerState<BottomNavBar> {
  int currentIndexReference = 0;
  List screens = const [
    Homeboard(),
    //FavoriteScreen(),
    QrReaderCodeWindow(),
    //PostScreen(),
    MainPoSScreen(),
    ItemListScreen(),
    Stadistics(),
  ];

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
          IconButton(
              padding: const EdgeInsets.all(10),
              onPressed: () {},
              iconSize: 30,
              style: IconButton.styleFrom(
                  backgroundColor: kcontentColor,
                  padding: const EdgeInsets.all(20)),
              icon: const Icon(Icons.shopping_cart)),
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
                        .read(currentIndexProvider.notifier)
                        .updateCurrentMainWidget("QrReaderCodeWindow", 1);
                  });
                },
                icon: Icon(
                  Icons.favorite_border,
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
                        .read(currentIndexProvider.notifier)
                        .updateCurrentMainWidget("ItemListScreen", 3);
                  });
                },
                icon: Icon(
                  Icons.person,
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
      drawer: const CustomDrawer(),
    );
  }
}

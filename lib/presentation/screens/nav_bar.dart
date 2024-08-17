import 'package:flutter/material.dart';
import 'package:pos_inoidsoft_app/constant.dart';
import 'package:pos_inoidsoft_app/pos_screen.dart';
import 'package:pos_inoidsoft_app/presentation/home_screen.dart';
import 'package:pos_inoidsoft_app/presentation/screens/Stadistics/stadistics.dart';
import 'package:pos_inoidsoft_app/presentation/screens/favorite.dart';
import 'package:pos_inoidsoft_app/presentation/widgets/custom_drawer.dart';

import 'Home/HomeBoard.dart';
import 'Items/Items.dart';
import 'post_screen/post_main_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;
  List screens = const [
    Homeboard(),
    FavoriteScreen(),
    //PostScreen(),
    MainPoSScreen(),
    Stadistics(),
    Homeboard(),
    ItemListScreen(),
    Scaffold()
  ];

  @override
  Widget build(BuildContext context) {
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
            currentIndex = 2;
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
                    currentIndex = 0;
                  });
                },
                icon: Icon(
                  Icons.grid_view_outlined,
                  size: 30,
                  color:
                      currentIndex == 0 ? kprimaryColor : Colors.grey.shade400,
                )),
            IconButton(
                onPressed: () {
                  setState(() {
                    currentIndex = 1;
                  });
                },
                icon: Icon(
                  Icons.favorite_border,
                  size: 30,
                  color:
                      currentIndex == 1 ? kprimaryColor : Colors.grey.shade400,
                )),
            const SizedBox(
              width: 15,
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    currentIndex = 2;
                  });
                },
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  size: 30,
                  color:
                      currentIndex == 2 ? kprimaryColor : Colors.grey.shade400,
                )),
            IconButton(
                onPressed: () {
                  setState(() {
                    currentIndex = 3;
                  });
                },
                icon: Icon(
                  Icons.person,
                  size: 30,
                  color:
                      currentIndex == 3 ? kprimaryColor : Colors.grey.shade400,
                )),
            IconButton(
                onPressed: () {
                  setState(() {
                    currentIndex = 4;
                  });
                },
                icon: Icon(
                  Icons.grid_view_outlined,
                  size: 30,
                  color:
                      currentIndex == 4 ? kprimaryColor : Colors.grey.shade400,
                )),
          ],
        ),
      ),
      body: screens[currentIndex],
      drawer: const CustomDrawer(),
    );
  }
}

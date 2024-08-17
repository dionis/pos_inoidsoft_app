import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomDrawer extends ConsumerWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(image: AssetImage("images/slider.jpg"))),
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: const Text('Got to Details Page'),
            onTap: () async {
              // Update the state of the app.
              // ...
              GoRouter.of(context).goNamed('details_page',
                  pathParameters: {'name': 'Plz suscribe'});
            },
          ),
          ListTile(
            title: const Text('Go to Second Page'),
            onTap: () async {
              // Update the state of the app.
              // ...
              GoRouter.of(context).goNamed('second_page');
            },
          ),
          ListTile(
            title: const Text('Close Drawer programatically'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

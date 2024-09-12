import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/config_state_variables.dart';

class CustomDrawer extends ConsumerWidget {
  String MY_DETAILS = 'Mis Datos';

  String MY_BUSSINES_DETAILS = 'Datos de mi negocio';

  String ECHANGE_RATE_DATAILS = 'Tasa de cambio';

  String CLOSE_DRAWER = "Cerrar menu";

  String STADISTICS_DATAILS = 'Estadísticas';

  CustomDrawer({super.key});

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
            title: Text(
              MY_DETAILS,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.5),
            ),
            onTap: () async {
              // Update the state of the app.
              // ...
              // GoRouter.of(context).goNamed('details_page',
              //     pathParameters: {'name': 'Plz suscribe'});
              ref
                  .read(currentIndexProvider.notifier)
                  .updateCurrentMainWidget("VendorSenttings", 8);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(
              MY_BUSSINES_DETAILS,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.5),
            ),
            onTap: () async {
              // Update the state of the app.
              // ...
              // GoRouter.of(context).goNamed('second_page');

              ref
                  .read(currentIndexProvider.notifier)
                  .updateCurrentMainWidget("BussinesSettings", 7);

              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(
              ECHANGE_RATE_DATAILS,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.5),
            ),
            onTap: () async {
              // Update the state of the app.
              // ...
              //GoRouter.of(context).goNamed('second_page');
              ref
                  .read(currentIndexProvider.notifier)
                  .updateCurrentMainWidget("CurrencyExchage", 9);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(
              STADISTICS_DATAILS,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.5),
            ),
            onTap: () async {
              // Update the state of the app.
              // ...
              //GoRouter.of(context).goNamed('second_page');
              ref
                  .read(currentIndexProvider.notifier)
                  .updateCurrentMainWidget("CurrencyExchage", 9);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(
              CLOSE_DRAWER,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.5),
            ),
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

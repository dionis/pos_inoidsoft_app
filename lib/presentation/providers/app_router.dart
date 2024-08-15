import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pos_inoidsoft_app/presentation/screens/add_item.dart';
import 'package:pos_inoidsoft_app/presentation/screens/item_lists.dart';
import 'package:pos_inoidsoft_app/presentation/screens/stadistics.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../post_screen/post_main_screen.dart';
import '../screens/settings.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    initialLocation: '/',
    routes: <RouteBase>[
      GoRoute(
          path: '/',
          name: 'pos_screen',
          builder: (context, state) => const MainPoSScreen()),
      GoRoute(
          path: '/settings:name',
          name: 'settings_page',
          builder: (context, state) {
            //Pass paramter and get their value

            final name = state.pathParameters['name'];
            return const Settings();
          }),
      GoRoute(
          path: '/stadisticsPage',
          name: 'stadistics_page',
          builder: (context, state) => const Stadistics()),
      GoRoute(
          path: '/itemLists',
          name: 'item_lists',
          builder: (context, state) => const ItemLists()),
      GoRoute(
          path: '/itemAdd',
          name: 'item_add',
          builder: (context, state) => const ItemAdd()),
    ],
    errorBuilder: (context, state) => const ErrorScreen(),
  );
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('View not found'),
      ),
    );
  }
}

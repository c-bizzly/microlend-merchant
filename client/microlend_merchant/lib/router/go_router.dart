import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:microlend_merchant/feature/add_item/add_item_page.dart';
import 'package:microlend_merchant/feature/home/home_page.dart';
import 'package:microlend_merchant/feature/quantity/quantity_page.dart';
import 'package:microlend_merchant/feature/user/login/login_page.dart';

import '../feature/qr/qr_page.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      name: 'login',
      path: '/login',
      pageBuilder:
          (ctx, state) =>
              MaterialPage(key: state.pageKey, child: const LoginPage()),
    ),
    GoRoute(
      name: 'home',
      path: '/',
      pageBuilder: (ctx, state) {
        final rebuild = state.extra as bool?;
        return MaterialPage(
          key: state.pageKey,
          child: HomePage(rebuild: rebuild),
        );
      },
    ),
    GoRoute(
      name: 'addItem',
      path: '/add-item',
      pageBuilder:
          (ctx, state) =>
              MaterialPage(key: state.pageKey, child: const AddItemPage()),
    ),
    GoRoute(
      name: 'quantity',
      path: '/quantity',
      pageBuilder:
          (ctx, state) =>
              MaterialPage(key: state.pageKey, child: const QuantityPage()),
    ),
    GoRoute(
      name: 'payment',
      path: '/payment',
      pageBuilder:
          (ctx, state) =>
              MaterialPage(key: state.pageKey, child: const QRPage()),
    ),
  ],
);

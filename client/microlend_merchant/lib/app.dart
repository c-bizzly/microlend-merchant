import 'package:flutter/material.dart';
import 'package:microlend_merchant/router/go_router.dart';

import 'theme/light.dart' as theme;

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'MicroLend Merchant',
      theme: theme.light,
      routerConfig: goRouter,
    );
  }
}

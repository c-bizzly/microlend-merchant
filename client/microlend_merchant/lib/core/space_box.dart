import 'package:flutter/widgets.dart';

class SpaceBox extends SizedBox {
  final double w;
  final double h;

  const SpaceBox({super.key, this.w = 0, this.h = 0});

  const SpaceBox.small({super.key})
      : w = 8,
        h = 8;

  const SpaceBox.medium({super.key})
      : w = 16,
        h = 16;

  const SpaceBox.mediumX({super.key})
      : w = 24,
        h = 24;

  const SpaceBox.large({super.key})
      : w = 32,
        h = 32;

  const SpaceBox.largeX({super.key})
      : w = 64,
        h = 64;

  @override
  double? get width => w;

  @override
  double? get height => h;
}

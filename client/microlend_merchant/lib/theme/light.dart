import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData light = ThemeData(
  // fontFamily: 'Noto Sans',
  fontFamily: GoogleFonts.openSans(letterSpacing: 0).fontFamily,

  // textTheme: GoogleFonts.openSansTextTheme(),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      // TODO animations
      TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
      // TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      // TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
      // TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
      // TargetPlatform.windows: OpenUpwardsPageTransitionsBuilder(),
      TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
    },
  ),

  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xff0000ff),

    surface: Color(0xFFFEFEFE),
    surfaceTint: Colors.transparent,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    isDense: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Color(0xFF5066F4),
      padding: EdgeInsets.symmetric(vertical: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      side: BorderSide(color: Color(0xFF5066F4)),
      textStyle: GoogleFonts.openSans(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Color(0xFF5066F4),
      padding: EdgeInsets.symmetric(vertical: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      side: BorderSide(color: Color(0xFF5066F4)),
      textStyle: GoogleFonts.openSans(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF5066F4),
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      textStyle: GoogleFonts.openSans(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
);

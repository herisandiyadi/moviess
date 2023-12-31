import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  test('Menguji konstanta nilai Text Style', () {
    expect(kHeading5,
        GoogleFonts.poppins(fontSize: 23, fontWeight: FontWeight.w400));
    expect(
        kHeading6,
        GoogleFonts.poppins(
            fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15));
    expect(
        kSubtitle,
        GoogleFonts.poppins(
            fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15));
    expect(
        kBodyText,
        GoogleFonts.poppins(
            fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.25));

    expect(
      kTextTheme,
      TextTheme(
        headlineSmall: kHeading5,
        titleLarge: kHeading6,
        titleMedium: kSubtitle,
        bodyMedium: kBodyText,
      ),
    );

    expect(
      kColorScheme,
      const ColorScheme(
        primary: kMikadoYellow,
        primaryContainer: kMikadoYellow,
        secondary: kPrussianBlue,
        secondaryContainer: kPrussianBlue,
        surface: kRichBlack,
        background: kRichBlack,
        error: Colors.red,
        onPrimary: kRichBlack,
        onSecondary: Colors.white,
        onSurface: Colors.white,
        onBackground: Colors.white,
        onError: Colors.white,
        brightness: Brightness.dark,
      ),
    );
  });
}

import 'package:ditonton/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  test('Menguji konstanta nilai', () {
    expect(BASE_IMAGE_URL, 'https://image.tmdb.org/t/p/w500');

    expect(kRichBlack, Color(0xFF000814));
    expect(kOxfordBlue, Color(0xFF001D3D));
    expect(kPrussianBlue, Color(0xFF003566));
    expect(kMikadoYellow, Color(0xFFffc300));
    expect(kDavysGrey, Color(0xFF4B5358));
    expect(kGrey, Color(0xFF303030));

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
        headline5: kHeading5,
        headline6: kHeading6,
        subtitle1: kSubtitle,
        bodyText2: kBodyText,
      ),
    );

    expect(
      kColorScheme,
      ColorScheme(
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

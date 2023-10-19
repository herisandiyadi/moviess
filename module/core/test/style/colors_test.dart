import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  test('Menguji konstanta nilai Colors', () {
    expect(kRichBlack, const Color(0xFF000814));
    expect(kOxfordBlue, const Color(0xFF001D3D));
    expect(kPrussianBlue, const Color(0xFF003566));
    expect(kMikadoYellow, const Color(0xFFffc300));
    expect(kDavysGrey, const Color(0xFF4B5358));
    expect(kGrey, const Color(0xFF303030));
  });
}

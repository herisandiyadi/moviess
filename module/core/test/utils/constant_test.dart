import 'package:core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  test('Menguji konstanta nilai URL', () {
    expect(BASE_IMAGE_URL, 'https://image.tmdb.org/t/p/w500');
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:tv/domain/entities/spoken_language.dart';

void main() {
  test('Equatable props should be correct', () {
    const tvSpoken = TvSpokenLanguage(
      englishName: 'englishNamee',
      iso6391: 'iso6391',
      name: 'name',
    );

    final props = tvSpoken.props;

    expect(props, [
      'englishNamee',
      'iso6391',
      'name',
    ]);
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:tv/domain/entities/tv_season.dart';

void main() {
  group('Test TV Season Entity', () {
    test('Equatable props should be correct', () {
      final tvSeason = TVSeason(
        airDate: DateTime(2023, 10, 19),
        episodeCount: 10,
        id: 1,
        name: 'Season 1',
        overview: 'Overview of Season 1',
        posterPath: 'path_to_poster_1',
        seasonNumber: 1,
        voteAverage: 8.0,
      );

      final props = tvSeason.props;

      expect(props, [
        DateTime(2023, 10, 19),
        10,
        1,
        'Season 1',
        'Overview of Season 1',
        'path_to_poster_1',
        1,
        8.0,
      ]);
    });
  });
}

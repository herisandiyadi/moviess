import 'package:flutter_test/flutter_test.dart';
import 'package:tv/domain/entities/tv_episode_toair.dart';

void main() {
  test('Equatable props should be correct', () {
    final tvEpisode = TvEpisodetoAir(
      id: 1,
      name: 'name',
      overview: 'overview',
      voteAverage: 1,
      voteCount: 1,
      airDate: DateTime(2017 - 05 - 05),
      episodeNumber: 1,
      episodeType: 'episodeType',
      productionCode: 'productionCode',
      runtime: 1,
      seasonNumber: 1,
      showId: 1,
      stillPath: 'stillPath',
    );

    final props = tvEpisode.props;

    expect(props, [
      1,
      'name',
      'overview',
      1,
      1,
      DateTime(2017 - 05 - 05),
      1,
      'episodeType',
      'productionCode',
      1,
      1,
      1,
      'stillPath',
    ]);
  });
}

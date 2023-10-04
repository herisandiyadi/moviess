import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvModel = TvModel(
    backdropPath: '/jWXrQstj7p3Wl5MfYWY6IHqRpDb.jpg',
    firstAirDate: '1952-12-26',
    genreIds: [10763],
    id: 94722,
    name: "Tagesschau",
    originCountry: ["DE"],
    originalLanguage: "de",
    originalName: "Tagesschau",
    overview:
        "German daily news program, the oldest still existing program on German television.",
    popularity: 3359.88,
    posterPath: "/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg",
    voteAverage: 7.5,
    voteCount: 143,
  );

  final tTv = Tv(
    backdropPath: '/jWXrQstj7p3Wl5MfYWY6IHqRpDb.jpg',
    firstAirDate: '1952-12-26',
    genreIds: [10763],
    id: 94722,
    name: "Tagesschau",
    originCountry: ["DE"],
    originalLanguage: "de",
    originalName: "Tagesschau",
    overview:
        "German daily news program, the oldest still existing program on German television.",
    popularity: 3359.88,
    posterPath: "/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg",
    voteAverage: 7.5,
    voteCount: 143,
  );

  test('Should be a subclass of Tv Series Entity', () async {
    final result = tTvModel.toEntity();
    expect(result, tTv);
  });
}

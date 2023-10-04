import 'dart:convert';

import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

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

  final tTvRresponseModel = TVResponse(tvSeriesList: <TvModel>[tTvModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_popular.json'));
      final result = TVResponse.fromJson(jsonMap);
      expect(result, tTvRresponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      final result = tTvRresponseModel.toJson();
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": '/jWXrQstj7p3Wl5MfYWY6IHqRpDb.jpg',
            "first_air_date": '1952-12-26',
            "genre_ids": [10763],
            "id": 94722,
            "name": "Tagesschau",
            "origin_country": ["DE"],
            "original_language": "de",
            "original_name": "Tagesschau",
            "overview":
                "German daily news program, the oldest still existing program on German television.",
            "popularity": 3359.88,
            "poster_path": '/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg',
            "vote_average": 7.5,
            "vote_count": 143,
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}

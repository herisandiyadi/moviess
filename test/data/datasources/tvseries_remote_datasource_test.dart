import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_remote_datasource.dart';
import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TVRemoteDatasourceImpl datasource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    datasource = TVRemoteDatasourceImpl(client: mockHttpClient);
  });

  group('Get Tv series popular', () {
    final tTvSeriesList =
        TVResponse.fromJson(json.decode(readJson('dummy_data/tv_popular.json')))
            .tvSeriesList;

    test('should return list of TV Model when the response code is 200',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_popular.json'), 200));

      final result = await datasource.getTVSeriesPopuler();

      expect(result, equals(tTvSeriesList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = datasource.getTVSeriesPopuler();
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get TV Series on The Air', () {
    final tMovieList = TVResponse.fromJson(
            json.decode(readJson('dummy_data/tv_ontheair.json')))
        .tvSeriesList;

    test(
        'should return list of Tv Series on The Air when response is success (200)',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_ontheair.json'), 200));

      final result = await datasource.getTvSeriesOnTheAir();
      expect(result, tMovieList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = datasource.getTvSeriesOnTheAir();
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get TV Top Rated', () {
    final tMovieList = TVResponse.fromJson(
            json.decode(readJson('dummy_data/tv_toprated.json')))
        .tvSeriesList;

    test(
        'should return list of Tv Series on The Air when response is success (200)',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_toprated.json'), 200));

      final result = await datasource.getTvSeriesTopRated();
      expect(result, tMovieList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = datasource.getTvSeriesTopRated();
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Tv Show Detail', () {
    final tId = 2;
    final tTvDetail = TvDetailModel.fromJson(
        json.decode(readJson('dummy_data/tv_detail.json')));

    test('should return Tv Show detail when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_detail.json'), 200));
      // act
      final result = await datasource.getTvDetail(tId);
      // assert

      expect(result, equals(tTvDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = datasource.getTvDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Search TV Shows', () {
    final tSearchResult = TVResponse.fromJson(
            json.decode(readJson('dummy_data/search_tagesschau.json')))
        .tvSeriesList;

    final tQuery = 'tagesschau';

    test('should return list of TV Show when response code is 200', () async {
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/search_tagesschau.json'), 200));

      final result = await datasource.searchTvShow(tQuery);

      expect(result, tSearchResult);
    });

    test(
        'sshould throw Server Exception when the response code is 404 or other',
        () async {
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/search_tagesschau.json'), 404));

      final call = datasource.searchTvShow(tQuery);

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('Get Tv Show Recomendations', () {
    final tTvList = TVResponse.fromJson(
            json.decode(readJson('dummy_data/tv_recomendations.json')))
        .tvSeriesList;

    final tId = 1;

    test('should return list of Tv Model when the response code is 200',
        () async {
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_recomendations.json'), 200));

      final result = await datasource.getTvRecomendations(tId);

      expect(result, equals(tTvList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = datasource.getTvRecomendations(tId);

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/t_episodetoair_model.dart';
import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:ditonton/data/models/tv_genre_model.dart';
import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/models/tv_product_country_model.dart';
import 'package:ditonton/data/models/tv_season_model.dart';
import 'package:ditonton/data/models/tv_spoken_model.dart';
import 'package:ditonton/data/models/tvseries_table.dart';
import 'package:ditonton/data/repositories/tvseries_repository_impl.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_tv_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesRepositoryImpl repository;
  late MockTVRemoteDataSource mockTVRemoteDataSource;
  late MockTvLocalDataSource mockTvLocalDataSource;
  late MockDatabaseHelper mockDatabaseHelper;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockTVRemoteDataSource = MockTVRemoteDataSource();
    mockTvLocalDataSource = MockTvLocalDataSource();
    mockDatabaseHelper = MockDatabaseHelper();
    mockNetworkInfo = MockNetworkInfo();

    repository = TvSeriesRepositoryImpl(
      networkInfo: mockNetworkInfo,
      databaseHelper: mockDatabaseHelper,
      tvRemoteDataSource: mockTVRemoteDataSource,
      tvLocalDataSource: mockTvLocalDataSource,
    );
  });

  final tTvModel = TvModel(
    backdropPath: "/tsRy63Mu5cu8etL1X7ZLyf7UP1M.jpg",
    firstAirDate: "2008-01-20",
    genreIds: [18, 80],
    id: 1396,
    name: "Breaking Bad",
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "Breaking Bad",
    overview:
        "When Walter White, a New Mexico chemistry teacher, is diagnosed with Stage III cancer and given a prognosis of only two years left to live. He becomes filled with a sense of fearlessness and an unrelenting desire to secure his family's financial future at any cost as he enters the dangerous world of drugs and crime.",
    popularity: 482.784,
    posterPath: "/3xnWaLQjelJDDF7LT1WBo6f4BRe.jpg",
    voteAverage: 151,
    voteCount: 3011,
  );

  final tTvShow = Tv(
    backdropPath: "/tsRy63Mu5cu8etL1X7ZLyf7UP1M.jpg",
    firstAirDate: "2008-01-20",
    genreIds: [18, 80],
    id: 1396,
    name: "Breaking Bad",
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "Breaking Bad",
    overview:
        "When Walter White, a New Mexico chemistry teacher, is diagnosed with Stage III cancer and given a prognosis of only two years left to live. He becomes filled with a sense of fearlessness and an unrelenting desire to secure his family's financial future at any cost as he enters the dangerous world of drugs and crime.",
    popularity: 482.784,
    posterPath: "/3xnWaLQjelJDDF7LT1WBo6f4BRe.jpg",
    voteAverage: 151,
    voteCount: 3011,
  );

  final testTvCacheMap = {
    'id': 1396,
    'overview':
        "When Walter White, a New Mexico chemistry teacher, is diagnosed with Stage III cancer and given a prognosis of only two years left to live. He becomes filled with a sense of fearlessness and an unrelenting desire to secure his family's financial future at any cost as he enters the dangerous world of drugs and crime.",
    'posterPath': "/3xnWaLQjelJDDF7LT1WBo6f4BRe.jpg",
    'title': "Breaking Bad",
  };

  final testTvCache = TvTable(
    id: 1396,
    title: "Breaking Bad",
    posterPath: "/3xnWaLQjelJDDF7LT1WBo6f4BRe.jpg",
    overview:
        "When Walter White, a New Mexico chemistry teacher, is diagnosed with Stage III cancer and given a prognosis of only two years left to live. He becomes filled with a sense of fearlessness and an unrelenting desire to secure his family's financial future at any cost as he enters the dangerous world of drugs and crime.",
  );

  final tTvModelList = <TvModel>[tTvModel];
  final tTvList = <Tv>[tTvShow];

  group('Tv Series : On the Air', () {
    group('When device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        when(mockTVRemoteDataSource.getTvSeriesOnTheAir())
            .thenAnswer((_) async => tTvModelList);

        final result = await repository.getTvSeriesOnTheAir();

        verify(mockTVRemoteDataSource.getTvSeriesOnTheAir());
        final resultList = result.getOrElse(() => []);
        expect(resultList, tTvList);
      });

      test(
          'should return server failure  when the call to remote data source is unsuccessful',
          () async {
        when(mockTVRemoteDataSource.getTvSeriesOnTheAir())
            .thenThrow(ServerException());

        final result = await repository.getTvSeriesOnTheAir();

        verify(mockTVRemoteDataSource.getTvSeriesOnTheAir());

        expect(result, equals(Left(ServerFailure(''))));
      });
    });

    group('When device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return cached data when device is offline', () async {
        when(mockTvLocalDataSource.getCachedNowPlayingTv())
            .thenAnswer((_) async => [testTvCache]);

        final result = await repository.getTvSeriesOnTheAir();

        verify(mockTvLocalDataSource.getCachedNowPlayingTv());
        final resultList = result.getOrElse(() => []);

        expect(resultList, [testTvFromCache]);
      });

      test('should return list of Tv Series from db when data exist', () async {
        when(mockDatabaseHelper.getCacheTv('on the air'))
            .thenAnswer((_) async => [testTvCacheMap]);
        final result = await repository.getCachedNowPlayingTv();
        expect(result, [testTvCache]);
      });

      test('should throw CacheException when cache data is not exist',
          () async {
        when(mockDatabaseHelper.getCacheTv('on the air'))
            .thenAnswer((_) async => []);

        final call = repository.getCachedNowPlayingTv();
        expect(() => call, throwsA(isA<CacheException>()));
      });

      test('should call database helper to save data', () async {
        when(mockDatabaseHelper.clearCache('on the air'))
            .thenAnswer((_) async => 1);
        await repository.cacheNowPlayingTv([testTvCache]);
        verify(mockDatabaseHelper.clearCache('on the air'));
        verify(mockDatabaseHelper
            .insertCacheTvTransaction([testTvCache], 'on the air'));
      });

      test('should return cached data when device is offline', () async {
        when(mockTvLocalDataSource.getCachedNowPlayingTv())
            .thenAnswer((_) async => [testTvCache]);
        final result = await repository.getTvSeriesOnTheAir();
        verify(mockTvLocalDataSource.getCachedNowPlayingTv());

        final resultList = result.getOrElse(() => []);

        expect(resultList, [testTvFromCache]);
      });

      test('should return CacheFailure when app has no cache', () async {
        when(mockTvLocalDataSource.getCachedNowPlayingTv())
            .thenThrow(CacheException('No Cache'));
        final result = await repository.getTvSeriesOnTheAir();

        verify(mockTvLocalDataSource.getCachedNowPlayingTv());
        expect(result, Left(CacheFailure('No Cache')));
      });
    });
  });

  group('Tv Series : Popular Show', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      when(mockTVRemoteDataSource.getTVSeriesPopuler())
          .thenAnswer((_) async => tTvModelList);

      final result = await repository.getTvSeriesPopuler();

      verify(mockTVRemoteDataSource.getTVSeriesPopuler());
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'should return server failure  when the call to remote data source is unsuccessful',
        () async {
      when(mockTVRemoteDataSource.getTVSeriesPopuler())
          .thenThrow(ServerException());

      final result = await repository.getTvSeriesPopuler();

      verify(mockTVRemoteDataSource.getTVSeriesPopuler());

      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure  when the device is not connected to the internet',
        () async {
      when(mockTVRemoteDataSource.getTVSeriesPopuler())
          .thenThrow(SocketException('Failed connect to the network'));

      final result = await repository.getTvSeriesPopuler();

      verify(mockTVRemoteDataSource.getTVSeriesPopuler());

      expect(result,
          equals(Left(ConnectionFailure('Failed connect to the network'))));
    });
  });

  group('Tv Series : Top Rated', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      when(mockTVRemoteDataSource.getTvSeriesTopRated())
          .thenAnswer((_) async => tTvModelList);

      final result = await repository.getTvTopRated();

      verify(mockTVRemoteDataSource.getTvSeriesTopRated());
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'should return server failure  when the call to remote data source is unsuccessful',
        () async {
      when(mockTVRemoteDataSource.getTvSeriesTopRated())
          .thenThrow(ServerException());

      final result = await repository.getTvTopRated();

      verify(mockTVRemoteDataSource.getTvSeriesTopRated());

      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure  when the device is not connected to the internet',
        () async {
      when(mockTVRemoteDataSource.getTvSeriesTopRated())
          .thenThrow(SocketException('Failed connect to the network'));

      final result = await repository.getTvTopRated();

      verify(mockTVRemoteDataSource.getTvSeriesTopRated());

      expect(result,
          equals(Left(ConnectionFailure('Failed connect to the network'))));
    });
  });

  group('Tv Series :  Detail', () {
    final tId = 2;
    final tTvDetailModel = TvDetailModel(
      adult: false,
      backdropPath: "/7M0huD4pLqe15c3VSxBMCqzFMSW.jpg",
      createdBy: <dynamic>[
        {
          "id": 19303,
          "credit_id": "52532e3219c29579400013ab",
          "name": "Kevin Smith",
          "gender": 2,
          "profile_path": "/uxDQ0NTZMnOuAaPa0tQzMFV9dx4.jpg"
        },
        {
          "id": 20503,
          "credit_id": "52532e3219c29579400013a5",
          "name": "Scott Mosier",
          "gender": 2,
          "profile_path": "/oEQcuNy9uYGMNq3e49VSJ7oPsJw.jpg"
        },
        {
          "id": 57407,
          "credit_id": "52532e3219c295794000136f",
          "name": "David Mandel",
          "gender": 2,
          "profile_path": "/beom0HmSu1sP5YWo6JHETDFtTj0.jpg"
        }
      ],
      episodeRunTime: [22],
      firstAirDate: DateTime.tryParse("2000-05-31"),
      genres: [TVGenreModel(id: 16, name: "Animation")],
      homepage: '',
      id: 2,
      inProduction: false,
      languages: ["en"],
      lastAirDate: DateTime.tryParse("2002-12-22"),
      lastEpisodeToAir: TEpisodeToAirModel(
        id: 1130478,
        name: "The Last Episode Ever!",
        overview:
            "The guys' day slacking off at the Quick Stop is derailed by a spoof of \"The Matrix,\" a carnival riot and a trip through the minds of their illustrators.",
        voteAverage: 6.8,
        voteCount: 4,
        airDate: DateTime.tryParse("2002-12-22"),
        episodeNumber: 6,
        episodeType: "finale",
        productionCode: "",
        runtime: 22,
        seasonNumber: 1,
        showId: 2,
        stillPath: "/xhbjqZWbMaHKGdvm9M46JN0crRV.jpg",
      ),
      name: "Clerks",
      nextEpisodeToAir: null,
      numberOfEpisodes: 6,
      numberOfSeasons: 1,
      originCountry: ["US"],
      originalLanguage: "United States of America",
      originalName: "Clerks",
      overview:
          "The guys' day slacking off at the Quick Stop is derailed by a spoof of \"The Matrix,\" a carnival riot and a trip through the minds of their illustrators.",
      popularity: 16.885,
      posterPath: "/xunXvzFlkf1GGgMkCySA9CCFumB.jpg",
      productionCompanies: null,
      productionCountries: [
        TvProductionCountryModel(
            iso31661: "US", name: "United States of America")
      ],
      seasons: [
        TVSeasonModel(
          airDate: null,
          episodeCount: 7,
          id: 2328128,
          name: "Specials",
          overview: "",
          posterPath: null,
          seasonNumber: 0,
          voteAverage: 0,
        ),
        TVSeasonModel(
          airDate: DateTime.tryParse("2000-05-31"),
          episodeCount: 6,
          id: 2328127,
          name: "Season 1",
          overview: "",
          posterPath: "/qhKzJcAz9AhxZstTAsLu2lulbVY.jpg",
          seasonNumber: 1,
          voteAverage: 7.1,
        ),
      ],
      spokenLanguages: [
        SpokenLanguageModel(
          englishName: "English",
          iso6391: "en",
          name: "English",
        ),
      ],
      status: "Canceled",
      tagline: "",
      type: "Scripted",
      voteAverage: 7.012,
      voteCount: 86,
    );

    test(
        'should return TV Show Detail data when the call to remote data source is successful',
        () async {
      when(mockTVRemoteDataSource.getTvDetail(tId))
          .thenAnswer((_) async => tTvDetailModel);

      final result = await repository.getTvDetail(tId);

      verify(mockTVRemoteDataSource.getTvDetail(tId));

      expect(result, equals(Right(tTvDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      when(mockTVRemoteDataSource.getTvDetail(tId))
          .thenThrow(ServerException());

      final result = await repository.getTvDetail(tId);

      verify(mockTVRemoteDataSource.getTvDetail(tId));

      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return Connection Failure when the device is not connected to the internet',
        () async {
      when(mockTVRemoteDataSource.getTvDetail(tId))
          .thenThrow(SocketException('Failed connect to the network'));

      final result = await repository.getTvDetail(tId);

      verify(mockTVRemoteDataSource.getTvDetail(tId));

      expect(result,
          equals(Left(ConnectionFailure('Failed connect to the network'))));
    });
  });
  group('Tv Series : Search TV Shows', () {
    final tQuery = 'tagesschau';

    test('should return Tv Shows list when call to data source is successful',
        () async {
      when(mockTVRemoteDataSource.searchTvShow(tQuery))
          .thenAnswer((_) async => tTvModelList);

      final result = await repository.searchTvShow(tQuery);

      final resultList = result.getOrElse(() => []);

      expect(resultList, tTvList);
    });

    test(
        'should return Server Failure  when call to data source is unsuccessful',
        () async {
      when(mockTVRemoteDataSource.searchTvShow(tQuery))
          .thenThrow(ServerException());

      final result = await repository.searchTvShow(tQuery);

      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return Connection failure  when device is not connected to the internet',
        () async {
      when(mockTVRemoteDataSource.searchTvShow(tQuery))
          .thenThrow(SocketException('Failed connect to the network'));

      final result = await repository.searchTvShow(tQuery);

      expect(result, Left(ConnectionFailure('Failed connect to the network')));
    });
  });

  group('TV Series : Save Watchlist', () {
    test('should return success message when saving successful', () async {
      when(mockTvLocalDataSource.insertTvWatchlist(testTvTable))
          .thenAnswer((_) async => 'Added to Watchlist');

      final result = await repository.saveWatchListTv(testTVDetail);

      expect(result, Right('Added to Watchlist'));
    });
    test('should return DatabaseFailure when saving unsuccessful', () async {
      when(mockTvLocalDataSource.insertTvWatchlist(testTvTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));

      final result = await repository.saveWatchListTv(testTVDetail);

      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('TV Series : Remove Watchlist', () {
    test('should return success message when saving successful', () async {
      when(mockTvLocalDataSource.removeTvWatchlist(testTvTable))
          .thenAnswer((_) async => 'Removed from watchlist');

      final result = await repository.removeWatchlist(testTVDetail);

      expect(result, Right('Removed from watchlist'));
    });
    test('should return DatabaseFailure when saving unsuccessful', () async {
      when(mockTvLocalDataSource.removeTvWatchlist(testTvTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));

      final result = await repository.removeWatchlist(testTVDetail);

      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('TV Series : Get watchlist status', () {
    test('should return watch status wheter data is found', () async {
      final tId = 1;
      when(mockTvLocalDataSource.getTvById(tId)).thenAnswer((_) async => null);

      final result = await repository.isAddedtoWatchList(tId);

      expect(result, false);
    });
  });

  group('TV Series : Get watchlist ', () {
    test('should return list of Tv Series', () async {
      when(mockTvLocalDataSource.getWatchlistTvSeries())
          .thenAnswer((_) async => [testTvTable]);

      final result = await repository.getWatchlistTv();
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTV]);
    });
  });

  group('Get TV Recomendations', () {
    final tTvList = <TvModel>[];
    final tId = 1;

    test('should return data (tv List) when the call is successful', () async {
      when(mockTVRemoteDataSource.getTvRecomendations(tId))
          .thenAnswer((_) async => tTvList);

      final result = await repository.getTvRecomendations(tId);

      verify(mockTVRemoteDataSource.getTvRecomendations(tId));

      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTvList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      when(mockTVRemoteDataSource.getTvRecomendations(tId))
          .thenThrow(ServerException());

      final result = await repository.getTvRecomendations(tId);

      verify(mockTVRemoteDataSource.getTvRecomendations(tId));

      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      when(mockTVRemoteDataSource.getTvRecomendations(tId))
          .thenThrow(SocketException('Failed connect to the network'));

      final result = await repository.getTvRecomendations(tId);
      verify(mockTVRemoteDataSource.getTvRecomendations(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed connect to the network'))));
    });
  });

  group('Search Tv Show', () {
    final tQuery = 'breaking bad';

    test('should return movie list when call to data source is successful',
        () async {
      when(mockTVRemoteDataSource.searchTvShow(tQuery))
          .thenAnswer((_) async => tTvModelList);

      final result = await repository.searchTvShow(tQuery);

      final resultList = result.getOrElse(() => []);

      expect(resultList, tTvList);
    });

    test(
        'should return Server Failure when call to data source is unsuccessfull',
        () async {
      when(mockTVRemoteDataSource.searchTvShow(tQuery))
          .thenThrow(ServerException());

      final result = await repository.searchTvShow(tQuery);

      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return Connection Failure when device is not connected to the internet',
        () async {
      when(mockTVRemoteDataSource.searchTvShow(tQuery))
          .thenThrow(SocketException('Failed connect to the network'));

      final result = await repository.searchTvShow(tQuery);
      expect(result, Left(ConnectionFailure('Failed connect to the network')));
    });
  });

  group('Tv Series : save watchlist', () {
    test('should return success message when saving succesful', () async {
      when(mockTvLocalDataSource.insertTvWatchlist(testTvTable))
          .thenAnswer((_) async => 'Added to Watchlist');
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      when(mockTvLocalDataSource.insertTvWatchlist(testTvTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));

      final result = await repository.saveWatchListTv(testTVDetail);

      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('Tv Series : remove watchlist', () {
    test('should return success message when saving succesful', () async {
      when(mockTvLocalDataSource.removeTvWatchlist(testTvTable))
          .thenAnswer((_) async => 'Removed from Watchlist');
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      when(mockTvLocalDataSource.removeTvWatchlist(testTvTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));

      final result = await repository.removeWatchlist(testTVDetail);

      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });
}

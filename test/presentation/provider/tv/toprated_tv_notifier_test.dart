import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tvseries/get_tv_toprated.dart';
import 'package:ditonton/presentation/provider/tv/top_rated_tv_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([GetTvTopRated])
void main() {
  late MockGetTvTopRated mockGetTvTopRated;
  late TopRatedTvNotifier provider;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvTopRated = MockGetTvTopRated();
    provider = TopRatedTvNotifier(mockGetTvTopRated)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tTv = Tv(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'name',
    originCountry: ['US'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  final tTvList = <Tv>[tTv];

  group('TV Series : Top Rated', () {
    test('should change state to loading when usecase is called', () async {
      when(mockGetTvTopRated.execute()).thenAnswer((_) async => Right(tTvList));

      provider.fetchTopRatedTv();
      expect(provider.state, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change tv show data when data is gotten successfully',
        () async {
      when(mockGetTvTopRated.execute()).thenAnswer((_) async => Right(tTvList));

      await provider.fetchTopRatedTv();
      expect(provider.state, RequestState.Loaded);
      expect(provider.tvTopRated, tTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      when(mockGetTvTopRated.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      await provider.fetchTopRatedTv();

      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}

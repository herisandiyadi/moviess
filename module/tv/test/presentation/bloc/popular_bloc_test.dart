import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/tvseries/get_tv_series_populer.dart';
import 'package:tv/presentation/bloc/popular/popular_bloc.dart';

import '../../dummy_data/dummy_tv_objects.dart';
import 'popular_bloc_test.mocks.dart';

@GenerateMocks([GetTVSeriesPopuler])
void main() {
  late PopularTvBloc popularTvBloc;
  late MockGetTVSeriesPopuler mockGetTVSeriesPopuler;

  setUp(() {
    mockGetTVSeriesPopuler = MockGetTVSeriesPopuler();
    popularTvBloc = PopularTvBloc(getTVSeriesPopuler: mockGetTVSeriesPopuler);
  });

  test('State Initial should be empty', () {
    expect(popularTvBloc.state, PopularInitial());
  });

  final tTvList = <Tv>[tTvShow];

  blocTest<PopularTvBloc, PopularState>(
    'Should emit Loading & Success when data is gotten succesfully',
    build: () {
      when(mockGetTVSeriesPopuler.execute())
          .thenAnswer((_) async => Right(tTvList));
      return popularTvBloc;
    },
    act: (bloc) => bloc.add(const FetchPopularTv()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      PopularLoading(),
      PopularSuccess(tTvList),
    ],
    verify: (_) => [
      verify(mockGetTVSeriesPopuler.execute()),
      const FetchPopularTv().props
    ],
  );

  blocTest<PopularTvBloc, PopularState>(
    'Should emit Loading & Failed when data is gotten unsuccesfully',
    build: () {
      when(mockGetTVSeriesPopuler.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return popularTvBloc;
    },
    act: (bloc) => bloc.add(const FetchPopularTv()),
    expect: () => [
      PopularLoading(),
      const PopularFailed('Server Failure'),
    ],
    verify: (bloc) => [
      verify(mockGetTVSeriesPopuler.execute()),
      const FetchPopularTv().props,
    ],
  );
}

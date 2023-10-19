import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/tvseries/get_tv_toprated.dart';
import 'package:tv/presentation/bloc/top_rated_tv/top_rated_tv_bloc.dart';

import '../../dummy_data/dummy_tv_objects.dart';
import 'top_rated_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTvTopRated])
void main() {
  late TopRatedTvBloc topRatedTvBloc;
  late MockGetTvTopRated mockGetTvTopRated;

  setUp(() {
    mockGetTvTopRated = MockGetTvTopRated();
    topRatedTvBloc = TopRatedTvBloc(getTvTopRated: mockGetTvTopRated);
  });

  test('State Initial should be empty', () {
    expect(topRatedTvBloc.state, TopRatedTvInitial());
  });

  final tTvList = <Tv>[tTvShow];

  blocTest<TopRatedTvBloc, TopRatedTvState>(
    'Should emit Loading & Success when data is gotten succesfully',
    build: () {
      when(mockGetTvTopRated.execute()).thenAnswer((_) async => Right(tTvList));
      return topRatedTvBloc;
    },
    act: (bloc) => bloc.add(const FetchTopRatedTv()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      TopRatedTvLoading(),
      TopRatedTvSuccess(tTvList),
    ],
    verify: (_) =>
        [verify(mockGetTvTopRated.execute()), const FetchTopRatedTv().props],
  );

  blocTest<TopRatedTvBloc, TopRatedTvState>(
    'Should emit Loading & Failed when data is gotten unsuccesfully',
    build: () {
      when(mockGetTvTopRated.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return topRatedTvBloc;
    },
    act: (bloc) => bloc.add(const FetchTopRatedTv()),
    expect: () => [
      TopRatedTvLoading(),
      const TopRatedTvFailed('Server Failure'),
    ],
    verify: (bloc) => [
      verify(mockGetTvTopRated.execute()),
      const FetchTopRatedTv().props,
    ],
  );
}

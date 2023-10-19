import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/tvseries/get_tv_series_ontheair.dart';
import 'package:tv/presentation/bloc/on_the_air/on_the_air_bloc.dart';

import '../../dummy_data/dummy_tv_objects.dart';
import 'on_the_air_bloc_test.mocks.dart';

@GenerateMocks([GetTvSeriesOnTheAir])
void main() {
  late OnTheAirBloc onTheAirBloc;
  late MockGetTvSeriesOnTheAir mockGetTvSeriesOnTheAir;

  setUp(() {
    mockGetTvSeriesOnTheAir = MockGetTvSeriesOnTheAir();
    onTheAirBloc = OnTheAirBloc(getOnTheAir: mockGetTvSeriesOnTheAir);
  });

  test('State Initial should be empty', () {
    expect(onTheAirBloc.state, OnTheAirInitial());
  });

  final tTvList = <Tv>[tTvShow];

  blocTest<OnTheAirBloc, OnTheAirState>(
    'Should emit Loading & Success when data is gotten successfully',
    build: () {
      when(mockGetTvSeriesOnTheAir.execute())
          .thenAnswer((_) async => Right(tTvList));
      return onTheAirBloc;
    },
    act: (bloc) => bloc.add(const FetchOnTheAirTv()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      OnTheAirLoading(),
      OnTheAirSuccess(tTvList),
    ],
    verify: (_) => [
      verify(mockGetTvSeriesOnTheAir.execute()),
      const FetchOnTheAirTv(),
    ],
  );

  blocTest<OnTheAirBloc, OnTheAirState>(
    'Should emit Loading & Error when data is gotten unsuccessfully',
    build: () {
      when(mockGetTvSeriesOnTheAir.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return onTheAirBloc;
    },
    act: (bloc) => bloc.add(const FetchOnTheAirTv()),
    wait: const Duration(milliseconds: 100),
    expect: () => [OnTheAirLoading(), const OnTheAirFailed('Server Failure')],
    verify: (_) => [
      verify(mockGetTvSeriesOnTheAir.execute()),
      const FetchOnTheAirTv(),
    ],
  );
}

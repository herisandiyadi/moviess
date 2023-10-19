import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/presentation/bloc/detail_movie/detail_movie_bloc.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockDetailMovieBloc extends MockBloc<DetailMovieEvent, DetailMovieState>
    implements DetailMovieBloc {}

class FakeDetailMovieEvent extends Fake implements DetailMovieEvent {}

class FakeDetailMovieState extends Fake implements DetailMovieState {}

void main() {
  late MockDetailMovieBloc mockDetailMovieBloc;

  setUpAll(() {
    registerFallbackValue(FakeDetailMovieEvent());
    registerFallbackValue(FakeDetailMovieState());
  });

  setUp(() {
    mockDetailMovieBloc = MockDetailMovieBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<DetailMovieBloc>.value(
      value: mockDetailMovieBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(
      () => mockDetailMovieBloc.state,
    ).thenReturn(DetailMovieState.initial().copyWith(
      detailState: RequestState.Loaded,
      movieDetail: testMovieDetail,
      recommendationsState: RequestState.Loaded,
      movieRecommendations: [],
      isAddedToWatchlist: false,
    ));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));
    await tester.pump();

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to watchlist',
      (WidgetTester tester) async {
    when(
      () => mockDetailMovieBloc.state,
    ).thenReturn(
      DetailMovieState.initial().copyWith(
        detailState: RequestState.Loaded,
        movieDetail: testMovieDetail,
        recommendationsState: RequestState.Loaded,
        movieRecommendations: [testMovie],
        isAddedToWatchlist: true,
      ),
    );

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));
    await tester.pump();

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    whenListen(
      mockDetailMovieBloc,
      Stream.fromIterable(
        [
          DetailMovieState.initial().copyWith(
            isAddedToWatchlist: false,
          ),
          DetailMovieState.initial().copyWith(
            isAddedToWatchlist: false,
            watchlistMessage: 'Added to Watchlist',
          )
        ],
      ),
      initialState: DetailMovieState.initial(),
    );

    final snackbar = find.byType(SnackBar);
    final textMessage = find.text('Added to Watchlist');

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(snackbar, findsNothing);
    expect(textMessage, findsNothing);

    await tester.pump();

    expect(snackbar, findsOneWidget);
    expect(textMessage, findsOneWidget);
  });
}

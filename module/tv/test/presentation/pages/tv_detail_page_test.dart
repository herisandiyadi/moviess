import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/bloc/detail_tv/detail_tv_bloc.dart';
import 'package:tv/presentation/pages/tv/tv_detail_page.dart';

import '../../dummy_data/dummy_tv_objects.dart';

class MockDetailTvBloc extends MockBloc<DetailTvEvent, DetailTvState>
    implements DetailTvBloc {}

class FakeDetailTvEvent extends Fake implements DetailTvEvent {}

class FakeDetailTvState extends Fake implements DetailTvState {}

void main() {
  late MockDetailTvBloc mockDetailTvBloc;

  setUpAll(() {
    registerFallbackValue(FakeDetailTvEvent());
    registerFallbackValue(FakeDetailTvState());
  });

  setUp(() {
    mockDetailTvBloc = MockDetailTvBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<DetailTvBloc>.value(
      value: mockDetailTvBloc,
      child: MaterialApp(home: body),
    );
  }

  group('Detail TV Show Page : ', () {
    testWidgets(
        'Wathclist button should display check icon when movie is added to watchlist',
        (widgetTester) async {
      when(
        () => mockDetailTvBloc.state,
      ).thenReturn(
        DetailTvState.initial().copyWith(
          detailState: RequestState.Loaded,
          tvDetail: testTVDetail,
          recommendationState: RequestState.Loaded,
          tvRecommendations: [],
          isAddedtoWatchlist: false,
        ),
      );

      final watchlistButtonIcon = find.byIcon(Icons.add);

      await widgetTester
          .pumpWidget(makeTestableWidget(const TvShowDetailPage(id: 1)));
      await widgetTester.pump();

      await widgetTester.tap(find.byType(ElevatedButton));
      await widgetTester.pump();

      expect(watchlistButtonIcon, findsOneWidget);
    });

    testWidgets(
        'Watchlist button should display Snackbar when added to watchlist',
        (WidgetTester tester) async {
      whenListen(
        mockDetailTvBloc,
        Stream.fromIterable(
          [
            DetailTvState.initial().copyWith(
              isAddedtoWatchlist: false,
            ),
            DetailTvState.initial().copyWith(
              isAddedtoWatchlist: false,
              watchlistMessage: 'Added to Watchlist',
            )
          ],
        ),
        initialState: DetailTvState.initial(),
      );

      final snackbar = find.byType(SnackBar);
      final textMessage = find.text('Added to Watchlist');

      await tester
          .pumpWidget(makeTestableWidget(const TvShowDetailPage(id: 1)));

      expect(snackbar, findsNothing);
      expect(textMessage, findsNothing);

      await tester.pump();

      expect(snackbar, findsOneWidget);
      expect(textMessage, findsOneWidget);
    });
  });
}

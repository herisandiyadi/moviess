import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/pages/tv/tv_detail_page.dart';
import 'package:ditonton/presentation/provider/tv/tv_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../../dummy_data/dummy_tv_objects.dart';
import 'tv_detail_page_test.mocks.dart';

@GenerateMocks([TvDetailNotifier])
void main() {
  late MockTvDetailNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTvDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(home: body),
    );
  }

  group('Detail TV Show Page : ', () {
    testWidgets(
        'Wathclist button should display check icon when movie is added to watchlist',
        (widgetTester) async {
      when(mockNotifier.tvState).thenReturn(RequestState.Loaded);
      when(mockNotifier.tvDetail).thenReturn(testTVDetail);

      when(mockNotifier.recomendationState).thenReturn(RequestState.Loaded);

      when(mockNotifier.tvRecomendations).thenReturn(<Tv>[]);
      when(mockNotifier.isAddedtoWatchList).thenReturn(true);

      final watchlistButtonIcon = find.byIcon(Icons.check);

      await widgetTester
          .pumpWidget(_makeTestableWidget(TvShowDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    });

    testWidgets(
        'Watchlist button should display Snackbar when added to watchlist',
        (widgetTester) async {
      when(mockNotifier.tvState).thenReturn(RequestState.Loaded);
      when(mockNotifier.tvDetail).thenReturn(testTVDetail);
      when(mockNotifier.recomendationState).thenReturn(RequestState.Loaded);
      when(mockNotifier.tvRecomendations).thenReturn(<Tv>[]);
      when(mockNotifier.isAddedtoWatchList).thenReturn(false);
      when(mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');

      final watchlistButton = find.byType(ElevatedButton);

      await widgetTester
          .pumpWidget(_makeTestableWidget(TvShowDetailPage(id: 1)));

      expect(find.byIcon(Icons.add), findsOneWidget);

      await widgetTester.tap(watchlistButton);
      await widgetTester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Added to Watchlist'), findsOneWidget);
    });

    testWidgets(
        'Watchlist button should display AlertDialog when add to watchlist failed',
        (widgetTester) async {
      when(mockNotifier.tvState).thenReturn(RequestState.Loaded);
      when(mockNotifier.tvDetail).thenReturn(testTVDetail);
      when(mockNotifier.recomendationState).thenReturn(RequestState.Loaded);
      when(mockNotifier.tvRecomendations).thenReturn(<Tv>[]);
      when(mockNotifier.isAddedtoWatchList).thenReturn(false);
      when(mockNotifier.watchlistMessage).thenReturn('Failed');

      final watchlistButton = find.byType(ElevatedButton);

      await widgetTester
          .pumpWidget(_makeTestableWidget(TvShowDetailPage(id: 1)));

      expect(find.byIcon(Icons.add), findsOneWidget);

      await widgetTester.tap(watchlistButton);
      await widgetTester.pump();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Failed'), findsOneWidget);
    });
  });
}

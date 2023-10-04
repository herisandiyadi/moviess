import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/pages/tv/top_rated_tv_page.dart';
import 'package:ditonton/presentation/provider/tv/top_rated_tv_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'top_rated_tv_page_test.mocks.dart';

@GenerateMocks([TopRatedTvNotifier])
void main() {
  late MockTopRatedTvNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTopRatedTvNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TopRatedTvNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(home: body),
    );
  }

  group('Top Rated TV Page : ', () {
    testWidgets('Page should display progress bar when loading',
        (widgetTester) async {
      when(mockNotifier.state).thenReturn(RequestState.Loading);

      final progressFinder = find.byType(CircularProgressIndicator);

      final centerFinder = find.byType(Center);

      await widgetTester.pumpWidget(_makeTestableWidget(TopRatedTvPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressFinder, findsOneWidget);
    });

    testWidgets('Page should display when data is loaded',
        (widgetTester) async {
      when(mockNotifier.state).thenReturn(RequestState.Loaded);
      when(mockNotifier.tvTopRated).thenReturn(<Tv>[]);

      final listViewFinder = find.byType(ListView);
      await widgetTester.pumpWidget(_makeTestableWidget(TopRatedTvPage()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when error',
        (widgetTester) async {
      when(mockNotifier.state).thenReturn(RequestState.Error);
      when(mockNotifier.message).thenReturn('Error message');
      final textFinder = find.byKey(Key('error_message'));

      await widgetTester.pumpWidget(_makeTestableWidget(TopRatedTvPage()));

      expect(textFinder, findsOneWidget);
    });
  });
}

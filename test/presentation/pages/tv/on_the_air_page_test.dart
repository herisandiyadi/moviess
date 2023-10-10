import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/presentation/pages/tv/on_the_air_page.dart';
import 'package:ditonton/presentation/provider/tv/on_the_air_notifier.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'on_the_air_page_test.mocks.dart';

@GenerateMocks([OnTheAirNotifier])
void main() {
  late MockOnTheAirNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockOnTheAirNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<OnTheAirNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('On The Air TV Page : ', () {
    testWidgets('Page should display center progress bar when loading',
        (widgetTester) async {
      when(mockNotifier.state).thenReturn(RequestState.Loading);
      final centerFinder = find.byType(Center);
      final progressBarFinder = find.byType(CircularProgressIndicator);

      await widgetTester.pumpWidget(_makeTestableWidget(OnTheAirPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsWidgets);
    });

    testWidgets('Page should display ListView when data is loaded',
        (widgetTester) async {
      when(mockNotifier.state).thenReturn(RequestState.Loaded);
      when(mockNotifier.tvShow).thenReturn(<Tv>[]);
      final listViewFinder = find.byType(ListView);

      await widgetTester.pumpWidget(_makeTestableWidget(OnTheAirPage()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Error',
        (widgetTester) async {
      when(mockNotifier.state).thenReturn(RequestState.Error);
      when(mockNotifier.message).thenReturn('Error message');

      final textFinder = find.byKey(Key('error_message'));

      await widgetTester.pumpWidget(_makeTestableWidget(OnTheAirPage()));

      expect(textFinder, findsOneWidget);
    });
  });
}

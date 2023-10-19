import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/bloc/on_the_air/on_the_air_bloc.dart';
import 'package:tv/presentation/pages/tv/on_the_air_page.dart';
import '../../dummy_data/dummy_tv_objects.dart';

class MockOnTheAirBloc extends MockBloc<OnTheAirEvent, OnTheAirState>
    implements OnTheAirBloc {}

class FakeOnTheAirEvent extends Fake implements OnTheAirEvent {}

class FakeOnTheAirState extends Fake implements OnTheAirState {}

void main() {
  late MockOnTheAirBloc mockOnTheAirBloc;

  setUpAll(() {
    registerFallbackValue(FakeOnTheAirEvent());
    registerFallbackValue(FakeOnTheAirState());
  });

  setUp(() {
    mockOnTheAirBloc = MockOnTheAirBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<OnTheAirBloc>.value(
      value: mockOnTheAirBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('On The Air TV Page : ', () {
    testWidgets('Page should display center progress bar when loading',
        (widgetTester) async {
      when(
        () => mockOnTheAirBloc.state,
      ).thenReturn(OnTheAirLoading());

      final centerFinder = find.byType(Center);
      final progressBarFinder = find.byType(CircularProgressIndicator);

      await widgetTester.pumpWidget(makeTestableWidget(const OnTheAirPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsWidgets);
    });

    testWidgets('Page should display ListView when data is loaded',
        (widgetTester) async {
      when(
        () => mockOnTheAirBloc.state,
      ).thenReturn(const OnTheAirSuccess([tTvShow]));

      final listViewFinder = find.byType(ListView);

      await widgetTester.pumpWidget(makeTestableWidget(const OnTheAirPage()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Error',
        (widgetTester) async {
      when(
        () => mockOnTheAirBloc.state,
      ).thenReturn(const OnTheAirFailed('Error message'));

      final textFinder = find.byKey(const Key('error_message'));

      await widgetTester.pumpWidget(makeTestableWidget(const OnTheAirPage()));

      expect(textFinder, findsOneWidget);
    });
  });
}

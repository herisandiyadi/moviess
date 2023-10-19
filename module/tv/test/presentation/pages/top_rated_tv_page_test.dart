import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/bloc/top_rated_tv/top_rated_tv_bloc.dart';
import 'package:tv/presentation/pages/tv/top_rated_tv_page.dart';
import '../../dummy_data/dummy_tv_objects.dart';

class MockTopRatedTvBloc extends MockBloc<TopRatedTvEvent, TopRatedTvState>
    implements TopRatedTvBloc {}

class FakeTopRatedTvEvent extends Fake implements TopRatedTvEvent {}

class FakeTopRatedTvState extends Fake implements TopRatedTvState {}

void main() {
  late MockTopRatedTvBloc mockTopRatedTvBloc;

  setUpAll(() {
    registerFallbackValue(FakeTopRatedTvEvent());
    registerFallbackValue(FakeTopRatedTvState());
  });

  setUp(() {
    mockTopRatedTvBloc = MockTopRatedTvBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvBloc>.value(
      value: mockTopRatedTvBloc,
      child: MaterialApp(home: body),
    );
  }

  group('Top Rated TV Page : ', () {
    testWidgets('Page should display progress bar when loading',
        (widgetTester) async {
      when(
        () => mockTopRatedTvBloc.state,
      ).thenReturn(TopRatedTvLoading());

      final progressFinder = find.byType(CircularProgressIndicator);

      final centerFinder = find.byType(Center);

      await widgetTester.pumpWidget(makeTestableWidget(const TopRatedTvPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressFinder, findsOneWidget);
    });

    testWidgets('Page should display when data is loaded',
        (widgetTester) async {
      when(
        () => mockTopRatedTvBloc.state,
      ).thenReturn(const TopRatedTvSuccess([tTvShow]));

      final listViewFinder = find.byType(ListView);
      await widgetTester.pumpWidget(makeTestableWidget(const TopRatedTvPage()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when error',
        (widgetTester) async {
      when(
        () => mockTopRatedTvBloc.state,
      ).thenReturn(const TopRatedTvFailed('Error message'));
      final textFinder = find.byKey(const Key('error_message'));

      await widgetTester.pumpWidget(makeTestableWidget(const TopRatedTvPage()));

      expect(textFinder, findsOneWidget);
    });
  });
}

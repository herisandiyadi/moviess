import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/bloc/popular/popular_bloc.dart';
import 'package:tv/presentation/pages/tv/popular_tv_page.dart';
import '../../dummy_data/dummy_tv_objects.dart';

class MockPopularTvBloc extends MockBloc<PopularEvent, PopularState>
    implements PopularTvBloc {}

class FakePopularTvEvent extends Fake implements PopularEvent {}

class FakePopularTvState extends Fake implements PopularState {}

void main() {
  late MockPopularTvBloc mockPopularTvBloc;

  setUpAll(() {
    registerFallbackValue(FakePopularTvEvent());
    registerFallbackValue(FakePopularTvState());
  });

  setUp(() {
    mockPopularTvBloc = MockPopularTvBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvBloc>.value(
      value: mockPopularTvBloc,
      child: MaterialApp(home: body),
    );
  }

  group('Popular TV Page : ', () {
    testWidgets('Page should display center progress bar when loading',
        (widgetTester) async {
      when(
        () => mockPopularTvBloc.state,
      ).thenReturn(PopularLoading());
      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await widgetTester.pumpWidget(makeTestableWidget(const PopularTvPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should display ListView when data is loaded',
        (widgetTester) async {
      when(
        () => mockPopularTvBloc.state,
      ).thenReturn(const PopularSuccess([tTvShow]));

      final listViewFinder = find.byType(ListView);

      await widgetTester.pumpWidget(makeTestableWidget(const PopularTvPage()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('Page should display text with message when Error',
        (widgetTester) async {
      when(
        () => mockPopularTvBloc.state,
      ).thenReturn(const PopularFailed('Error message'));

      final textFinder = find.byKey(const Key('error_message'));

      await widgetTester.pumpWidget(makeTestableWidget(const PopularTvPage()));

      expect(textFinder, findsOneWidget);
    });
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/presentation/bloc/popular/popular_bloc.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockPopularMoviesBloc extends MockBloc<PopularEvent, PopularState>
    implements PopularBloc {}

class FakePopularMoviesEvent extends Fake implements PopularEvent {}

class FakePopularMoviesState extends Fake implements PopularState {}

void main() {
  late MockPopularMoviesBloc mockPopularMoviesBloc;

  setUpAll(() {
    registerFallbackValue(FakePopularMoviesEvent());
    registerFallbackValue(FakePopularMoviesState());
  });

  setUp(() {
    mockPopularMoviesBloc = MockPopularMoviesBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<PopularBloc>.value(
      value: mockPopularMoviesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(
      () => mockPopularMoviesBloc.state,
    ).thenReturn(PopularLoading());
    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(
      () => mockPopularMoviesBloc.state,
    ).thenReturn(const PopularSuccess([testMovie]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(
      () => mockPopularMoviesBloc.state,
    ).thenReturn(const PopularFailed('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}

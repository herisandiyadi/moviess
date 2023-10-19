import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/presentation/bloc/now_playing_movies/now_playing_movies_bloc.dart';
import 'package:movie/presentation/pages/now_playing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../dummy_data/dummy_objects.dart';

class MockNowPlayingMoviesBloc
    extends MockBloc<NowPlayingMoviesEvent, NowPlayingMoviesState>
    implements NowPlayingMoviesBloc {}

class FakeNowPlayingMoviesEvent extends Fake implements NowPlayingMoviesEvent {}

class FakeNowPlayingMoviesState extends Fake implements NowPlayingMoviesState {}

void main() {
  late MockNowPlayingMoviesBloc mockNowPlayingMoviesBloc;

  setUpAll(() {
    registerFallbackValue(FakeNowPlayingMoviesEvent());
    registerFallbackValue(FakeNowPlayingMoviesState());
  });

  setUp(() {
    mockNowPlayingMoviesBloc = MockNowPlayingMoviesBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<NowPlayingMoviesBloc>.value(
      value: mockNowPlayingMoviesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(
      () => mockNowPlayingMoviesBloc.state,
    ).thenReturn(NowPlayingMoviesLoading());

    final centerFinder = find.byKey(const Key('nowplaying-center'));
    final progressBarFinder = find.byKey(const Key('nowplaying-circullar'));

    await tester.pumpWidget(makeTestableWidget(const NowPlayingPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    // when(
    //   () => mockNowPlayingMoviesBloc.state,
    // ).thenReturn(NowPlayingMoviesLoading());
    when(
      () => mockNowPlayingMoviesBloc.state,
    ).thenReturn(const NowPlayingMoviesSuccess([testMovie]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const NowPlayingPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(
      () => mockNowPlayingMoviesBloc.state,
    ).thenReturn(const NowPlayingMoviesFailed('Error message'));
    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const NowPlayingPage()));

    expect(textFinder, findsOneWidget);
  });
}

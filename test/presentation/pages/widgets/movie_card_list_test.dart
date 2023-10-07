import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final movie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  testWidgets('Test Moviecard Widget', (widgetTester) async {
    await widgetTester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: MovieCard(movie),
      ),
    ));

    expect(find.text('title'), findsOneWidget);
    expect(find.text('overview'), findsOneWidget);

    final imageFinder = find.byType(CachedNetworkImage);
    expect(imageFinder, findsOneWidget);

    final inkWellFinder = find.byType(InkWell);
    expect(inkWellFinder, findsOneWidget);
  });
}

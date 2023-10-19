import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/domain/entitites/movie.dart';

void main() {
  const movie = Movie(
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
    await widgetTester.pumpWidget(const MaterialApp(
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

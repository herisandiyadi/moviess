import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/presentation/widgets/tv_card_list.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv/domain/entities/tv.dart';

void main() {
  const tv = Tv(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'name',
    originCountry: ['us'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  testWidgets('Test TvCard Widget', (widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: TvCardList(tv),
      ),
    ));

    expect(find.text('name'), findsOneWidget);
    expect(find.text('overview'), findsOneWidget);

    final imageFinder = find.byType(CachedNetworkImage);
    expect(imageFinder, findsOneWidget);

    final inkWellFinder = find.byType(InkWell);
    expect(inkWellFinder, findsOneWidget);
  });
}

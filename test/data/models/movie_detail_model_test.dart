import 'package:ditonton/data/models/movie_detail_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final movieDetail = MovieDetailResponse(
    adult: false,
    backdropPath: 'backdropPath',
    budget: 1,
    genres: [],
    homepage: 'homepage',
    id: 1,
    imdbId: 'imdbId',
    originalLanguage: 'originalLanguage',
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    revenue: 1,
    runtime: 1,
    status: 'status',
    tagline: 'tagline',
    title: 'title',
    video: true,
    voteAverage: 1,
    voteCount: 1,
  );

  test('Test movie detail models ', () {
    final jsonResult = movieDetail.toJson();
    expect(jsonResult['id'], 1);
    expect(jsonResult['title'], 'title');
    expect(jsonResult['overview'], 'overview');
  });
}

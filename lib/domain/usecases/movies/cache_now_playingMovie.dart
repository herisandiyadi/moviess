import 'package:ditonton/data/models/movie_table.dart';

import 'package:ditonton/domain/repositories/movie_repository.dart';

class CacheNowPlayingMovie {
  final MovieRepository repository;

  CacheNowPlayingMovie(this.repository);

  Future<void> execute(List<MovieTable> movies) {
    return repository.cacheNowPlayingMovie(movies);
  }
}

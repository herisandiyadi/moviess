import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';

class CacheNowPlayingMovie {
  final MovieRepository repository;

  CacheNowPlayingMovie(this.repository);

  Future<void> execute(List<Movie> movies) {
    return repository.cacheNowPlayingMovie(movies);
  }
}

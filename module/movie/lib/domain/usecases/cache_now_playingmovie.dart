import 'package:movie/domain/entitites/movie.dart';
import 'package:movie/domain/repositories/movie_repository.dart';

class CacheNowPlayingMovie {
  final MovieRepository repository;

  CacheNowPlayingMovie(this.repository);

  Future<void> execute(List<Movie> movies) {
    return repository.cacheNowPlayingMovie(movies);
  }
}

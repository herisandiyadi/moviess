import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';

class GetCachedNowPlayingMovie {
  final MovieRepository repository;

  GetCachedNowPlayingMovie(this.repository);

  Future<List<MovieTable>> execute() {
    return repository.getCachedNowPlayingMovies();
  }
}

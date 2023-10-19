import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/domain/entitites/movie.dart';
import 'package:movie/domain/repositories/movie_repository.dart';

class GetCachedNowPlayingMovie {
  final MovieRepository repository;

  GetCachedNowPlayingMovie(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getCachedNowPlayingMovies();
  }
}

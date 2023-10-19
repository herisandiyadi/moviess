import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/domain/entitites/movie_detail.dart';
import 'package:movie/domain/repositories/movie_repository.dart';

class GetMovieDetail {
  final MovieRepository repository;

  GetMovieDetail(this.repository);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getMovieDetail(id);
  }
}
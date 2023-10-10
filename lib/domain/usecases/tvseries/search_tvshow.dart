import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class SearchTvShow {
  TVRepository repository;

  SearchTvShow(this.repository);

  Future<Either<Failure, List<Tv>>> execute(String query) {
    return repository.searchTvShow(query);
  }
}
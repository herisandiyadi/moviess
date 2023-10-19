import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/repositories/tv_repository.dart';

class SearchTvShow {
  TVRepository repository;

  SearchTvShow(this.repository);

  Future<Either<Failure, List<Tv>>> execute(String query) {
    return repository.searchTvShow(query);
  }
}

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class GetTvRecomendations {
  TVRepository tvRepository;

  GetTvRecomendations(this.tvRepository);

  Future<Either<Failure, List<Tv>>> execute(int id) {
    return tvRepository.getTvRecomendations(id);
  }
}

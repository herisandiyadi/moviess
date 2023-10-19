import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/repositories/tv_repository.dart';

class GetTvRecomendations {
  TVRepository tvRepository;

  GetTvRecomendations(this.tvRepository);

  Future<Either<Failure, List<Tv>>> execute(int id) {
    return tvRepository.getTvRecomendations(id);
  }
}

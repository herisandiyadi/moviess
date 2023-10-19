import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/repositories/tv_repository.dart';

class GetTVSeriesPopuler {
  TVRepository tvRepository;

  GetTVSeriesPopuler(this.tvRepository);

  Future<Either<Failure, List<Tv>>> execute() {
    return tvRepository.getTvSeriesPopuler();
  }
}

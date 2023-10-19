import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/repositories/tv_repository.dart';

class GetTvDetail {
  TVRepository tvRepository;

  GetTvDetail(this.tvRepository);

  Future<Either<Failure, TvDetail>> execute(int id) {
    return tvRepository.getTvDetail(id);
  }
}
